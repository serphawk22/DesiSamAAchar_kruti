@extends('components.app')

@section('content')
<style>
    .ai-summary-box{
background:#f8f9ff;
border-left:4px solid #6f42c1;
padding:20px;
border-radius:8px;
}

.ai-summary-header{
font-weight:600;
margin-bottom:10px;
color:#6f42c1;
}

.ai-summary-list{
padding-left:18px;
}

.ai-summary-list li{
margin-bottom:6px;
}

.ai-impact ul{
padding-left:18px;
}
body.dark .ai-summary-box{
    background:#020617;
    border:1px solid #22c55e;
}

body.dark .ai-summary-header{
    color:#4ade80;
}
</style>

<div class="container mt-5">
    <div class="row">

        {{-- LEFT CONTENT --}}
      {{-- LEFT CONTENT --}}
<div class="col-lg-8">

    <div class="card shadow-sm p-4">

        {{-- Category --}}
        <div class="mb-2">
            <span class="badge bg-secondary">
                {{ $article->category->name ?? 'General' }}
            </span>

            @if($article->subcategory)
                <span class="badge bg-light text-dark border">
                    {{ $article->subcategory->name }}
                </span>
            @endif
        </div>

        {{-- Title --}}
        <h2 class="fw-bold mb-3">
            {{ $article->title }}
        </h2>

        {{-- Meta Info --}}
        <p class="text-muted small mb-4">
            By <strong>{{ $article->author->name ?? 'Editorial Team' }}</strong>
            • {{ optional($article->published_at)->format('F d, Y') }}
            • {{ $article->views }} Views
        </p>

        {{-- Media Container --}}
        @php
            $media = $article->media->first();
        @endphp

        @if($media)
            <div class="mb-4 text-center">

                @if($media->type === 'image')
                    <img src="{{ asset($media->file_url) }}"
                         class="img-fluid rounded"
                         style="max-height:450px; object-fit:cover;"
                         alt="{{ $article->title }}">

                @elseif($media->type === 'video')
                    <video controls class="w-100 rounded">
                        <source src="{{ asset($media->file_url) }}" type="video/mp4">
                    </video>

                @elseif($media->type === 'audio')
                    <audio controls style="width:350px;">
                        <source src="{{ asset($media->file_url) }}" type="audio/mpeg">
                    </audio>

                @elseif($media->type === 'document')
                    <a href="{{ asset($media->file_url) }}"
                       target="_blank"
                       class="btn btn-outline-secondary">
                        View Document
                    </a>
                @endif

            </div>
        @endif

        {{-- AI SUMMARY --}}
@if(!empty($aiSummary))
<div class="ai-summary-box mb-4">

    <div class="ai-summary-header">
        ✨ AI Powered Summary
    </div>

    <ul class="ai-summary-list">
        @foreach($aiSummary['summary'] ?? [] as $point)
            <li>{{ $point }}</li>
        @endforeach
    </ul>

    @if(!empty($aiSummary['sector']))
        <div class="mt-3">
            <strong>Sector:</strong> {{ $aiSummary['sector'] }}
        </div>
    @endif

<hr>

    @if(!empty($aiSummary['impact']))
        <div class="ai-impact mt-3">
            <div class="ai-summary-header">📊 How This News Impacts</div>
            <ul>
                @foreach($aiSummary['impact'] as $impact)
                    <li>{{ $impact }}</li>
                @endforeach
            </ul>
        </div>
    @endif

</div>
@endif

        {{-- Short Description --}}
        @if($article->short_description)
           <div class="short-desc-box p-3 mb-4 rounded border-start border-4">
                <p class="mb-0 fw-semibold">
                    {{ $article->short_description }}
                </p>
            </div>
        @endif

        {{-- Full Content --}}
        <div class="article-content" style="line-height:1.9; font-size:17px;">
            {!! $article->full_content !!}
        </div>

        <br/>
       <hr class="my-4">

