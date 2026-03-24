@extends('components.app')

@section('content')
<div class="card shadow-sm p-4 col-md-6 mx-auto mt-4">
    <h4 class="fw-bold mb-4 text-center">My Profile</h4>

    {{-- Success Message --}}
    @if(session('success'))
        <div class="alert alert-success">
            {{ session('success') }}
        </div>
    @endif

    {{-- Validation Errors --}}
    @if ($errors->any())
        <div class="alert alert-danger">
            <ul class="mb-0">
                @foreach ($errors->all() as $error)
                    <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    {{-- Avatar Display --}}
    <div class="text-center mb-4">
        @if($user->avatar)
            <img src="{{ asset('images/news/'.$user->avatar) }}"
                 alt="avatar"
                 class="rounded-circle border shadow"
                 style="height:120px; width:120px; object-fit:cover;">
        @else
            <img src="https://via.placeholder.com/120"
                 class="rounded-circle shadow">
        @endif
    </div>

    <form action="{{ route('admin.profile.update') }}"
          method="POST"
          enctype="multipart/form-data">
        @csrf

        <div class="mb-3">
            <label>Name</label>
            <input type="text"
                   name="name"
                   class="form-control"
                   value="{{ old('name', $user->name) }}"
                   required>
        </div>

        <div class="mb-3">
            <label>Email</label>
            <input type="email"
                   name="email"
                   class="form-control"
                   value="{{ old('email', $user->email) }}"
                   required>
        </div>

        <div class="mb-3">
            <label>Password <small>(leave blank if not changing)</small></label>
            <input type="password"
                   name="password"
                   class="form-control">
        </div>

        <div class="mb-3">
            <label>Confirm Password</label>
            <input type="password"
                   name="password_confirmation"
                   class="form-control">
        </div>

        <div class="mb-3">
            <label>Avatar</label>
            <input type="file"
                   name="avatar"
                   class="form-control">
        </div>

        <div class="mb-3">
            <label>Languages <small>(comma-separated)</small></label>
            <input type="text"
                   name="language"
                   class="form-control"
                   value="{{ old('language', $user->language) }}">
        </div>

        <div class="mb-3">
            <label>Role</label>
            <input type="text"
                   class="form-control"
                   value="{{ $user->role }}"
                   disabled>
        </div>

        <div class="mb-3">
            <label>Created At</label>
            <input type="text"
                   class="form-control"
                   value="{{ \Carbon\Carbon::parse($user->created_at)->format('d M Y H:i') }}"
                   disabled>
        </div>

        <button type="submit" class="btn btn-success w-100">
            Update Profile
        </button>
    </form>
</div>
@endsection