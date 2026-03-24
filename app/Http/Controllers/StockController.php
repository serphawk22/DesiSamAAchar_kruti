<?php

namespace App\Http\Controllers;

use App\Models\Stock;
use App\Models\StockWatchlist;
use Illuminate\Http\Request;

class StockController extends Controller
{
    // Show stock list page
   public function index()
{
    $stocks = \App\Models\Stock::orderBy('symbol')->get();

    $watchlistSymbols = [];

    if (session()->has('user_id')) {
        $watchlistSymbols = \App\Models\StockWatchlist::where('user_id', session('user_id'))
                            ->pluck('symbol')
                            ->toArray();
    }

    return view('user.stocklist', compact('stocks', 'watchlistSymbols'));
}

    // Toggle Watchlist
  public function toggle(Request $request)
{
    if (!session()->has('user_id')) {
        return response()->json(['error' => 'Login required'], 401);
    }

    $userId = session('user_id');
    $symbol = $request->symbol;

    $existing = \App\Models\StockWatchlist::where('user_id', $userId)
                ->where('symbol', $symbol)
                ->first();

    if ($existing) {
        $existing->delete();
        return response()->json(['status' => 'removed']);
    }

    \App\Models\StockWatchlist::create([
        'user_id' => $userId,
        'symbol'  => $symbol
    ]);

    return response()->json(['status' => 'added']);
}
}