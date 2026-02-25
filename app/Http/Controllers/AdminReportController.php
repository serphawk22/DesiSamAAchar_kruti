<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class AdminReportController extends Controller
{
     public function index()
    {
        // 1️⃣ Most Viewed Articles
        $mostViewed = DB::table('articles')
            ->select('title', 'views')
            ->orderByDesc('views')
            ->limit(5)
            ->get();

        // 2️⃣ Category Popularity (Article Count Per Category)
        $categoryPopularity = DB::table('articles')
            ->join('categories', 'articles.category_id', '=', 'categories.id')
            ->select('categories.name', DB::raw('COUNT(articles.id) as total_articles'))
            ->groupBy('categories.name')
            ->orderByDesc('total_articles')
            ->get();

        // 3️⃣ Editor Published Count
        $editorPublish = DB::table('articles')
            ->join('users', 'articles.author_id', '=', 'users.id')
            ->where('users.role', 'editor')
            ->where('articles.status', 'published')
            ->select('users.name', DB::raw('COUNT(articles.id) as total_published'))
            ->groupBy('users.name')
            ->orderByDesc('total_published')
            ->get();

        // 4️⃣ Most User Interaction (Views + Comments)
        $interaction = DB::table('articles')
            ->leftJoin('comments', 'articles.id', '=', 'comments.article_id')
            ->select(
                'articles.title',
                'articles.views',
                DB::raw('COUNT(comments.id) as total_comments'),
                DB::raw('(articles.views + COUNT(comments.id)) as interaction_score')
            )
            ->groupBy('articles.id', 'articles.title', 'articles.views')
            ->orderByDesc('interaction_score')
            ->limit(5)
            ->get();

        // 5️⃣ Users Registered Per Date (Chart)
        $userRegistrations = DB::table('users')
            ->select(DB::raw('DATE(created_at) as date'), DB::raw('COUNT(*) as total'))
            ->groupBy(DB::raw('DATE(created_at)'))
            ->orderBy('date')
            ->get();

        return view('admin.reports-dashboard', compact(
            'mostViewed',
            'categoryPopularity',
            'editorPublish',
            'interaction',
            'userRegistrations'
        ));
    }
}
