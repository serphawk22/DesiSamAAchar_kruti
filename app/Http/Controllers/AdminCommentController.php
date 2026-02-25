<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class AdminCommentController extends Controller
{
     public function index(Request $request)
    {
        $query = DB::table('comments')
        ->join('users', 'comments.user_id', '=', 'users.id')
        ->join('articles', 'comments.article_id', '=', 'articles.id')
        ->select(
            'comments.*',
            'users.name as user_name',
            'articles.title as article_title'
        );

    // Filter by user
    if ($request->filled('user_id')) {
        $query->where('comments.user_id', $request->user_id);
    }

    // Filter by article
    if ($request->filled('article_id')) {
        $query->where('comments.article_id', $request->article_id);
    }

    $comments = $query->orderBy('comments.created_at', 'desc')
        ->paginate(20)
        ->withQueryString();

    // Get dropdown data
    $users = DB::table('users')->orderBy('name')->get();
    $articles = DB::table('articles')->orderBy('title')->get();

    return view('admin.comments', compact('comments', 'users', 'articles'));
    }

    public function approve($id)
    {
        DB::table('comments')
            ->where('id', $id)
            ->update(['status' => 1]);

        return back()->with('success', 'Comment Approved');
    }

    public function delete($id)
    {
        DB::table('comments')->where('id', $id)->delete();
        return back()->with('success', 'Comment Deleted');
    }

    public function banUser($id)
    {
        DB::table('users')
            ->where('id', $id)
            ->update(['status' => 'blocked']);

        return back()->with('success', 'User Banned');
    }
    // REPORTS 
 
}
