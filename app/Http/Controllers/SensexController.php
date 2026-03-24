<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Cache;
use App\Services\UpstoxMarketService;
 
class SensexController extends Controller
{
      protected UpstoxMarketService $market;

    public function __construct(UpstoxMarketService $market)
    {
        $this->market = $market;
    }

    public function index()
    {
        $data = Cache::remember('sensex_page_data', 60, function () {

        $niftyQuote  = $this->market->getQuote("NSE_INDEX|Nifty 50") ?? [];
        $sensexQuote = $this->market->getQuote("BSE_INDEX|SENSEX") ?? [];
        // Upstox quotes
       $niftyStocks  = $this->getIndexStocks("nifty-50");
        $sensexStocks = $this->getIndexStocks("sensex");
        $bankNiftyStocks = $this->getIndexStocks("nifty-bank");
        $niftyITStocks = $this->getIndexStocks("nifty-it");

        // Format data for Blade charts
        $nifty = [
            'price' => $niftyQuote['last_price'] ?? 0,
            'change' => $niftyQuote['net_change'] ?? 0,
            'percent' => isset($niftyQuote['net_change'], $niftyQuote['last_price']) && $niftyQuote['last_price'] != 0
                ? round(($niftyQuote['net_change'] / ($niftyQuote['last_price'] - $niftyQuote['net_change'])) * 100, 2)
                : 0,
            'timestamps' => [],
            'closes' => []
        ];

        $sensex = [
            'price' => $sensexQuote['last_price'] ?? 0,
            'change' => $sensexQuote['net_change'] ?? 0,
            'percent' => isset($sensexQuote['net_change'], $sensexQuote['last_price']) && $sensexQuote['last_price'] != 0
                ? round(($sensexQuote['net_change'] / ($sensexQuote['last_price'] - $sensexQuote['net_change'])) * 100, 2)
                : 0,
            'timestamps' => [],
            'closes' => []
        ];

        // Fetch intraday candles for charts
        $niftyCandles = $this->market->getIntradayCandles("NSE_INDEX|Nifty 50");
        if (!empty($niftyCandles)) {
            foreach ($niftyCandles as $candle) {
                $nifty['timestamps'][] = strtotime($candle[0]); // assuming $candle[0] is datetime
                $nifty['closes'][] = (float)$candle[4]; // assuming close price at index 4
            }
        }

        $sensexCandles = $this->market->getIntradayCandles("BSE_INDEX|SENSEX");
        if (!empty($sensexCandles)) {
            foreach ($sensexCandles as $candle) {
                $sensex['timestamps'][] = strtotime($candle[0]);
                $sensex['closes'][] = (float)$candle[4];
            }
        }
 $niftyStocks  = $this->getIndexStocks("nifty-50");
            $sensexStocks = $this->getIndexStocks("sensex");
        // Market news
        $marketNews = $this->getMarketNews();

        return compact(
            'nifty',
            'sensex', 
            'marketNews',
            'niftyStocks',
            'sensexStocks',
            'bankNiftyStocks',
            'niftyITStocks'
        );
 });

return view('sensex.index', $data);

}

    protected function getMarketNews()
    {
        $response = Http::timeout(10)->get('https://newsapi.org/v2/everything', [
            'q' => '(Sensex OR "Nifty 50" OR NSE OR BSE OR "stock market")',
            'language' => 'en',
            'sortBy' => 'publishedAt',
            'pageSize' => 15,
            'from' => now()->subDays(7)->toDateString(),
            'domains' => 'economictimes.indiatimes.com,moneycontrol.com,business-standard.com,livemint.com,cnbctv18.com',
            'apiKey' => env('NEWS_API_KEY'),
        ]);

        if ($response->successful()) {
            $articles = $response->json()['articles'] ?? [];
            return collect($articles)
                ->filter(fn($a) => !empty($a['title']))
                ->unique('title')
                ->values()
                ->toArray();
        }

        return [];
    }
 
