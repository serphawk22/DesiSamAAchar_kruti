<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use OpenAI;
use App\Models\Articles;
use App\Models\StockWatchlist;
use App\Services\UpstoxMarketService;

class ChatbotController extends Controller
{
    private $market;

    public function __construct(UpstoxMarketService $market)
    {
        $this->market = $market;
    }

    public function ask(Request $request)
    {
        try {

            $question = strtolower($request->message);
            $userId   = session('user_id');

            $client = OpenAI::client(config('services.openai.key'));

            $companyData = "";

            /*
            ======================================================
            COMPANY DETECTION
            ======================================================
            */

            $symbol = $this->detectCompany($question);

            if ($symbol) {

                $company = $this->findSymbol($symbol);

                if ($company) {

                    $instrumentKey = "NSE_EQ|" . $company['isin'];

                    $quoteRaw = $this->market->getQuote($instrumentKey) ?? [];

                    $price   = $quoteRaw['last_price'] ?? 0;
                    $open    = $quoteRaw['ohlc']['open'] ?? 0;
                    $high    = $quoteRaw['ohlc']['high'] ?? 0;
                    $low     = $quoteRaw['ohlc']['low'] ?? 0;
                    $close   = $quoteRaw['ohlc']['close'] ?? 0;
                    $change  = $quoteRaw['net_change'] ?? 0;
                    $percent = $quoteRaw['percent_change'] ?? 0;

                    $companyData = "
                        Company: {$company['name']} ({$company['symbol']})
                        Price: $price
                        Open: $open
                        High: $high
                        Low: $low
                        Previous Close: $close
                        Change: $change
                        Percent Change: $percent %
                    ";

                    /*
                    COMPANY NEWS
                    */

                    $news = Http::get(
                        "https://newsapi.org/v2/everything",
                        [
                            'q'       => $company['name'],
                            'language'=> 'en',
                            'sortBy'  => 'publishedAt',
                            'pageSize'=> 3,
                            'apiKey'  => config('services.newsapi.key')
                        ]
                    )->json();

                    if (isset($news['articles'])) {
                        foreach ($news['articles'] as $n) {
                            $companyData .= "News: " . $n['title'] . "\n";
                        }
                    }
                }
            }

            /*
            ======================================================
            USER WATCHLIST
            ======================================================
            */

            $watchlist = "";

            if ($userId) {
                $watchlist = StockWatchlist::where('user_id', $userId)
                    ->pluck('symbol')
                    ->implode(', ');
            }

            /*
            ======================================================
            ARTICLES
            ======================================================
            */

            $articles = Articles::latest()
                ->take(5)
                ->pluck('title')
                ->implode("\n");

            /*
            ======================================================
            UPSTOX MARKET DATA
            ======================================================
            */

            $nifty  = "";
            $sensex = "";

            try {

                $upstox = Http::withHeaders([
                    'Authorization' => 'Bearer ' . config('services.upstox.token')
                ])->get(
                    'https://api.upstox.com/v2/market-quote/ltp',
                    [
                        'instrument_key' => 'NSE_INDEX|Nifty 50,BSE_INDEX|SENSEX'
                    ]
                )->json();

                $nifty  = $upstox['data']['NSE_INDEX:Nifty 50']['last_price'] ?? "";
                $sensex = $upstox['data']['BSE_INDEX:SENSEX']['last_price'] ?? "";

            } catch (\Exception $e) {}

            /*
            ======================================================
            CRYPTO
            ======================================================
            */

            $cryptoText = "";

            try {

                $crypto = Http::get(
                    'https://api.coingecko.com/api/v3/simple/price',
                    [
                        'ids' => 'bitcoin,ethereum',
                        'vs_currencies' => 'usd'
                    ]
                )->json();

                $cryptoText = "
                    Bitcoin: {$crypto['bitcoin']['usd']} USD
                    Ethereum: {$crypto['ethereum']['usd']} USD
                ";

            } catch (\Exception $e) {}

            /*
            ======================================================
            GOLD & SILVER
            ======================================================
            */

            $gold   = "";
            $silver = "";

            try {

                $goldApi   = Http::get('https://api.gold-api.com/price/XAU')->json();
                $silverApi = Http::get('https://api.gold-api.com/price/XAG')->json();

                $gold   = $goldApi['price'];
                $silver = $silverApi['price'];

            } catch (\Exception $e) {}

            /*
            ======================================================
            CRUDE OIL
            ======================================================
            */

            $oil = "";

            try {

                $oilApi = Http::get(
                    'https://query1.finance.yahoo.com/v7/finance/quote',
                    [
                        'symbols' => 'CL=F'
                    ]
                )->json();

                $oil = $oilApi['quoteResponse']['result'][0]['regularMarketPrice'] ?? "";

            } catch (\Exception $e) {}

            /*
            ======================================================
            CURRENCY
            ======================================================
            */

            $currency = "";

            try {

                $curr = Http::get(
                    'https://api.exchangerate.host/latest',
                    [
                        'base'    => 'USD',
                        'symbols' => 'INR'
                    ]
                )->json();

                $currency = "1 USD = " . $curr['rates']['INR'] . " INR";

            } catch (\Exception $e) {}

            /*
            ======================================================
            BREAKING NEWS
            ======================================================
            */

            $headlines = "";

            try {

                $news = Http::get(
                    config('services.newsapi.endpoint'),
                    [
                        'q' => 'nifty OR sensex OR stock market OR crypto OR gold OR crude oil OR war',
                        'language' => 'en',
                        'sortBy'   => 'publishedAt',
                        'pageSize' => 5,
                        'apiKey'   => config('services.newsapi.key')
                    ]
                )->json();

                if (isset($news['articles'])) {
                    foreach ($news['articles'] as $n) {
                        $headlines .= $n['title'] . "\n";
                    }
                }

            } catch (\Exception $e) {}

            /*
            ======================================================
            AI CONTEXT
            ======================================================
            */

            $context = "
            You are a professional AI financial assistant for a finance news website.

            You help users with:
            - Website navigation
            - Stock market
            - Company stock data
            - Nifty
            - Sensex
            - Crypto
            - Currency exchange
            - Gold and silver
            - Crude oil
            - IPO news
            - Global economy
            - War impact on markets
            - Breaking news

            REAL TIME DATA:

            $companyData

            Nifty: $nifty
            Sensex: $sensex
            Crypto: $cryptoText
            Gold: $gold USD
            Silver: $silver USD
            Crude Oil: $oil USD
            Currency: $currency

            Latest News:
            $headlines

            Latest Articles:
            $articles

            User Watchlist:
            $watchlist

                USER NAVIGATION
                Accessible by: USER and ADMIN

                Users can:
                - Read articles
                - View categories
                - Comment on articles
                - Bookmark articles
                - Add stocks to watchlist
                - View market data 
                - View profile

                EDITOR NAVIGATION
                Accessible by: EDITOR and ADMIN

                Editor Panel Pages:
                - Editor Dashboard
                - My Articles
                - Media Library
                - Comments Moderation
                - Editor Profile

                Editors can:
                - Write articles
                - Edit their articles
                - Upload media
                - Manage article comments

                ADMIN NAVIGATION
                Accessible by: ADMIN ONLY

                Admin Panel Pages:
                - Admin Dashboard
                - User Management
                - Content Management
                - Categories Management
                - Comments Moderation
                - Analytics & Reports
                - Admin Profile

                Admins can:
                - Manage all users
                - Approve editors
                - Manage all articles
                - Manage categories
                - View analytics reports
                - Moderate all comments
                - Control the entire website

                If a user asks about a page they cannot access, explain which role can access it. 

            -Answer clearly and helpfully using this data
            - Explain navigation if asked
            - Mention which role can access the feature
            - Help users find the correct page
            ";

            /*
            ======================================================
            OPENAI
            ======================================================
            */

            $response = $client->chat()->create([
                'model' => 'gpt-4o-mini',
                'messages' => [
                    ['role' => 'system', 'content' => $context],
                    ['role' => 'user', 'content' => $question]
                ]
            ]);

            $answer = $response->choices[0]->message->content;

            return response()->json([
                'answer' => $answer
            ]);

        } catch (\Exception $e) {

            return response()->json([
                'answer' => '⚠️ AI Error: ' . $e->getMessage()
            ]);
        }
    }

    /*
    ======================================================
    DETECT COMPANY
    ======================================================
    */

    private function detectCompany($question)
    {
        $path = app_path('EQUITY_L.csv');

        if (!file_exists($path)) return null;

        $rows = array_map('str_getcsv', file($path));
        array_shift($rows);

        foreach ($rows as $row) {

            $symbol = strtolower(trim($row[0]));
            $name   = strtolower(trim($row[1]));

            if (
                str_contains($question, $symbol) ||
                str_contains($question, $name)
            ) {
                return strtoupper($row[0]);
            }
        }

        return null;
    }

    /*
    ======================================================
    FIND SYMBOL
    ======================================================
    */

    private function findSymbol($symbol)
    {
        $path = app_path('EQUITY_L.csv');

        if (!file_exists($path)) return null;

        $rows = array_map('str_getcsv', file($path));
        array_shift($rows);

        foreach ($rows as $row) {

            if (strtoupper(trim($row[0])) == strtoupper($symbol)) {

                return [
                    'symbol' => trim($row[0]),
                    'name'   => trim($row[1]),
                    'isin'   => trim($row[6])
                ];
            }
        }

        return null;
    }
}