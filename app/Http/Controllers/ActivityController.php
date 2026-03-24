<?php
namespace App\Http\Controllers;

use App\Models\UserInterest;
use App\Models\Catagories;
use App\Models\Articles;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;

class ActivityController extends Controller
{
public function index(Request $request)
{
    $userId = session('user_id');

    $interests = UserInterest::where('user_id', $userId)
                    ->with(['category', 'subcategory'])
                    ->get();

    $categories = Catagories::where('status', 1)
        ->with(['subcategories' => function($q){
            $q->where('status', 1);
        }])
        ->get();

    $apiNews = collect();
    $articles = collect();

    if ($interests->isNotEmpty())
    {
        /*
        |--------------------------------------------------------------------------
        | 1️⃣ Fetch ALL API News (collect first)
        |--------------------------------------------------------------------------
        */

        foreach ($interests as $interest) {

            $query = $interest->category->name . ' ' .
                     optional($interest->subcategory)->name;

            $response = Http::get('https://newsapi.org/v2/everything', [
                'q' => $query,
                'apiKey' => env('NEWS_API_KEY'),
                'pageSize' => 10,
            ]);

            if ($response->successful()) {
                $news = $response->json()['articles'] ?? [];
                $apiNews = $apiNews->merge($news);
            }
        }

        // Remove duplicate API news by URL
        $apiNews = $apiNews->unique('url')->values();

        /*
        |--------------------------------------------------------------------------
        | 2️⃣ Paginate API News (6 per page)
        |--------------------------------------------------------------------------
        */

        $currentPageApi = $request->get('api_page', 1);
        $perPage = 6;

        $apiNews = new LengthAwarePaginator(
            $apiNews->forPage($currentPageApi, $perPage),
            $apiNews->count(),
            $perPage,
            $currentPageApi,
            [
                'path' => $request->url(),
                'pageName' => 'api_page',
            ]
        );

        /*
        |--------------------------------------------------------------------------
        | 3️⃣ Paginate Editor Articles (6 per page)
        |--------------------------------------------------------------------------
        */

    $articles = Articles::where('status', 'published')
    ->where(function ($query) use ($interests) {

        foreach ($interests as $interest) {
            $query->orWhere(function ($q) use ($interest) {
                $q->where('category_id', $interest->category_id)
                  ->where('subcategory_id', $interest->subcategory_id);
            });
        }

    })
    ->distinct()
    ->latest()
    ->paginate(5, ['*'], 'article_page');
    }

    return view('user.my_interests', compact(
        'interests',
        'categories',
        'apiNews',
        'articles'
    ));
}
public function store(Request $request)
{
    $request->validate([
        'category_id' => 'required|array|min:1',
        'subcategory_id' => 'required|array|min:1',
    ]);

    $userId = session('user_id');

    // Remove old interests
    UserInterest::where('user_id', $userId)->delete();

    $categories = $request->category_id;
    $subcategories = $request->subcategory_id;

    foreach ($subcategories as $subId) {

        $subcategory = \App\Models\Subcatagory::find($subId);

        if ($subcategory && in_array($subcategory->category_id, $categories)) {

            UserInterest::create([
                'user_id' => $userId,
                'category_id' => $subcategory->category_id,
                'subcategory_id' => $subId,
            ]);
        }
    }

    return redirect()->route('user.interests')
            ->with('success', 'Interests updated successfully.');
}
}