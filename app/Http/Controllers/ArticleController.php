<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Articles;
use App\Models\Bookmark;
use App\Models\Comment; 
class ArticleController extends Controller
{
    // Existing show() method
    public function show($slug)
    {
        $article = Articles::with(['media','author','category','subcategory'])
            ->where('slug', $slug)
            ->where('status','published')
            ->firstOrFail();

        // Increase views
        $article->increment('views');

        $relatedArticles = Articles::with(['media','author','category','subcategory'])
            ->where('status','published')
            ->where('id','!=',$article->id)
            ->where(function($q) use ($article){
                if($article->category_id) $q->where('category_id',$article->category_id);
                if($article->subcategory_id) $q->orWhere('subcategory_id',$article->subcategory_id);
            })
            ->orderByDesc('published_at')
            ->limit(5)
            ->get();

        $comments = Comment::where('article_id', $article->id)
            ->where('status',1)
            ->with('user')
            ->latest()
            ->get();
        // Bookmark check
        $userId = session('user_id');
        $isBookmarked = $userId
            ? Bookmark::where('user_id',$userId)->where('article_id',$article->id)->exists()
            : false;

 $ai = app()->make(\App\Services\AiSummaryService::class);

    $contentForAI =
        ($article->title ?? '') . "\n\n" .
        ($article->short_description ?? '') . "\n\n" .
        strip_tags($article->full_content ?? '');

    $aiSummary = $ai->generate($contentForAI);

    if(!$aiSummary){
        $aiSummary = [
            'summary' => ['AI summary not available'],
            'sector' => '',
            'impact' => []
        ];
    }

        return view('articles.show', compact('article','relatedArticles','comments','isBookmarked','aiSummary'));
    }

    // New: Toggle bookmark
    public function toggleBookmark(Request $request)
{
    // ✅ Session check
    if (!session()->has('user_id')) {
        return response()->json(['status' => 'error', 'message' => 'Please login first'], 401);
    }

    $userId = session('user_id');
    $articleId = $request->input('article_id');

    if (!$articleId) {
        return response()->json(['status' => 'error', 'message' => 'Invalid request'], 400);
    }

    $bookmark = Bookmark::where('user_id', $userId)
                                    ->where('article_id', $articleId)
                                    ->first();

    if ($bookmark) {
        $bookmark->delete();
        return response()->json(['status' => 'removed']);
    } else {
        Bookmark::create([
            'user_id' => $userId,
            'article_id' => $articleId
        ]);
        return response()->json(['status' => 'added']);
    }
}
 public function addComment(Request $request)
    {
        if (!session()->has('user_id')) {
            return redirect()->back()->with('error','Please login to comment.');
        }

        $request->validate([
            'article_id' => 'required|exists:articles,id',
            'content' => 'required|string|max:1000'
        ]);

        Comment::create([
            'article_id' => $request->article_id,
            'user_id' => session('user_id'),
            'content' => $request->content,
        ]);

        return redirect()->back()->with('success','Comment added.');
    }
}