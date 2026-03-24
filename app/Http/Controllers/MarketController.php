<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;
use App\Models\Index;
use App\Models\Stock;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Pagination\Paginator;
use Illuminate\Support\Facades\Cache;
use App\Models\Catagories;
use App\Models\Subcatagory;
use App\Models\Articles;
use App\Models\ArticleMedia;
use App\Models\Users;
use Illuminate\Support\Carbon;
use Illuminate\Support\Collection;
use App\Services\UpstoxMarketService;

class MarketController extends Controller
{
    public function home(UpstoxMarketService $market)
{
    // =========================
// CHECK SESSION LOGIN
// =========================
if (session()->has('user_role')) {

    $role = session('user_role');

    if ($role === 'admin') {
        return redirect()->route('admin.dashboard')
            ->with('success', 'Welcome Admin');
    }

    if ($role === 'editor') {
        return redirect()->route('editor.dashboard')
            ->with('success', 'Welcome Editor');
    }
}
    $data = Cache::remember('home_page_data', 60, function () use ($market) {
    $nifty      = "NSE_INDEX|Nifty 50";
    $sensex     = "BSE_INDEX|SENSEX";
    $bankNifty  = "NSE_INDEX|Nifty Bank";
    $niftyIT    = "NSE_INDEX|Nifty IT";

    $niftyQuote      = $market->getQuote($nifty) ?? [];
    $sensexQuote     = $market->getQuote($sensex) ?? [];
    $bankNiftyQuote  = $market->getQuote($bankNifty) ?? [];
    $niftyITQuote    = $market->getQuote($niftyIT) ?? [];

    // Chart candles for NIFTY 50
    $candles = $market->getIntradayCandles($nifty);

    $labels = [];
    $prices = [];

    foreach ($candles as $candle) {
        $labels[] = date('H:i', strtotime($candle[0]));
        $prices[] = (float) $candle[4];
    }

      // =========================
    // CLEAR OLD DATA
    // =========================
    \App\Models\Index::truncate();
    \App\Models\Stock::truncate();

    // =========================
    // PREPARE INDEX DATA
    // =========================
    $indexDataToSave = [
        [
            'symbol' => $nifty,
            'name'   => 'NIFTY 50',
            'price'  => $niftyQuote['last_price'] ?? 0,
            'change_pts' => $niftyQuote['net_change'] ?? 0,
            'change_percent' => isset($niftyQuote['net_change'], $niftyQuote['last_price'])
                ? round(($niftyQuote['net_change'] / ($niftyQuote['last_price'] - $niftyQuote['net_change'])) * 100, 2)
                : 0,
        ],
        [
            'symbol' => $sensex,
            'name'   => 'SENSEX',
            'price'  => $sensexQuote['last_price'] ?? 0,
            'change_pts' => $sensexQuote['net_change'] ?? 0,
            'change_percent' => isset($sensexQuote['net_change'], $sensexQuote['last_price'])
                ? round(($sensexQuote['net_change'] / ($sensexQuote['last_price'] - $sensexQuote['net_change'])) * 100, 2)
                : 0,
        ],
        [
            'symbol' => $bankNifty,
            'name'   => 'NIFTY BANK',
            'price'  => $bankNiftyQuote['last_price'] ?? 0,
            'change_pts' => $bankNiftyQuote['net_change'] ?? 0,
            'change_percent' => isset($bankNiftyQuote['net_change'], $bankNiftyQuote['last_price'])
                ? round(($bankNiftyQuote['net_change'] / ($bankNiftyQuote['last_price'] - $bankNiftyQuote['net_change'])) * 100, 2)
                : 0,
        ],
        [
            'symbol' => $niftyIT,
            'name'   => 'NIFTY IT',
            'price'  => $niftyITQuote['last_price'] ?? 0,
            'change_pts' => $niftyITQuote['net_change'] ?? 0,
            'change_percent' => isset($niftyITQuote['net_change'], $niftyITQuote['last_price'])
                ? round(($niftyITQuote['net_change'] / ($niftyITQuote['last_price'] - $niftyITQuote['net_change'])) * 100, 2)
                : 0,
        ],
    ];

    // =========================
    // SAVE INDEX DATA
    // =========================
    foreach ($indexDataToSave as $indexData) {
        \App\Models\Index::create($indexData);
    }

    // =========================
    // FETCH MARKET MOVERS
    // =========================
    $screeners = [
        'gainers'       => $market->getCustomMarketMovers('gainers'),
        'losers'        => $market->getCustomMarketMovers('losers'),
        'most-active'   => $market->getCustomMarketMovers('most-active'), 
    ];

    $typeMap = [
        'gainers'       => 'gainer',
        'losers'        => 'loser',
        'most-active'   => 'most_active', 
    ];

    // =========================
    // SAVE STOCK DATA
    // =========================
   // dd($screeners);
   foreach ($screeners as $key => $stocks) {

    foreach ($stocks as $stock) {

        \App\Models\Stock::updateOrCreate(
            ['symbol' => $stock['symbol'] ?? ''],
            [
                'name'   => $stock['symbol'] 
                            ?? $stock['shortName'] 
                            ?? $stock['longName'] 
                            ?? '',

                'type'   => $typeMap[$key],

                'price'  => $stock['last_price'] 
                            ?? $stock['ltp'] 
                            ?? $stock['price'] 
                            ?? 0,

                'change_pts' => $stock['net_change'] 
                                ?? $stock['change'] 
                                ?? 0,

                'change_percent' => $stock['changePercent'] 
                                    ?? $stock['pChange'] 
                                    ?? $stock['percent_change'] 
                                    ?? 0,
            ]
        );
    }
}
    return [

        'labels' => $labels,
        'prices' => $prices,

        'niftyPrice'   => $niftyQuote['last_price'] ?? 0,
        'niftyChange'  =>  isset($niftyQuote['net_change'], $niftyQuote['last_price'])
                    ? round(($niftyQuote['net_change'] / ($niftyQuote['last_price'] - $niftyQuote['net_change'])) * 100, 2)
                    : 0,

        'sensexPrice'  => $sensexQuote['last_price'] ?? 0,
        'sensexChange' =>  isset($sensexQuote['net_change'], $sensexQuote['last_price'])
                    ? round(($sensexQuote['net_change'] / ($sensexQuote['last_price'] - $sensexQuote['net_change'])) * 100, 2)
                    : 0,

        'marketData' => [

            'NIFTY 50' => [
                'price' => $niftyQuote['last_price'] ?? 0,
                'changePercent' => isset($niftyQuote['net_change'], $niftyQuote['last_price'])
                    ? round(($niftyQuote['net_change'] / ($niftyQuote['last_price'] - $niftyQuote['net_change'])) * 100, 2)
                    : 0,
            ],

            'SENSEX' => [
                'price' => $sensexQuote['last_price'] ?? 0,
                'changePercent' => isset($sensexQuote['net_change'], $sensexQuote['last_price'])
                    ? round(($sensexQuote['net_change'] / ($sensexQuote['last_price'] - $sensexQuote['net_change'])) * 100, 2)
                    : 0,
            ],

            'NIFTY BANK' => [
                'price' => $bankNiftyQuote['last_price'] ?? 0,
                'changePercent' => isset($bankNiftyQuote['net_change'], $bankNiftyQuote['last_price'])
                    ? round(($bankNiftyQuote['net_change'] / ($bankNiftyQuote['last_price'] - $bankNiftyQuote['net_change'])) * 100, 2)
                    : 0,
            ],

            'NIFTY IT' => [
                'price' => $niftyITQuote['last_price'] ?? 0,
                'changePercent' => isset($niftyITQuote['net_change'], $niftyITQuote['last_price'])
                    ? round(($niftyITQuote['net_change'] / ($niftyITQuote['last_price'] - $niftyITQuote['net_change'])) * 100, 2)
                    : 0,
            ],
        ],

        // Market Movers
     'gainers' => collect(
    $market->getCustomMarketMovers('gainers')
)->take(5)->values(),

'losers' => collect(
    $market->getCustomMarketMovers('losers')
)->take(5)->values(),

'mostActive' => collect(
    $market->getCustomMarketMovers('most-active')
)->take(5)->values(),

        'mostActiveValue' => $market->getCustomMarketMovers('most-active'),
        'topGainers'      => $market->getCustomMarketMovers('gainers'),
        'topLosers'       => $market->getCustomMarketMovers('losers'),

        'weekHigh'        => $market->getCustomMarketMovers('52-week-high'),
        'weekLow'         => $market->getCustomMarketMovers('52-week-low'),
    ];
});

return view('welcome', $data);

}
private function fetchNewsByCategory($category)
{
    $endpoint = config('services.newsapi.endpoint');
    $apiKey   = config('services.newsapi.key');

    $indiaResponse = Http::get($endpoint, [
        'q'        => $category . ' India OR NSE OR BSE',
        'pageSize' => 50,
        'sortBy'   => 'publishedAt',
        'language' => 'en',
        'apiKey'   => $apiKey,
    ]);

    $globalResponse = Http::get($endpoint, [
        'q'        => $category . 'Global OR stock market OR global OR US OR Europe',
        'pageSize' => 50,
        'sortBy'   => 'publishedAt',
        'language' => 'en',
        'apiKey'   => $apiKey,
    ]);

    $format = function ($articles) {
        return collect($articles)->map(function ($article) {
            return [
                'title'        => $article['title'] ?? '',
                'subtitle'     => $article['description'] ?? '',
                'url'          => $article['url'] ?? '#',
                'source'       => $article['source']['name'] ?? 'News',
                'published_at' => $article['publishedAt'] ?? null,
                'urlToImage'   => $article['urlToImage'] ?? null,
            ];
        });
    };

    return [
        'india'  => $indiaResponse->successful()
                        ? $format($indiaResponse->json()['articles'] ?? [])
                        : collect(),

        'global' => $globalResponse->successful()
                        ? $format($globalResponse->json()['articles'] ?? [])
                        : collect(),
    ];
}

private function fetchRelatedNews($category)
{
    $endpoint = config('services.newsapi.endpoint');
    $apiKey   = config('services.newsapi.key');

    $response = Http::get($endpoint, [
        'q'        => $category,
        'pageSize' => 7,             // fewer for sidebar
        'sortBy'   => 'relevancy',   // sort by relevancy
        'language' => 'en',
        'apiKey'   => $apiKey,
    ]);

    if (!$response->successful()) {
        return [];
    }

    $articles = $response->json()['articles'] ?? [];

    return array_map(function($article) {
        return [
            'title'        => $article['title'] ?? '',
            'url'          => $article['url'] ?? '#',
            'source'       => $article['source']['name'] ?? '',
            'published_at' => $article['publishedAt'] ?? '',
            'urlToImage'   => $article['urlToImage'] ?? null,
        ];
    }, $articles);
}

