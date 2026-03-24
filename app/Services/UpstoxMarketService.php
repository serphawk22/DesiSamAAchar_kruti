<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use GuzzleHttp\Cookie\CookieJar;

class UpstoxMarketService
{
    private string $baseUrl;
    private string $token;

    public function __construct()
    {
        $this->baseUrl = rtrim(config('services.upstox.base_url'), '/');
        $this->token   = config('services.upstox.token');
    }

    private function request(string $endpoint, array $query = [])
    {
        $response = Http::withToken($this->token)
            ->acceptJson()
            ->timeout(15)
            ->get($this->baseUrl . $endpoint, $query);

        if (!$response->successful()) {
            Log::error('Upstox API Error', [
                'endpoint' => $endpoint,
                'query'    => $query,
                'status'   => $response->status(),
                'body'     => $response->body(),
            ]);
            return null;
        }

        return $response->json();
    }

    /* =========================================
       GET QUOTE (WORKING WITH symbol PARAM)
    ========================================== */
    public function getSymbolsFromCsv(): array
{
    $path = app_path('View/EQUITY_L.csv');

    if (!file_exists($path)) {
        return [];
    }

    $rows = array_map('str_getcsv', file($path));

    $header = array_map('trim', $rows[0]);

    $symbolIndex = array_search('SYMBOL', $header); // make sure column name is SYMBOL

    if ($symbolIndex === false) {
        return [];
    }

    $symbols = [];

    foreach (array_slice($rows, 1) as $row) {
        if (!empty($row[$symbolIndex])) {
            // Convert to Upstox format
            $symbols[] = 'NSE_EQ:' . trim($row[$symbolIndex]);
        }
    }

    return $symbols;
}
public function getQuote(string|array $symbols): ?array
{
    // Convert single string to array
    if (is_string($symbols)) {
        $symbols = [$symbols];
    }

    // Detect whether we should send symbol or instrument_key
    $queryKey = str_contains($symbols[0], '|') ? 'instrument_key' : 'symbol';

    $response = Http::withToken($this->token)
        ->acceptJson()
        ->timeout(15)
        ->get($this->baseUrl . '/market-quote/quotes', [
            $queryKey => implode(',', $symbols)
        ]);

    if (!$response->successful()) {
        Log::error('Quote API Error', [
            'status' => $response->status(),
            'body'   => $response->body()
        ]);
        return null;
    }

    $data = $response->json('data');

    if (!$data) {
        return null;
    }

    // Return first item only (for single quote usage)
    return collect($data)->first();
}
    /* =========================================
       GET INTRADAY CANDLES
    ========================================== */
public function getIntradayCandles(string $instrumentKey): array
{
    $toDate = now()->format('Y-m-d');

    $url = "https://api.upstox.com/v2/historical-candle/"
        . $instrumentKey
        . "/1minute/"
        . $toDate;

    $response = Http::withToken($this->token)
        ->acceptJson()
        ->get($url);

    if (!$response->successful()) {
        dd($response->json());
    }

    return $response->json('data.candles') ?? [];
}
public function getHistoricalCandles($instrumentKey, $interval, $from, $to)
{
    $url = "https://api.upstox.com/v2/historical-candle/"
        . $instrumentKey
        . "/{$interval}/"
        . $to
        . "/"
        . $from;

    $response = Http::withToken($this->token)
        ->acceptJson()
        ->get($url);

    if (!$response->successful()) {
        dd($response->json());
    }

    return $response->json('data.candles') ?? [];
}
    /* =========================================
       GET MARKET MOVERS
    ========================================== */
public function getCustomMarketMovers(string $type): array
{
    $baseUrl = 'https://www.nseindia.com/';

    $client = Http::withHeaders([
        'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        'Accept' => 'application/json',
        'Referer' => 'https://www.nseindia.com/',
    ])->withOptions([
        'verify' => false,
        'curl' => [
            CURLOPT_COOKIEJAR => storage_path('cookies.txt'),
            CURLOPT_COOKIEFILE => storage_path('cookies.txt'),
        ],
    ]);

    // Load homepage to generate cookies
    $client->get($baseUrl);
    usleep(500000);
sleep(1);
    $response = $client->get(
        $baseUrl . 'api/equity-stockIndices?index=NIFTY%2050'
    );

    if (!$response->ok()) {
        return [];
    }

    $json = $response->json();

    if (!isset($json['data'])) {
        return [];
    }

    $stocks = collect($json['data'])
        ->skip(1) // skip NIFTY index row
        ->map(function ($item) {

            return [
                'symbol' => $item['symbol'],
                'price' => (float) $item['lastPrice'],
                'change' => (float) $item['change'],
                'changePercent' => (float) $item['pChange'],
                'volume' => (int) $item['totalTradedVolume'],
                'tradedValue' => (float) $item['totalTradedValue'],
                'yearHigh' => (float) $item['yearHigh'],
                'yearLow' => (float) $item['yearLow'],
            ];
        });

    return match ($type) {

        'gainers' =>
            $stocks->sortByDesc('changePercent')->take(10)->values()->toArray(),

        'losers' =>
            $stocks->sortBy('changePercent')->take(10)->values()->toArray(),

        'most-active' =>
            $stocks->sortByDesc('tradedValue')->take(10)->values()->toArray(),

        '52-week-high' =>
            $stocks->filter(fn($s) => $s['price'] >= $s['yearHigh'])
                   ->values()
                   ->toArray(),

        '52-week-low' =>
            $stocks->filter(fn($s) => $s['price'] <= $s['yearLow'])
                   ->values()
                   ->toArray(),

        default => [],
    };
}
 
//
public function getSmartMoneyTracker()
{
    $baseUrl = 'https://www.nseindia.com/';
    $cookieJar = new CookieJar();

    $client = Http::withHeaders([
        'User-Agent' => 'Mozilla/5.0',
        'Accept' => 'application/json',
        'Referer' => $baseUrl
    ])->withOptions([
        'verify' => false,
        'cookies' => $cookieJar
    ]);

    // First request to generate NSE cookies
    $client->get($baseUrl);
    usleep(500000);

    $response = $client->get(
        $baseUrl . 'api/equity-stockIndices?index=NIFTY%2050'
    );

    if (!$response->ok()) {
        return [
            'most_bought' => collect(),
            'unusual_volume' => collect(),
            'momentum' => collect(),
            'fii_dii' => []
        ];
    }

    $data = $response->json('data');

    if (!$data) {
        return [
            'most_bought' => collect(),
            'unusual_volume' => collect(),
            'momentum' => collect(),
            'fii_dii' => []
        ];
    }

    $stocks = collect($data)
        ->skip(1)
        ->map(function ($item) {

            $volume = $item['totalTradedVolume'] ?? 0;
            $value  = $item['totalTradedValue'] ?? 0;

            return [
                'symbol' => $item['symbol'],
                'price' => (float)$item['lastPrice'],
                'changePercent' => (float)$item['pChange'],
                'volume' => (int)$volume,
                'value' => (float)$value,

                'deliveryPercent' => $volume > 0
                    ? round(($value / $volume) / 1000, 2)
                    : 0
            ];
        });

    return [

        'most_bought' => $stocks
            ->sortByDesc('deliveryPercent')
            ->take(10)
            ->values(),

        'unusual_volume' => $stocks
            ->sortByDesc('volume')
            ->take(10)
            ->values(),

        'momentum' => $stocks
            ->sortByDesc('changePercent')
            ->take(10)
            ->values(),

        'fii_dii' => $this->getFiiDiiActivity()
    ];
}
public function getFiiDiiActivity()
{
    $baseUrl = "https://www.nseindia.com/";

    $client = Http::withHeaders([
        'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        'Accept' => 'application/json',
        'Referer' => 'https://www.nseindia.com/',
    ])->withOptions([
        'verify' => false,
        'curl' => [
            CURLOPT_COOKIEJAR => storage_path('cookies.txt'),
            CURLOPT_COOKIEFILE => storage_path('cookies.txt'),
        ],
    ]);

    // Load homepage to generate cookies
    $client->get($baseUrl);
    usleep(500000);
    sleep(1);

    $response = $client->get($baseUrl . "api/fiidiiTradeReact");

    if (!$response->ok()) {
        return [];
    }

    return $response->json();
}
}