  protected function getIndexStocks($index)
{
    try {
        if ($index == "nifty-50") {
            $url = "https://www.nseindia.com/api/equity-stockIndices?index=NIFTY%2050";
        }
        elseif ($index == "nifty-bank") {
            $url = "https://www.nseindia.com/api/equity-stockIndices?index=NIFTY%20BANK";
        }
        elseif ($index == "nifty-it") {
            $url = "https://www.nseindia.com/api/equity-stockIndices?index=NIFTY%20IT";
        }
       elseif ($index == "sensex") { 
            $sensexCompanies = [
        "Reliance Industries","HDFC Bank","ICICI Bank","Infosys","TCS",
        "Hindustan Unilever","ITC","Larsen & Toubro","Axis Bank",
        "Kotak Mahindra Bank","Bharti Airtel","State Bank of India",
        "Asian Paints","Bajaj Finance","Bajaj Finserv",
        "Maruti Suzuki","Mahindra & Mahindra","Sun Pharma",
        "Titan Company","UltraTech Cement","NTPC",
        "Power Grid","Tata Motors","Wipro",
        "Tech Mahindra","Nestle India","IndusInd Bank",
        "JSW Steel","HCL Technologies","Adani Ports"
    ];

    $url = "https://api.bseindia.com/BseIndiaAPI/api/IndexWeightage/w?indexcode=16";

    try {

        $response = Http::withHeaders([
            'User-Agent' => 'Mozilla/5.0',
            'Accept' => 'application/json',
            'Referer' => 'https://www.bseindia.com/'
        ])->timeout(15)->get($url);

        if ($response->successful()) {

            $rows = $response->json()['Table'] ?? [];

            $stocks = [];

            foreach ($rows as $row) {

                $stocks[] = [
                    'name' => $row['ScripName'] ?? 'N/A',
                    'exchange' => 'BSE',
                    'price' => $row['Price'] ?? 'N/A',
                    'change' => $row['Change'] ?? 'N/A',
                    'percent' => $row['PercentChange'] ?? 'N/A',
                    'volume' => 'N/A',
                    'pe' => 'N/A',
                    'marketcap' => $row['MarketCap'] ?? 'N/A'
                ];
            }

            if (!empty($stocks)) {
                return $stocks;
            }
        }

    } catch (\Exception $e) {}

    // fallback if API fails
    $fallback = [];

    foreach ($sensexCompanies as $company) {
        $fallback[] = [
            'name' => $company,
            'exchange' => 'BSE',
            'price' => 'N/A',
            'change' => 'N/A',
            'percent' => 'N/A',
            'volume' => 'N/A',
            'pe' => 'N/A',
            'marketcap' => 'N/A'
        ];
    }
    return $fallback;
       }
        else {
            return [];
        }
        $response = Http::withHeaders([
            'User-Agent' => 'Mozilla/5.0',
            'Accept' => 'application/json',
            'Referer' => 'https://www.nseindia.com/'
        ])->timeout(15)->get($url);
        if (!$response->successful()) {
            return [];
        }
        $json = $response->json();
        // NSE response
        if ($index != "sensex") {
            $rows = $json['data'] ?? [];
        }
        // BSE response
        else {
            $rows = $json['Table'] ?? [];
        }
        $stocks = [];
        foreach ($rows as $row) {
            $stocks[] = [
                'name'      => $row['symbol'] ?? $row['scripname'] ?? '',
                'exchange'  => $index == "sensex" ? "BSE" : "NSE",
                'price'     => $row['lastPrice'] ?? $row['ltp'] ?? '',
                'change'    => $row['change'] ?? $row['changeVal'] ?? '',
                'percent'   => $row['pChange'] ?? $row['percentChange'] ?? '',
                'volume'    => $row['totalTradedVolume'] ?? '',
                'pe'        => $row['pe'] ?? '',
                'marketcap' => $row['marketCap'] ?? '',
            ];
        }
        return $stocks;
    } catch (\Exception $e) {
        return [];
    }
}
}