 public function category($category)
{
    $category = strtolower($category); // normalize category name
    $data = [];
 
    $extraDataMap = [
        'markets' => ['type'=>'indices', 'symbols'=>['BSE Sensex'=>'%5EBSESN','NIFTY 50'=>'%5ENSEI']],
        'commodities' => ['type'=>'commodities', 'symbols'=>['GOLD','SILVER','CRUDEOIL']],
    ];

    if (isset($extraDataMap[$category])) {
        $map = $extraDataMap[$category];

        switch($map['type']) {
            case 'indices':
                $marketData = [];
                foreach ($map['symbols'] as $name => $symbol) {
                    $d = $this->fetchIndex($symbol);
                    if ($d) $marketData[$name] = $d;
                }
                $data['marketData'] = $marketData;
                $data['topGainers'] = $this->fetchStockList('day_gainers');
                $data['topLosers']  = $this->fetchStockList('day_losers');
                break;

            case 'commodities':
                $commodityData = [];
                foreach ($map['symbols'] as $symbol) {
                    $commodityData[$symbol] = $this->fetchIndex($symbol);
                }
                $data['commodityData'] = $commodityData;
                break;
        }
    }
 $cat = Catagories::where('slug', $category)->first();
    $subcat = Subcatagory::where('slug', $category)->first();

    $articleQuery = Articles::query()
        ->where('status', 'published')
        ->with(['media', 'author']); // eager load media & author

    if ($cat) {
        $articleQuery->where('category_id', $cat->id);
    } elseif ($subcat) {
        $articleQuery->where('subcategory_id', $subcat->id);
    }

    $articles = $articleQuery->orderByDesc('published_at')->get();
   // ----------------------------
// Fetch news (Indian + Global separately)
// ----------------------------
$newsData = $this->fetchNewsByCategory($category);

$indiaNews  = collect($newsData['india']);
$globalNews = collect($newsData['global']);

// Merge India first, then Global
$allNews = $indiaNews
            ->merge($globalNews)
            ->unique('url') // remove duplicates
            ->sortByDesc('published_at')
            ->values();

$perPage = 7;
$page = Paginator::resolveCurrentPage() ?: 1;

$paginatedNews = new LengthAwarePaginator(
    $allNews->forPage($page, $perPage),
    $allNews->count(),
    $perPage,
    $page,
    ['path' => Paginator::resolveCurrentPath()]
);

$data['news'] = $paginatedNews;
    // ----------------------------
    // Fetch related news for sidebar
    // ----------------------------
    $data['related'] = $this->fetchRelatedNews($category);

    // Return the category view
   return view('category', compact('category', 'data', 'articles'));
} 

public function smartMoney(UpstoxMarketService $market)
{
    $userId = session('user_id');

    if (!$userId) {
        return redirect('/signin');   // or /login depending on your route
    }

    $data = $market->getSmartMoneyTracker();
 //dd($data);
    return view('user.smart-money', compact('data'));
}
}
