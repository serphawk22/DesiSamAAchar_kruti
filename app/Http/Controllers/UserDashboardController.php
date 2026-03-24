<?php

namespace App\Http\Controllers;

use App\Services\UpstoxMarketService;
use App\Models\Bookmark;
use App\Models\UserInterest;
use Illuminate\Support\Facades\DB;
use App\Models\Articles;
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Request;

class UserDashboardController extends Controller
{
    public function index(UpstoxMarketService $marketService)
    {
        // 🔐 SESSION CHECK
        if (!session()->has('user_id')) {
            return redirect()->route('login')->with('error', 'Please login first.');
        }

        $userId   = session('user_id');
        $userName = session('user_name');
        //dd($userName);
        // 📊 MARKET SNAPSHOT
         $nifty      = "NSE_INDEX|Nifty 50";
    $sensex     = "BSE_INDEX|SENSEX"; 
    $niftyQuote      = $marketService->getQuote($nifty) ?? [];
    $sensexQuote     = $marketService->getQuote($sensex) ?? []; 

        $nifty  = [
            'last_price' =>  $niftyQuote['last_price'] ?? 0,
            'net_change' => isset($niftyQuote['net_change'], $niftyQuote['last_price'])
                    ? round(($niftyQuote['net_change'] / ($niftyQuote['last_price'] - $niftyQuote['net_change'])) * 100, 2)
                    : 0,
        ];

        $sensex = [
            'last_price' => $sensexQuote['last_price'] ?? 0,
            'net_change' => isset($sensexQuote['net_change'], $sensexQuote['last_price'])
                    ? round(($sensexQuote['net_change'] / ($sensexQuote['last_price'] - $sensexQuote['net_change'])) * 100, 2)
                    : 0,
        ];

        // 🔼🔽 MARKET MOVERS
        $gainers = collect($marketService->getCustomMarketMovers('gainers'))->take(5)->values();
        $losers  = collect($marketService->getCustomMarketMovers('losers'))->take(5)->values();

        // ⭐ WATCHLIST
        $watchlist = Bookmark::where('user_id', $userId)
            ->with('article')
            ->latest()
            ->take(5)
            ->get();

        // 📰 NEWS FROM INTERESTS
        $interests = UserInterest::where('user_id', $userId)->pluck('category_id')->toArray();
       $latestNews = !empty($interests)
    ? Articles::whereIn('category_id', $interests)
        ->where('status', 'published')
        ->latest()
        ->take(5)
        ->get()
    : collect();

// 📈 STOCK HEATMAP
$heatmap = [];
$stocks = DB::table('stock_watchlist')
            ->where('user_id', $userId)
            ->get(['symbol']);

        // 🏦 DIVIDEND TRACKER (Static placeholder)
        $dividends = [];
        foreach ($stocks as $stock) {
            $dividends[] = [
                'symbol' => $stock->symbol,
                'company_name' => $stock->symbol,
                'dividend_amount' => rand(1, 20) // demo random dividend
            ];
        }

$sectorImpact = $this->getTrendingImpact($marketService);
//dd($sectorImpact);
        // RETURN VIEW
        return view('user.dashboard', compact(
            'userName',
            'nifty',
            'sensex',
            'gainers',
            'losers',
            'watchlist',
            'latestNews', 
            'dividends',
            'sectorImpact'
        ));
    }
// 📊 TRENDING NEWS IMPACT HEATMAP
private function getTrendingImpact(UpstoxMarketService $marketService)
{
      // NSE Sector Indices
    $sectors = [
        'IT'     => 'NSE_INDEX|Nifty IT',
        'BANKING'=> 'NSE_INDEX|Nifty Bank',
        'AUTO'   => 'NSE_INDEX|Nifty Auto',
        'PHARMA' => 'NSE_INDEX|Nifty Pharma'
    ];

    $heatmap = [];

    foreach ($sectors as $sector => $instrument) {

        $quote = $marketService->getQuote($instrument);

        $change = $quote['net_change'] ?? 0;
        $price  = $quote['last_price'] ?? 0;

        $percent = 0;

        if ($price != 0) {
            $percent = round(($change / ($price - $change)) * 100, 2);
        }

        if ($percent > 0.5) {
            $trend = 'up';
        } elseif ($percent < -0.5) {
            $trend = 'down';
        } else {
            $trend = 'neutral';
        }

        $heatmap[$sector] = [
            'percent' => $percent,
            'trend'   => $trend
        ];
    }

    return $heatmap;
}
  
}
