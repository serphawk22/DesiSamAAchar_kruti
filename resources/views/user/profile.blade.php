@extends('components.app')

@section('content')

<div class="container my-5" style="max-width:750px;">

    <div class="card shadow border-0">
        <div class="card-body p-4">

            <h4 class="fw-bold mb-4 text-center">My Profile</h4>

            {{-- Success Message --}}
            @if(session('success'))
                <div class="alert alert-success">
                    {{ session('success') }}
                </div>
            @endif

            {{-- Error Message --}}
            @if(session('error'))
                <div class="alert alert-danger">
                    {{ session('error') }}
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


            {{-- Avatar Section --}}
            <div class="text-center mb-4">
                @if($user->avatar)
                    <img src="{{ asset($user->avatar) }}"
                         class="rounded-circle shadow"
                         width="130"
                         height="130"
                         style="object-fit:cover;">
                @else
                    <img src="https://via.placeholder.com/130"
                         class="rounded-circle shadow">
                @endif
            </div>


            {{-- Profile Form --}}
            <form action="{{ route('profile.update') }}"
                  method="POST"
                  enctype="multipart/form-data">

                @csrf

                {{-- Name --}}
                <div class="mb-3">
                    <label class="form-label fw-bold">Full Name</label>
                    <input type="text"
                           name="name"
                           class="form-control"
                           value="{{ old('name', $user->name) }}">
                </div>

                {{-- Email --}}
                <div class="mb-3">
                    <label class="form-label fw-bold">Email Address</label>
                    <input type="email"
                           name="email"
                           class="form-control"
                           value="{{ old('email', $user->email) }}">
                </div>

                {{-- Language --}}
                <div class="mb-3">
                    <label class="form-label fw-bold">Language</label>
                    <input type="text"
                           name="language"
                           class="form-control"
                           value="{{ old('language', $user->language) }}"
                           placeholder="e.g. English">
                </div>

                {{-- Upload Avatar --}}
                <div class="mb-3">
                    <label class="form-label fw-bold">Upload Avatar</label>
                    <input type="file"
                           name="avatar"
                           class="form-control">
                </div>

                <hr class="my-4">

                {{-- Change Password --}}
                <h5 class="fw-bold mb-3">Change Password</h5>

               <div class="mb-3">
    <label class="form-label fw-bold">
        Password 
        <small class="text-muted">(leave blank if not changing)</small>
    </label>
    <input type="password"
           name="password"
           class="form-control">
</div>

<div class="mb-3">
    <label class="form-label fw-bold">Confirm Password</label>
    <input type="password"
           name="password_confirmation"
           class="form-control">
</div>

                <hr class="my-4">

                {{-- Account Info (Read Only) --}}
                <h5 class="fw-bold mb-3">Account Information</h5>

                <div class="mb-3">
                    <label class="form-label">Role</label>
                    <input type="text"
                           class="form-control"
                           value="{{ ucfirst($user->role) }}"
                           readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label">Status</label>
                    <input type="text"
                           class="form-control"
                           value="{{ ucfirst($user->status) }}"
                           readonly>
                </div>

                

                <button type="submit" class="btn btn-primary w-100 mt-3">
                    Update Profile
                </button>

            </form>

        </div>
    </div>

</div>

@endsection