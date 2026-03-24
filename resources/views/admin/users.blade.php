@extends('components.app')

@section('content')
<div class="container-fluid">

    <h4 class="fw-bold mb-4">👥 User Management</h4>

    <form method="GET" action="{{ route('admin.users') }}" class="mb-3">
    <div class="input-group position-relative">

        <input type="text"
               id="userSearchInput"
               name="search"
               class="form-control"
               placeholder="Search by user name..."
               autocomplete="off"
               value="{{ request('search') }}"  style=" box-shadow: none !important;border-color: #2563eb;">

        <div id="userSuggestionsBox"
             class="list-group position-absolute w-100"
             style="z-index:1000; top:100%; left:0;"></div>

        {{-- Preserve filters --}}
        @if(request('role'))
            <input type="hidden" name="role" value="{{ request('role') }}">
        @endif

        @if(request('status'))
            <input type="hidden" name="status" value="{{ request('status') }}">
        @endif  
        <button class="btn btn-primary h-100">Search</button>

        @if(request('search'))
            <a href="{{ route('admin.users') }}"
               class="btn btn-outline-secondary">
                Clear
            </a>
        @endif

    </div>
</form>

    {{-- Filters --}}
    <div class="mb-3">
       <div class="mb-3">
    <a href="{{ route('admin.users') }}"
       class="btn btn-sm {{ request()->has('role') || request()->has('status') ? 'btn-outline-primary' : 'btn-primary' }}">
        All Users
    </a>

    <a href="?role=editor"
       class="btn btn-sm {{ request('role') == 'editor' ? 'btn-primary' : 'btn-outline-secondary' }}">
        Editors
    </a>

    <a href="?role=admin"
       class="btn btn-sm {{ request('role') == 'admin' ? 'btn-primary' : 'btn-outline-secondary' }}">
        Admins
    </a>

    <a href="?status=blocked"
       class="btn btn-sm {{ request('status') == 'blocked' ? 'btn-danger' : 'btn-outline-danger' }}">
        Blocked
    </a>
</div>
    </div>

    {{-- Users Table --}}
    <div class="card shadow-sm p-3">
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Last Login</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($users as $user)
                        <tr>
                            <td>{{ $user->id }}</td>
                            <td>{{ $user->name }}</td>
                            <td>{{ $user->email }}</td>
                            <td>
                                <span class="badge bg-info text-dark">
                                    {{ ucfirst($user->role) }}
                                </span>
                            </td>
                            <td>
                                @if($user->status === 'active')
                                    <span class="badge bg-success">Active</span>
                                @else
                                    <span class="badge bg-danger">Blocked</span>
                                @endif
                            </td>
                            <td>
                                {{ $user->last_login ?? 'Never' }}
                            </td>
                               <td class="d-flex gap-2">

    {{-- Promote --}}
    @if($user->role === 'user')
        <form action="{{ route('admin.users.promote', $user->id) }}" method="POST">
            @csrf
            <button class="btn btn-sm btn-success">
                Promote
            </button>
        </form>
    @endif
    {{-- Block / Unblock --}}
    <form action="{{ route('admin.users.block', $user->id) }}" method="POST">
        @csrf
        <button class="btn btn-sm {{ $user->status === 'active' ? 'btn-danger' : 'btn-success' }}">
            {{ $user->status === 'active' ? 'Block' : 'Unblock' }}
        </button>
    </form>

    {{-- View Activity --}}
     <form action="{{route('admin.users.activity', $user->id)}}" method="POST">
        @csrf
        <button class="btn btn-sm btn-primary">
            Activity
        </button>
    </form> 
</td> 

                        </tr>
                    @endforeach
                </tbody>

            </table>
            <div class="mt-4">
        {{ $users->links('pagination::bootstrap-5') }}
    </div>
        </div>
    </div>

</div>
@endsection
<script>
document.addEventListener("DOMContentLoaded", function () {

    const input = document.getElementById("userSearchInput");
    const box = document.getElementById("userSuggestionsBox");

    input.addEventListener("keyup", function () {

        let query = this.value;

        if (query.length < 2) {
            box.innerHTML = "";
            box.style.display = "none";
            return;
        }

        fetch("{{ route('admin.users.suggestions') }}?search=" + query)
            .then(response => response.json())
            .then(data => {

                box.innerHTML = "";

                if (data.length === 0) {
                    box.style.display = "none";
                    return;
                }

                box.style.display = "block";

                data.forEach(name => {

                    let item = document.createElement("a");
                    item.href = "#";
                    item.className = "list-group-item list-group-item-action";
                    item.textContent = name;

                    item.addEventListener("click", function (e) {
                        e.preventDefault();
                        input.value = name;
                        box.innerHTML = "";
                        box.style.display = "none";
                    });

                    box.appendChild(item);
                });

            })
            .catch(error => console.log(error));
    });

    document.addEventListener("click", function (e) {
        if (!input.contains(e.target) && !box.contains(e.target)) {
            box.style.display = "none";
        }
    });

});
</script>