<?php

namespace App\Http\Controllers;
use App\Models\Articles;
use Illuminate\Http\Request;

class ContentController extends Controller
{
    public function index(Request $request)
    {
        $query = Articles::with('author');

            // 🔍 Search by title
        if ($request->search) {
            $query->where('title', 'LIKE', '%' . $request->search . '%');
           // dd($request->search);
        }
        // Filters
        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        if ($request->has('breaking')) {
            $query->where('is_breaking', 1);
        }

        if ($request->has('trending')) {
            $query->where('is_trending', 1);
        }

        $articles = $query->latest()->paginate(15)->withQueryString();

        return view('admin.content', compact('articles'));
    }
public function suggestions(Request $request)
{
    $search = $request->search;

    $articles = Articles::where('title', 'LIKE', "{$search}%")
        ->limit(5)
        ->pluck('title');

    return response()->json($articles);
}
    public function publish($id)
    {
        $article = Articles::findOrFail($id);

        if ($article->status === 'published') {
            $article->status = 'pending';
        } else {
            $article->status = 'published';
            $article->published_at = now();
        }

        $article->save();

        return back()->with('success', 'Article status updated.');
    }

    public function delete($id)
    {
        Articles::findOrFail($id)->delete();

        return back()->with('success', 'Article deleted.');
    }
}
