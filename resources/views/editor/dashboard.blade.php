@extends('components.app')

@section('content')
<style>
    body.dark .list-group-item{
         background: #1e293b;
         color:white;
    }
</style>

<h3 class="mb-4">Editor Dashboard</h3>

<div class="row g-4">

    <div class="col-md-3">
        <a href="{{route('articles')}}" class="text-decoration-none text-dark">
        <div class="card shadow-sm p-3">
            <h6>My Articles</h6>
            <h3>{{ $totalArticles }}</h3>
        </div></a>
    </div>

    <div class="col-md-3">
        <a href="{{route('articles')}}" class="text-decoration-none text-dark">
        <div class="card shadow-sm p-3">
            <h6>Published</h6>
            <h3>{{ $published }}</h3>
        </div>
        </a>
    </div>

    <div class="col-md-3">
        <a href="{{route('articles')}}" class="text-decoration-none text-dark">
        <div class="card shadow-sm p-3">
            <h6>Drafts</h6>
            <h3>{{ $drafts }}</h3>
        </div></a>
    </div>

    <div class="col-md-3">
        <a href="{{route('comments.index')}}" class="text-decoration-none text-dark">
        <div class="card shadow-sm p-3">
            <h6>Views</h6>
            <h3>{{ number_format($totalViews) }}</h3>
        </div></a>
    </div>

</div>

<hr class="my-5">

<h5>Recent Activity</h5>

<ul class="list-group shadow-sm">
    <a href="{{route('articles')}}" class="text-decoration-none text-dark">
    <li class="list-group-item">
        🕒 {{ $pendingReview }} Articles Awaiting Review
    </li>
</a>
</ul>

@endsection