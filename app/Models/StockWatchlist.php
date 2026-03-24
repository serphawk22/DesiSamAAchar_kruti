<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class StockWatchlist extends Model
{
     protected $table = 'stock_watchlist';

    public $timestamps = false;

    protected $fillable = [
        'user_id',
        'symbol'
    ];
}
