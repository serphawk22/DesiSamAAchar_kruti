<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\StockWatchlist;
use App\Models\UserPortfolio;
use Illuminate\Support\Facades\Http;

class StocklikedController extends Controller
{
    public function index()
    {
        $userId = session('user_id');

        // Fetch liked stocks
        $stocks = StockWatchlist::where('user_id', $userId)
                    ->latest()
                    ->paginate(10);

        
        return view('user.liked_stocks', compact(
            'stocks' 
        ));
    }

   
}