{{-- Views & Bookmark --}}
<div class="d-flex justify-content-between align-items-center mb-4">
    <span><strong>{{ $article->views }}</strong> Views</span>

    @php
        $userId = session('user_id');
        $isBookmarked = $userId 
            ? \App\Models\Bookmark::where('user_id', $userId)
                                  ->where('article_id', $article->id)
                                  ->exists()
            : false;
    @endphp

    @if($userId)
        <button id="bookmarkBtn" 
            class="btn btn-sm {{ $isBookmarked ? 'btn-danger' : 'btn-outline-primary' }}">
            <i class="bi {{ $isBookmarked ? 'bi-bookmark-fill' : 'bi-bookmark' }}"></i>
            {{ $isBookmarked ? 'Remove Bookmark' : 'Add Bookmark' }}
        </button>
    @else
        <a href="{{ url('/login') }}" class="btn btn-sm btn-outline-primary">
            Login to bookmark
        </a>
    @endif
</div>

{{-- Comment Section --}}
<div class="card p-3 mb-4">
    <h5>Comments ({{ $comments->count() }})</h5>

    @if($userId)
        <form action="{{ route('articles.comment.add') }}" method="POST" class="mb-3">
            @csrf
            <input type="hidden" name="article_id" value="{{ $article->id }}">
            <textarea name="content" class="form-control mb-2" rows="3"
                placeholder="Add a comment..." required></textarea>
            <button class="btn btn-primary btn-sm">Submit Comment</button>
        </form>
    @else
        <p><a href="{{ url('/login') }}">Login</a> to add comment.</p>
    @endif

    @forelse($comments as $comment)
        <div class="mb-2 border-bottom pb-2">
            <strong>{{ $comment->user->name ?? 'User' }}</strong> 
             
            <p>{{ $comment->content }}</p>
        </div>
    @empty
        <p class="text-muted">No comments yet.</p>
    @endforelse
</div>


    </div>

</div>

        {{-- RIGHT SIDEBAR --}}
       <div class="col-lg-4">
    <div class="card shadow-sm p-3">

        <h5 class="mb-3" style="color:#6f42c1;">
            More From This Category
        </h5>
        @foreach($relatedArticles as $rel)

            <div class="mb-3 pb-3 border-bottom">

                <a href="{{ route('articles.show', $rel->slug) }}"
                   class="fw-bold text-decoration-none" style="color:#6f42c1;">
                    {{ $rel->title }}
                </a>

                <p class="small text-muted mb-1">
                    {{ Str::limit($rel->short_description, 80) }}
                </p>

                <small class="text-muted">
                    {{ $rel->author->name ?? 'Editorial Team' }}
                    • 
                    {{ optional($rel->published_at)->format('M d, Y') }}
                </small>

            </div>

        @endforeach
     @if($relatedArticles->isEmpty())
    <p class="small text-muted mb-1">
                    No Related Article Available
                </p>
    @endif
    </div>
</div>


    </div>
</div>
@if($userId)
<script>
document.addEventListener('DOMContentLoaded', function () {
    const btn = document.getElementById('bookmarkBtn');

    btn.addEventListener('click', function () {
        fetch("{{ route('articles.bookmark.toggle') }}", {
            method: 'POST',
            headers: {
                'X-CSRF-TOKEN': "{{ csrf_token() }}",
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                article_id: "{{ $article->id }}"
            })
        })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'added') {
                btn.classList.remove('btn-outline-primary');
                btn.classList.add('btn-danger');
                btn.innerHTML = '<i class="bi bi-bookmark-fill"></i> Remove Bookmark';
            } else if (data.status === 'removed') {
                btn.classList.remove('btn-danger');
                btn.classList.add('btn-outline-primary');
                btn.innerHTML = '<i class="bi bi-bookmark"></i> Add Bookmark';
            }
        })
        .catch(err => console.error(err));
    });
});
</script>
@endif
@endsection
