@extends('components.app')

@section('content')
<div class="container mt-4">

<h4 class="fw-bold mb-3">💬 Comment Moderation</h4>

@if(session('success'))
<div class="alert alert-success">{{ session('success') }}</div>
@endif

<form method="GET" action="{{ route('admin.comments') }}" class="mb-3">

    <div class="row g-2">

        {{-- Select User --}}
        <div class="col-md-4">
            <select name="user_id" class="form-select">
                <option value="">All Users</option>
                @foreach($users as $user)
                    <option value="{{ $user->id }}"
                        {{ request('user_id') == $user->id ? 'selected' : '' }}>
                        {{ $user->name }}
                    </option>
                @endforeach
            </select>
        </div>

        {{-- Select Article --}}
        <div class="col-md-4">
            <select name="article_id" class="form-select">
                <option value="">All Articles</option>
                @foreach($articles as $article)
                    <option value="{{ $article->id }}"
                        {{ request('article_id') == $article->id ? 'selected' : '' }}>
                        {{ $article->title }}
                    </option>
                @endforeach
            </select>
        </div>

        {{-- Buttons --}}
        <div class="col-md-4 d-flex gap-2">
            <button class="btn btn-primary w-50">Filter</button>

            <a href="{{ route('admin.comments') }}"
               class="btn btn-outline-secondary w-50">
               Reset
            </a>
        </div>

    </div>
</form>

<div class="card p-3 shadow-sm">

<table class="table table-bordered">
<thead>
<tr>
<th>User</th>
<th>Comment</th>
<th>Article</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>

<tbody>
@foreach($comments as $comment)
<tr>
<td>{{ $comment->user_name }}</td>
<td>{{ $comment->content }}</td>
<td>{{ $comment->article_title }}</td>

<td>
@if($comment->status == 1)
<span class="badge bg-success">Approved</span>
@else
<span class="badge bg-warning">Pending</span>
@endif
</td>

<td class="d-flex gap-2">

@if($comment->status == 0)
<form action="{{ route('admin.comments.approve',$comment->id) }}" method="POST">
@csrf
<button class="btn btn-sm btn-success">Approve</button>
</form>
@endif

<form action="{{ route('admin.comments.delete',$comment->id) }}" method="POST">
@csrf
<button class="btn btn-sm btn-danger">Delete</button>
</form>

<form action="{{ route('admin.users.ban',$comment->user_id) }}" method="POST">
@csrf
<button class="btn btn-sm btn-primary">Ban</button>
</form>

</td>
</tr>
@endforeach
</tbody>
</table>

{{ $comments->links('pagination::bootstrap-5') }}

</div>
</div>
@endsection