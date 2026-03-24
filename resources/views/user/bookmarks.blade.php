@extends('components.app')

@section('content')

<div class="container my-4">

    <h3 class="fw-bold mb-4">🔖 My Bookmarks</h3>

    @if($bookmarks->count())

        @foreach($bookmarks as $bookmark)

            @if($bookmark->article)
            <div class="card shadow-sm mb-3 border-0">
                <div class="card-body">

                    <h5 class="fw-semibold">
                        {{ $bookmark->article->title }}
                    </h5>

                    <p class="text-muted small">
                        {{ Str::limit($bookmark->article->short_description, 120) }}
                    </p>

                    <div class="d-flex justify-content-between align-items-center">

                        <span class="badge bg-light text-dark">
                            {{ ucfirst($bookmark->article->status) }}
                        </span>

                        <a href="{{ route('articles.show', $bookmark->article->slug) }}"
                           class="btn btn-sm btn-primary">
                            Read Article
                        </a>

                    </div>

                </div>
            </div>
            @endif

        @endforeach

        {{-- Pagination --}}
        <div class="mt-4">
            {{ $bookmarks->links('pagination::bootstrap-5') }}
        </div>

    @else

        <div class="text-center py-5">
            <h5 class="text-muted">No bookmarks found.</h5>
        </div>

    @endif

</div>

@endsection