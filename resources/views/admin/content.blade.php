@extends('components.app')

@section('content')
<div class="container-fluid">

    <h4 class="fw-bold mb-4">📝 Content Management</h4>
    {{-- Search Bar --}}
<form method="GET" action="{{ route('admin.content') }}" class="mb-3">
    <div class="input-group">
  
    <input type="text"
           name="search"
           id="searchInput"
           class="form-control"
           placeholder="Search by article title..."
           autocomplete="off" style=" box-shadow: none !important;border-color: #2563eb;">

    <div id="suggestionsBox"
         class="list-group position-absolute w-100"
         style="z-index:1000; top:100%; left:0;"></div> 

        {{-- Preserve filters when searching --}}
        @if(request('status'))
            <input type="hidden" name="status" value="{{ request('status') }}">
        @endif

        @if(request('breaking'))
            <input type="hidden" name="breaking" value="1">
        @endif

        @if(request('trending'))
            <input type="hidden" name="trending" value="1">
        @endif

        <button class="btn btn-primary h-100">Search</button>

        @if(request('search'))
            <a href="{{ route('admin.content') }}"
               class="btn btn-outline-secondary">
               Clear
            </a>
        @endif

    </div>
</form>

    {{-- Filters --}}
    <div class="mb-3 d-flex gap-2 flex-wrap">

        <a href="{{ route('admin.content') }}"
           class="btn btn-sm {{ request()->hasAny(['status','breaking','trending']) ? 'btn-outline-primary' : 'btn-primary' }}">
            All Articles
        </a>

        <a href="?status=draft"
           class="btn btn-sm {{ request('status')=='draft' ? 'btn-primary' : 'btn-outline-secondary' }}">
            Drafts
        </a>

        <a href="?status=published"
           class="btn btn-sm {{ request('status')=='published' ? 'btn-primary' : 'btn-outline-secondary' }}">
            Published
        </a>

        <a href="?breaking=1"
           class="btn btn-sm {{ request('breaking') ? 'btn-danger' : 'btn-outline-danger' }}">
            Breaking News
        </a>

        <a href="?trending=1"
           class="btn btn-sm {{ request('trending') ? 'btn-warning' : 'btn-outline-warning' }}">
            Trending
        </a>

        <a href="?status=pending"
           class="btn btn-sm {{ request('status')=='pending' ? 'btn-success' : 'btn-outline-success' }}">
            Pending Review
        </a>

    </div>

    {{-- Articles Table --}}
    <div class="card shadow-sm p-3">
        <div class="table-responsive">

            <table class="table table-hover align-middle">

                <thead class="table-light">
                    <tr>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Category</th>
                        <th>Status</th>
                        <th>Views</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>
                    @foreach($articles as $article)
                        <tr>

                            <td>{{ $article->title }}</td>

                            <td>{{ $article->author->name ?? 'N/A' }}</td>

                            <td>{{ $article->category_id }}</td>

                            <td>
                                <span class="badge 
                                    @if($article->status=='published') bg-success
                                    @elseif($article->status=='pending') bg-warning
                                    @else bg-secondary @endif">
                                    {{ ucfirst($article->status) }}
                                </span>
                            </td>

                            <td>{{ $article->views }}</td>

                            <td class="d-flex gap-2">

                                {{-- Publish / Unpublish --}}
                                <form action="{{ route('admin.content.publish', $article->id) }}" method="POST">
                                    @csrf
                                    <button class="btn btn-primary 
                                        {{ $article->status=='published' ? 'btn-warning' : 'btn-success' }}">
                                        {{ $article->status=='published' ? 'Unpublish' : 'Publish' }}
                                    </button>
                                </form>

                                {{-- Delete --}}
                                <form action="{{ route('admin.content.delete', $article->id) }}" method="POST">
                                    @csrf
                                    <button class="btn btn-sm btn-danger">
                                        Delete
                                    </button>
                                </form>

                            </td>

                        </tr>
                    @endforeach
                </tbody>

            </table>
<div class="mt-4">
        {{ $articles->links('pagination::bootstrap-5') }}
    </div>
        </div>
    </div>

</div>
@endsection
<script>
document.addEventListener("DOMContentLoaded", function () {

    const input = document.getElementById("searchInput");
    const box = document.getElementById("suggestionsBox");

    input.addEventListener("keyup", function () {

        let query = this.value;

        if (query.length < 2) {
            box.innerHTML = "";
            box.style.display = "none";
            return;
        }

        fetch("/admin/content/suggestions?search=" + query)
            .then(response => response.json())
            .then(data => {

                box.innerHTML = "";

                if (data.length === 0) {
                    box.style.display = "none";
                    return;
                }

                box.style.display = "block";

                data.forEach(title => {

                    let item = document.createElement("a");
                    item.href = "#";
                    item.className = "list-group-item list-group-item-action";
                    item.textContent = title;

                    item.addEventListener("click", function (e) {
                        e.preventDefault();
                        input.value = title;
                        box.innerHTML = "";
                        box.style.display = "none";
                    });

                    box.appendChild(item);
                });

            })
            .catch(error => console.log(error));
    });

    // Hide suggestions if clicked outside
    document.addEventListener("click", function (e) {
        if (!input.contains(e.target) && !box.contains(e.target)) {
            box.style.display = "none";
        }
    });

});
</script>