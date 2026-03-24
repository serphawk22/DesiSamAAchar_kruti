<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserPortfolio extends Model
{
     protected $table = 'user_portfolio';
     protected $fillable = ['user_id', 'symbol', 'buy_price', 'quantity'];
}
