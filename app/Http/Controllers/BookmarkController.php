<?php

namespace App\Http\Controllers;
use App\Models\Bookmark;
use Illuminate\Http\Request;

class BookmarkController extends Controller
{
    public function bookmarks(Request $request)
{
    $userId = session('user_id');

    $bookmarks = Bookmark::where('user_id', $userId)
        ->with(['article' => function ($q) {
            $q->where('status', 'published');
        }])
        ->latest()
        ->paginate(10);

    return view('user.bookmarks', compact('bookmarks'));
}
}
