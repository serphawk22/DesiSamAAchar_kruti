<?php

namespace App\Http\Controllers;
use App\Models\Users;
use App\Models\Articles;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class AdminDashboardController extends Controller
{
     public function index()
    {
        // 🔹 Overview Cards
        $totalUsers = Users::where('role', 'user')->count();
        $totalEditors = Users::where('role', 'editor')->count();
        $totalArticles = Articles::count();

        $activeToday = Users::whereDate('last_login', today())->count();

        $aiRequests = DB::table('activity_logs')
            ->where('action', 'like', '%AI%')
            ->count();

        // 🔹 Traffic Chart (Last 7 Days Articles Published)
        $traffic = Articles::select(
                DB::raw("DATE(created_at) as date"),
                DB::raw("COUNT(*) as total")
            )
            ->whereDate('created_at', '>=', now()->subDays(7))
            ->groupBy('date')
            ->orderBy('date')
            ->get();

        // 🔹 Trending Topics (From Articles Table)
        $trending = Articles::where('is_trending', 1)
            ->where('status', 'published')
            ->orderByDesc('views')
            ->take(5)
            ->get();

        return view('admin.dashboard', compact(
            'totalUsers',
            'totalEditors',
            'totalArticles',
            'activeToday',
            'aiRequests',
            'traffic',
            'trending'
        ));
    }
}
