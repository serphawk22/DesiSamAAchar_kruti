<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\StreamedResponse;

class AdminReportController extends Controller
{
 public function index()
    {
        // LAST MONTH REGISTRATIONS ONLY (only dates where registrations exist) 
 // USER REGISTRATION CHART
  // 📅 Date Filtering
        $start = null;
        $end = now();
        $userRegistrations = DB::table('users')
            ->when($start, function ($q) use ($start, $end) {
                return $q->whereBetween('created_at', [$start, $end]);
            })
            ->select(DB::raw('DATE(created_at) as date'), DB::raw('COUNT(*) as total'))
            ->groupBy(DB::raw('DATE(created_at)'))
            ->orderBy('date')
            ->get();

        return view('admin.reports-dashboard', compact('userRegistrations'));
    }

    public function export(Request $request): StreamedResponse
    {
        $type = $request->type;

        $filename = $type . "_report.csv";

        $headers = [
            "Content-type" => "text/csv",
            "Content-Disposition" => "attachment; filename=$filename",
        ];

        $callback = function () use ($type) {

            $file = fopen('php://output', 'w');

            // 1️⃣ MOST VIEWED
            if ($type == 'most_viewed') {

                fputcsv($file, ['Title', 'Views']);

                $data = DB::table('articles')
                    ->select('title', 'views')
                    ->orderByDesc('views')
                    ->get();

                foreach ($data as $row) {
                    fputcsv($file, [$row->title, $row->views]);
                }
            }

            // 2️⃣ CATEGORY POPULARITY
            if ($type == 'category') {

                fputcsv($file, ['Category', 'Total Articles']);

                $data = DB::table('articles')
                    ->join('categories', 'articles.category_id', '=', 'categories.id')
                    ->select('categories.name', DB::raw('COUNT(articles.id) as total'))
                    ->groupBy('categories.name')
                    ->get();

                foreach ($data as $row) {
                    fputcsv($file, [$row->name, $row->total]);
                }
            }

            // 3️⃣ EDITOR PUBLISH COUNT
            if ($type == 'editor') {

                fputcsv($file, ['Editor', 'Published Articles']);

                $data = DB::table('articles')
                    ->join('users', 'articles.author_id', '=', 'users.id')
                    ->where('users.role', 'editor')
                    ->select('users.name', DB::raw('COUNT(articles.id) as total'))
                    ->groupBy('users.name')
                    ->get();

                foreach ($data as $row) {
                    fputcsv($file, [$row->name, $row->total]);
                }
            }

            // 4️⃣ MOST USER INTERACTION
            if ($type == 'interaction') {

                fputcsv($file, ['Article', 'Views', 'Comments', 'Total Score']);

                $data = DB::table('articles')
                    ->leftJoin('comments', 'articles.id', '=', 'comments.article_id')
                    ->select(
                        'articles.title',
                        DB::raw('articles.views as views'),
                        DB::raw('COUNT(comments.id) as comments'),
                        DB::raw('(articles.views + COUNT(comments.id)) as score')
                    )
                    ->groupBy('articles.id', 'articles.title', 'articles.views')
                    ->orderByDesc('score')
                    ->get();

                foreach ($data as $row) {
                    fputcsv($file, [
                        $row->title,
                        $row->views,
                        $row->comments,
                        $row->score
                    ]);
                }
            }

            fclose($file);
        };

        return response()->stream($callback, 200, $headers);
    }
}
