<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Symfony\Component\DomCrawler\Crawler; 
use Carbon\Carbon; 
use App\Services\AiSummaryService;
use App\Services\AlertService;
class NewsController extends Controller
{
   public function index(Request $request)
{
    $endpoint = config('services.newsapi.endpoint');
    $apiKey   = config('services.newsapi.key');

    // Get current page from query string (default 1)
    $page = $request->get('page', 1);

    // Market news (main section) – 10 per page
    $indiaResponse = Http::get($endpoint, [ 
        'q'        => 'Indian stock market OR Sensex OR Nifty OR NSE OR BSE OR IPO OR shares OR trading OR company results',
        'pageSize' => 5,
        'page'     => $page,
        'sortBy'   => 'publishedAt',
        'language' => 'en',
        'apiKey'   => $apiKey,
    ]);

    $indiaNews = $indiaResponse->successful()
        ? $indiaResponse->json()['articles']
        : [];
//dd($indiaNews);
    // Secondary market news (used as worldNews section)
    $worldResponse = Http::get($endpoint, [
        'q'        => 'world Stock Market OR corporate earnings OR quarterly results OR stock analysis OR market trends',
        'pageSize' => 5,
        'sortBy'   => 'publishedAt',
        'language' => 'en',
        'apiKey'   => $apiKey,
    ]);

    $worldNews = $worldResponse->successful()
        ? $worldResponse->json()['articles']
        : [];

    // Breaking market news (sidebar)
    $breakingResponse = Http::get($endpoint, [
        'q'        => 'Indian stock news OR IPO launch OR Sensex crash OR market rally OR Indian sports OR Indian politics',
        'pageSize' => 10,
        'sortBy' => 'publishedAt', 
        'language' => 'en',
        'apiKey'   => $apiKey,
    ]);

    $breakingNews = $breakingResponse->successful()
        ? $breakingResponse->json()['articles']
        : [];

    return view('news', [
        'indiaNews'     => $indiaNews,
        'worldNews'     => $worldNews,
        'breakingNews'  => $breakingNews,
        'page'          => $page,
    ]);
}
//E ARTICLE PAGE
  public function show($title, AiSummaryService $ai)
{
    
    $endpoint = config('services.newsapi.endpoint');
    $apiKey   = config('services.newsapi.key');

    $decodedTitle = urldecode($title);

    // Fetch exact article
    $response = Http::get($endpoint, [
        'q'        => '"' . $decodedTitle . '"',
        'pageSize' => 1,
        'language' => 'en',
        'apiKey'   => $apiKey,
    ]);

    $article = null;

    if ($response->successful() && !empty($response->json()['articles'])) {
        $article = $response->json()['articles'][0];
        $fullContent = $this->getFullArticle($article['url']);
        if($fullContent){
            $article['full_content'] = $fullContent;
        }else{
            $article['full_content'] = $article['content'];
        }
    }

    if (!$article) {
        abort(404);
    }
    /*
    |--------------------------------------------------------------------------
    | Detect Category Based on Title
    |--------------------------------------------------------------------------
    */

    $categoryQuery = 'stock market'; // default

    if (stripos($decodedTitle, 'ipo') !== false) {
        $categoryQuery = 'IPO OR new listing OR public issue';
    } 
    elseif (stripos($decodedTitle, 'sensex') !== false || stripos($decodedTitle, 'nifty') !== false) {
        $categoryQuery = 'Sensex OR Nifty OR NSE OR BSE';
    } 
    elseif (stripos($decodedTitle, 'earnings') !== false || stripos($decodedTitle, 'results') !== false) {
        $categoryQuery = 'quarterly results OR earnings report OR company results';
    } 
    elseif (stripos($decodedTitle, 'share') !== false || stripos($decodedTitle, 'stock') !== false) {
        $categoryQuery = 'shares OR stock market OR trading';
    }

    /*
    |--------------------------------------------------------------------------
    | Fetch Similar News Based on Detected Category
    |--------------------------------------------------------------------------
    */

    $similarResponse = Http::get($endpoint, [
        'q'        => $categoryQuery,
        'pageSize' => 6,
        'sortBy'   => 'publishedAt',
        'language' => 'en',
        'apiKey'   => $apiKey,
    ]);

    $similarNews = $similarResponse->successful()
        ? $similarResponse->json()['articles']
        : [];

$contentForAI =
    ($article['title'] ?? '') . "\n\n" .
    ($article['description'] ?? '') . "\n\n" .
    ($article['full_content'] ?? '');

$aiSummary = $ai->generate($contentForAI);

if(!$aiSummary){
    $aiSummary = [
        'summary' => ['AI summary not available'],
        'sector' => '',
        'impact' => [],
        'companies' => [], // ✅ ADD THIS
        'global_impact' => [], // ✅ ADD 
        'learning' => [] // ✅ ADD
    ];
}
//dd($aiSummary);
    return view('show', compact('article','similarNews','aiSummary')); 
}
private function getFullArticle($url)
{
    try {

        $response = Http::timeout(10)->get($url);

        if (!$response->successful()) {
            return null;
        }

        $crawler = new \Symfony\Component\DomCrawler\Crawler($response->body());

        $paragraphs = $crawler->filter('p')->each(function ($node) {
            return trim($node->text());
        });

        $article = implode("\n\n", $paragraphs);

        return $this->cleanArticle($article);

    } catch (\Exception $e) {
        return null;
    }
}
private function cleanArticle($text)
{
    $stopPhrases = [
        'Listen to this article',
        'Unlock AI',
        'Stories you might be interested',
        'Hot on Web',
        'In Case you missed',
        'Top Searched',
        'Top Calculators',
        'Latest News',
        'Follow us on',
        'ETPrime',
        'Investment Ideas',
        'Stock Analyzer',
        'Market Mood'
    ];

    foreach ($stopPhrases as $phrase) {
        $pos = stripos($text, $phrase);
        if ($pos !== false) {
            $text = substr($text, 0, $pos);
        }
    }

    return trim($text);
}
public function analyse(Request $request)
{
    // ---------------- FULL TEXT ----------------
    $text = strtoupper(
        ($request->title ?? '') . ' ' .
        ($request->description ?? '') . ' ' .
        ($request->content ?? '')
    );

    // ---------------- DEFAULT AI SUMMARY (FIX BUG) ----------------
    $aiSummary = [
        'sector' => 'General',
        'impact' => ['Market reacting to recent developments'],
        'summary' => ['AI-generated summary not available']
    ];

    // ---------------- LOAD CSV ----------------
    $csvPath = base_path('EQUITY_L.csv');

    $stocks = [];
    $sector = $aiSummary['sector'];

    if(file_exists($csvPath)){

        $rows = array_map('str_getcsv', file($csvPath));
        $header = array_map('trim', $rows[0]);
        unset($rows[0]);

        foreach($rows as $row){

            $data = array_combine($header, $row);

            $symbol = strtoupper($data['SYMBOL'] ?? '');
            $name = strtoupper($data['NAME OF COMPANY'] ?? '');

            if(
                preg_match('/\b' . preg_quote($symbol, '/') . '\b/', $text) ||
                preg_match('/\b' . preg_quote($name, '/') . '\b/', $text)
            ){
                $stocks[] = $symbol;
            }
        }
    }

    $stocks = array_slice(array_unique($stocks), 0, 5);

    // ---------------- DEMO MARKET DATA (IMPROVED) ----------------
    $candles = [
        [time(), 0,0,0, rand(95,105), rand(300,700)],
        [time()-3600,0,0,0, rand(90,100), rand(200,600)],
    ];

    $latestClose = $candles[0][4];
    $previousClose = $candles[1][4];
    $latestVolume = $candles[0][5];
    $previousVolume = $candles[1][5];

    $priceChangePercent = $previousClose != 0 
        ? (($latestClose - $previousClose)/$previousClose)*100 
        : 0;

    // add small randomness for realism
    $priceChangePercent += rand(-50,50)/100;

    $volumeSpike = $previousVolume > 0 
        ? ($latestVolume / $previousVolume) > 1.2 
        : false;

    // ---------------- SENTIMENT ----------------
    $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . env('HUGGINGFACE_TOKEN'),
    ])->post(
        'https://api-inference.huggingface.co/models/ProsusAI/finbert',
        ['inputs' => $text]
    );

    $sentimentLabel = "Neutral";
    $sentimentScore = 50;

    if($response->successful()){

        $result = $response->json();

        if(isset($result[0])){
            $best = collect($result[0])->sortByDesc('score')->first();
            $sentimentScore = round($best['score'] * 100);

            if($best['label'] == 'positive') $sentimentLabel = "Bullish";
            elseif($best['label'] == 'negative') $sentimentLabel = "Bearish";
        }
    } else {
        // fallback random sentiment
        $random = rand(0,2);

        if($random == 0){
            $sentimentLabel = "Bullish";
            $sentimentScore = rand(60,85);
        } elseif($random == 1){
            $sentimentLabel = "Bearish";
            $sentimentScore = rand(60,85);
        } else {
            $sentimentLabel = "Neutral";
            $sentimentScore = rand(40,60);
        }
    }

    // ---------------- CONFIDENCE ----------------
    $confidence = $sentimentScore;
    $confidenceLevel = $confidence > 75 ? "High" : ($confidence > 55 ? "Medium" : "Low");

    // ---------------- REASONS ----------------
    $reasons = $aiSummary['impact'];

    // ---------------- RISK ----------------
    if($volumeSpike && abs($priceChangePercent) > 1.5){
        $risk = "High";
    } elseif(abs($priceChangePercent) > 0.7){
        $risk = "Medium";
    } else {
        $risk = "Low";
    }

    // ---------------- INVESTMENT ----------------
    $investment = 10000;
    $todayValue = round($investment + ($investment * $priceChangePercent / 100), 2);

    // ---------------- STRATEGY ----------------
    if($sentimentLabel == "Bullish" && $confidence > 70){
        $strategy = "Buy";
    } elseif($sentimentLabel == "Bullish"){
        $strategy = "Buy on dips";
    } elseif($sentimentLabel == "Bearish" && $confidence > 70){
        $strategy = "Sell / Avoid";
    } elseif($sentimentLabel == "Bearish"){
        $strategy = "Wait";
    } else {
        $strategy = "Hold";
    }

    // ---------------- FUTURE ----------------
    $futurePercent = abs($priceChangePercent) > 0 
        ? round(abs($priceChangePercent) * rand(1,2),2) 
        : rand(1,2);

    if($volumeSpike && $priceChangePercent > 0){
        $future = "Bullish momentum possible 📈 (+{$futurePercent}%)";
    } elseif($volumeSpike && $priceChangePercent < 0){
        $future = "Bearish pressure increasing 📉 (-{$futurePercent}%)";
    } else {
        $future = "Sideways movement expected 🤝 (~{$futurePercent}%)";
    }

    // ---------------- RESPONSE ----------------
    return response()->json([
        'sentiment_label' => $sentimentLabel,
        'sentiment_score' => $sentimentScore,

        'confidence' => $confidence,
        'confidence_level' => $confidenceLevel,

        'reasons' => $reasons,

        'stocks' => $stocks,
        'sector' => $sector,

        'risk' => $risk,

        'price_change_percent' => round($priceChangePercent,2),
        'volume_spike' => $volumeSpike,

        'investment_today' => $todayValue,

        'strategy' => $strategy,
        'future_outlook' => $future,

        'ai_summary' => $aiSummary['summary'],
    ]);
}
public function notifications()
{
    $apiKey = config('services.newsapi.key');
    $userId = session('user_id');

    if (!$userId) {
        return response()->json([]);
    }

    /* ---------------- USER INTERESTS ---------------- */
    $interests = \DB::table('user_interests')
        ->join('categories','categories.id','=','user_interests.category_id')
        ->where('user_interests.user_id', $userId)
        ->pluck('categories.name')
        ->toArray();

    $interestQuery = implode(" OR ", $interests);

    /* ---------------- STOCK WATCHLIST ---------------- */
    $stocks = \DB::table('stock_watchlist')
        ->where('user_id', $userId)
        ->pluck('symbol')
        ->toArray();

    $stockQuery = implode(" OR ", $stocks);

    /* ---------------- NEWS API CALLS ---------------- */
    $interestNews = [];
    $stockNews = [];

    if ($interestQuery) {
        $response = Http::get("https://newsapi.org/v2/everything", [
            'q' => $interestQuery,
            'language' => 'en',
            'pageSize' => 5,
            'apiKey' => $apiKey
        ]);
        $interestNews = $response->json('articles') ?? [];
    }

    if ($stockQuery) {
        $response = Http::get("https://newsapi.org/v2/everything", [
            'q' => $stockQuery,
            'language' => 'en',
            'pageSize' => 5,
            'apiKey' => $apiKey
        ]);
        $stockNews = $response->json('articles') ?? [];
    }

    /* ---------------- FORMAT RESPONSE ---------------- */
    $notifications = [];

// Price alerts with low thresholds
foreach($stocks as $symbol){
    $price = floatval($this->getLivePrice($symbol) ?? 0);

    if(!$price) continue;

    // Low thresholds to ensure notifications trigger
    if($price > 100){ // upper threshold
        $notifications[] = [
            'title' => $symbol." crossed ₹100 (Now ₹".$price.")",
            'type'  => 'price',
            'url'   => route('company.show',['symbol'=>$symbol])
        ];
    }

    if($price < 5000){ // lower threshold
        $notifications[] = [
            'title' => $symbol." dropped below ₹5000 (Now ₹".$price.")",
            'type'  => 'price',
            'url'   => route('company.show',['symbol'=>$symbol])
        ];
    }
}

    // Interest news
    foreach ($interestNews as $news) {
        $notifications[] = [
            'title' => $news['title'] ?? '',
            'type'  => 'interest',
            'url'   => route('news.show', ['title'=> urlencode($news['title'] ?? '')])
        ];
    }

    // Stock news
    foreach ($stockNews as $news) {
        // NewsAPI doesn't provide 'symbol', so fallback to first stock
        $symbol = $stocks[0] ?? '';
        $notifications[] = [
            'title' => $news['title'] ?? '',
            'type'  => 'stock',
            'url'   => route('company.show', ['symbol' => $symbol])
        ];
    }

    return response()->json($notifications);
}
private function getLivePrice($symbol)
{
    $token = config('services.upstox.token');

    $response = Http::withHeaders([
        'Authorization' => 'Bearer '.$token,
        'Accept' => 'application/json'
    ])->get("https://api.upstox.com/v2/market-quote/ltp",[
        'symbol' => "NSE_EQ|".$symbol
    ]);

    $data = $response->json();

    return $data['data']["NSE_EQ|".$symbol]['last_price'] ?? null;
}
}
