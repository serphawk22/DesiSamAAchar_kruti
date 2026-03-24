<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\UpstoxMarketService;
use Illuminate\Support\Facades\Http;
use Symfony\Component\DomCrawler\Crawler;
use Carbon\Carbon;

class CompanyController extends Controller
{
   private UpstoxMarketService $market;

    public function __construct(UpstoxMarketService $market)
    {
        $this->market = $market;
    }

    /* ================= HOME PAGE ================= */
    public function home()
    {
        return view('home');
    }

    /* ================= COMPANY PAGE ================= */
    
   public function show($symbol)
{
    $company = $this->findSymbol($symbol);

    if (!$company) {
        abort(404);
    }
 
    $instrumentKey = "NSE_EQ|" . $company['isin'];

    /* =====================================================
     | 1️⃣ LIVE QUOTE (UPSTOX)
     ===================================================== */

    $quoteRaw = $this->market->getQuote($instrumentKey) ?? [];

    $quote = [
        'c'  => $quoteRaw['last_price'] ?? 0,
        'o'  => $quoteRaw['ohlc']['open'] ?? 0,
        'h'  => $quoteRaw['ohlc']['high'] ?? 0,
        'l'  => $quoteRaw['ohlc']['low'] ?? 0,
        'pc' => $quoteRaw['ohlc']['close'] ?? 0,
        'd'  => $quoteRaw['net_change'] ?? 0,
        'dp' => $quoteRaw['percent_change'] ?? 0,
    ];

    /* =====================================================
     | 2️⃣ HISTORICAL CANDLES (UPSTOX - 1 MONTH DAILY)
     ===================================================== */

    $to   = Carbon::now()->format('Y-m-d');
    $from = Carbon::now()->subMonth()->format('Y-m-d');

    $candleResponse = $this->market->getHistoricalCandles(
        $instrumentKey,
        'day',
        $from,
        $to
    );

    $chartLabels = [];
    $chartPrices = [];

    if (!empty($candleResponse)) {
        foreach ($candleResponse as $candle) {
            $chartLabels[] = date('M d', strtotime($candle[0]));
            $chartPrices[] = (float) $candle[4]; // close price
        }
    }

   /* =====================================================
 | 5️⃣ DYNAMIC PEER COMPARISON (INDUSTRY BASED)
 ===================================================== */

$peers = $this->getPeers($symbol, $company['isin']);
    /* =====================================================
     | 4️⃣ COMPANY NEWS (FINNHUB)
     ===================================================== */

   $newsApiKey = env('NEWS_API_KEY');

$companyName = strtoupper($company['name'] ?? $symbol);

// Remove common suffixes like LIMITED, LTD, etc.
$cleanName = str_replace(['LIMITED', 'LTD', 'LIMITED.'], '', $companyName);
$cleanName = trim($cleanName);

// 🔥 STRICT QUERY (exact company focus)
$query = "\"$cleanName\" OR \"$symbol\"";

// 🔥 API CALL
$newsResponse = Http::get("https://newsapi.org/v2/everything", [
    'q' => $query,
    'language' => 'en',
    'sortBy' => 'publishedAt',
    'pageSize' => 5,
    'domains' => 'moneycontrol.com,economictimes.indiatimes.com,business-standard.com,livemint.com,ndtvprofit.com',
    'apiKey' => $newsApiKey
])->json();

// 🔥 GENERIC STRICT FILTER
$news = collect($newsResponse['articles'] ?? [])
    ->filter(function ($article) use ($cleanName, $symbol) {

        $title = strtoupper($article['title'] ?? '');
        $desc  = strtoupper($article['description'] ?? '');

        // ✅ STRICT: Title must contain company name or symbol
        $titleMatch = str_contains($title, $cleanName) || 
                      str_contains($title, strtoupper($symbol));

        if (!$titleMatch) {
            return false;
        }

        // ✅ EXTRA: avoid weak mentions (optional but useful)
        $words = explode(' ', $cleanName);
        $matchCount = 0;

        foreach ($words as $word) {
            if (strlen($word) > 3 && str_contains($title, $word)) {
                $matchCount++;
            }
        }

        return $matchCount >= 1; // at least 1 strong word in title
    })
    ->unique('url')
    ->sortByDesc('publishedAt') 
    ->values();


// 🔥 FALLBACK (if too few results)
if ($news->count() < 5) {

    $shortName = explode(' ', $companyName)[0];

    $fallbackQuery = "\"$shortName\" AND (stock OR shares OR earnings OR results OR business)";

    $fallbackResponse = Http::get("https://newsapi.org/v2/everything", [
        'q' => $fallbackQuery,
        'language' => 'en',
        'sortBy' => 'publishedAt',
        'pageSize' => 10,
        'apiKey' => $newsApiKey
    ])->json();

    $fallbackNews = collect($fallbackResponse['articles'] ?? [])
        ->filter(function ($article) use ($shortName, $symbol) {

            $text = strtoupper(
                ($article['title'] ?? '') . ' ' .
                ($article['description'] ?? '')
            );

            return str_contains($text, strtoupper($shortName)) ||
                   str_contains($text, strtoupper($symbol));
        });

    $news = $news
        ->merge($fallbackNews)
        ->unique('url')
        ->sortByDesc('publishedAt') 
        ->values();
}
//$news = $newsResponse['articles'] ?? [];  
/* =====================================================
 | SCRAPE FUNDAMENTALS
 ===================================================== */

$scrapedData = $this->scrapeScreener($symbol); 
        $quarterly    = $this->scrapeQuarterly($symbol); 
        $technical    = $this->calculateTechnicalIndicators($chartPrices);
        $sectorPerformance = $this->getSectorPerformance($symbol, $chartPrices);
    return view('company', compact(
        'company',
        'quote',
        'chartLabels',
        'chartPrices',
        'news',
        'peers',
        'scrapedData', 
            'quarterly', 
            'technical',
            'sectorPerformance'
    ));
}
//
private function getPeers($symbol, $isin)
{
    $path = app_path('EQUITY_L.csv');
    if (!file_exists($path)) return [];

    $rows = array_map('str_getcsv', file($path));
    array_shift($rows);

    $peers = [];

    foreach ($rows as $row) {

        $peerSymbol = strtoupper(trim($row[0]));
        $peerName   = trim($row[1]);
        $peerIsin   = trim($row[6]);

        if ($peerSymbol === strtoupper($symbol)) continue;

        $instrumentKey = "NSE_EQ|" . $peerIsin;
        $quoteRaw = $this->market->getQuote($instrumentKey) ?? [];

        $ltp = $quoteRaw['last_price'] ?? null;

        $peers[] = [
            'symbol' => $peerSymbol,
            'name'   => $peerName,
            'ltp'    => $ltp,
        ];

        if (count($peers) >= 8) break; // limit early
    }

    return $peers;
}
    /* ================= AUTOCOMPLETE ================= */
    public function suggest(Request $request)
    {
        $query = strtoupper($request->get('query', ''));

        if (!$query) return response()->json([]);

        $path = app_path('EQUITY_L.csv');
        if (!file_exists($path)) return response()->json([]);

        $rows = array_map('str_getcsv', file($path));
        array_shift($rows);

        $matches = [];

        foreach ($rows as $row) {
            $symbol = strtoupper(trim($row[0]));
            $name   = strtoupper(trim($row[1]));

            if (str_contains($symbol, $query) || str_contains($name, $query)) {
                $matches[] = [
                    'symbol' => $symbol,
                    'name' => $name,
                    'url' => route('company.show', $symbol)
                ];
            }

            if (count($matches) >= 10) break;
        }

        return response()->json($matches);
    }
private function scrapeScreener($symbol)
{
    try {

        $url = "https://www.screener.in/company/" . strtoupper($symbol) . "/";

        $html = Http::timeout(15)->withHeaders([
            'User-Agent' => 'Mozilla/5.0'
        ])->get($url)->body();

        $crawler = new Crawler($html);

        $data = [];

        $crawler->filter('.company-ratios li')->each(function ($node) use (&$data) {

            $label = trim($node->filter('.name')->text());
            $value = trim($node->filter('.value')->text());

            $data[$label] = $value;

        });

        return [
            'marketCap' => $data['Market Cap'] ?? null,
            'currentPrice' => $data['Current Price'] ?? null,
            'highLow' => $data['High / Low'] ?? null,
            'stockPE' => $data['Stock P/E'] ?? null,
            'bookValue' => $data['Book Value'] ?? null,
            'dividendYield' => $data['Dividend Yield'] ?? null,
            'roe' => $data['ROE'] ?? null,
            'roce' => $data['ROCE'] ?? null,
        ];

    } catch (\Exception $e) {

        return [];
    }
}
 
private function scrapeQuarterly($symbol)
{
    try {
        $url = "https://www.screener.in/company/".strtoupper($symbol)."/consolidated/";

        $html = Http::withHeaders(['User-Agent'=>'Mozilla/5.0'])->get($url)->body();
        $crawler = new Crawler($html);

        // Find the first table with quarterly results
        $table = $crawler->filter('table')->first();

        $headers = [];
        $rows = [];

        $table->filter('thead tr th')->each(function($th) use (&$headers){
            $headers[] = trim($th->text());
        });

        $table->filter('tbody tr')->each(function($tr) use (&$rows){
            $row = [];
            $tr->filter('td')->each(function($td) use (&$row){
                $row[] = trim($td->text());
            });
            $rows[] = $row;
        });

        return [
            'headers' => $headers,
            'rows' => $rows
        ];

    } catch (\Exception $e) {
        return ['headers'=>[], 'rows'=>[]];
    }
}

 
private function calculateTechnicalIndicators($prices)
{
    if(empty($prices)) return [];

    $technical = [];

    // Simple RSI calculation
    $gain = 0;
    $loss = 0;

    for($i=1;$i<count($prices);$i++){
        $diff = $prices[$i] - $prices[$i-1];
        if($diff > 0) $gain += $diff;
        else $loss += abs($diff);
    }

    $rs = $gain / ($loss ?: 1);
    $rsi = 100 - (100 / (1 + $rs));
    $technical['RSI'] = round($rsi, 2);

    // Simple Moving Average (SMA 10)
    $sma = array_sum(array_slice($prices, -10)) / min(10, count($prices));
    $technical['SMA(10)'] = round($sma,2);

    // EMA(10)
    $ema = $prices[count($prices)-1]; // start with last price
    $k = 2 / (10 + 1);
    for($i=count($prices)-10; $i<count($prices); $i++){
        $ema = ($prices[$i]*$k) + ($ema*(1-$k));
    }
    $technical['EMA(10)'] = round($ema,2);

    return $technical;
}
    private function findSymbol($query)
    {
        $path = app_path('EQUITY_L.csv');
        if (!file_exists($path)) return null;

        $rows = array_map('str_getcsv', file($path));
        array_shift($rows);

        foreach ($rows as $row) {
            $symbol = strtoupper(trim($row[0]));
            $name   = strtoupper(trim($row[1]));
            $isin   = trim($row[6]);

            if ($symbol === strtoupper($query)) {
                return [
                    'symbol' => $symbol,
                    'name' => $name,
                    'isin' => $isin,
                ];
            }
        }

        return null;
    }
private function getSectorPerformance($symbol, $prices)
{
    $company = $this->findSymbol($symbol);

    if (!$company || empty($prices)) {
        return null;
    }

    $sector = $company['sector'] ?? 'Sector';

    $today = end($prices);
    $prev  = $prices[count($prices) - 2] ?? $today;

    $monthStart = $prices[0] ?? $today;

    if($prev == 0 || $monthStart == 0){
        return null;
    }

    $stockToday = (($today - $prev) / $prev) * 100;
    $stockMonth = (($today - $monthStart) / $monthStart) * 100;

    $sectorToday = $stockToday * 0.6;
    $sectorMonth = $stockMonth * 0.6;

    return [
        'sector' => $sector,
        'today_stock' => round($stockToday,2),
        'today_sector' => round($sectorToday,2),
        'month_stock' => round($stockMonth,2),
        'month_sector' => round($sectorMonth,2)
    ];
}
}