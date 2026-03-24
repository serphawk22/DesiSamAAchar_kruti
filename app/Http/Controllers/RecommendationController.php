<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use App\Services\UpstoxMarketService;

class RecommendationController extends Controller
{
  public function index(Request $request, UpstoxMarketService $market)
{
    $userId = session('user_id');

    if (!$userId) {
        return redirect('/login');
    }

    $watchlist = DB::table('stock_watchlist')
    ->where('user_id', session('user_id'))
    ->pluck('symbol')
    ->toArray();
    //dd($watchlist);

$recommendedStocks = [];

foreach ($watchlist as $symbol) {

    $instrument = "NSE_EQ|" . $symbol;

    $quote = $market->getQuote($instrument);

    $price  = '-';
    $change = 0;

    // If Upstox works
    if ($quote) {

        $price  = $quote['last_price'] ?? '-';
        $change = $quote['net_change'] ?? 0;

    } else {

        // NSE fallback
        $nse = Http::withHeaders([
            'User-Agent' => 'Mozilla/5.0',
            'Accept' => 'application/json'
        ])->get("https://www.nseindia.com/api/quote-equity?symbol=".$symbol);

        if ($nse->successful()) {

            $data = $nse->json();

            $price  = $data['priceInfo']['lastPrice'] ?? '-';
            $change = $data['priceInfo']['change'] ?? 0;
        }
    }

    $recommendedStocks[] = [
        'symbol' => $symbol,
        'price'  => $price,
        'change' => $change
    ];
}


    $offset = $request->offset ?? 0;

 $gainers = collect($market->getCustomMarketMovers('gainers'))->values();

    if($request->ajax()){
        return response()->json($gainers);
    }

    $endpoint = config('services.newsapi.endpoint');
    $apiKey   = config('services.newsapi.key');

    $response = Http::get($endpoint,[
        'q'=>'stock market OR finance',
        'apiKey'=>$apiKey,
        'pageSize'=>10
    ]);

    $news = $response->json()['articles'] ?? [];

    return view('user.recommendations',[
        'stocks'=>$recommendedStocks,
        'topMovers'=>$gainers,
        'news'=>$news
    ]);
}
}