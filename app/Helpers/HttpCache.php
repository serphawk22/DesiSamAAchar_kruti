<?php

namespace App\Helpers;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;

class HttpCache
{
    public static function get($url, $params = [], $ttl = 1800)
    {
        $key = md5($url . json_encode($params));

        return Cache::remember($key, $ttl, function () use ($url, $params) {
            return Http::timeout(10)->get($url, $params)->json();
        });
    }
    
}