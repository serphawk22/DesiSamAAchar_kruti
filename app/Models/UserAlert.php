<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserAlert extends Model
{
    protected $table = "user_alerts";

    protected $fillable = [
        'user_id',
        'keyword',
        'email_notify',
        'browser_notify'
    ];
}