@extends('components.app')

@section('content')
<div class="container">

    <h4 class="fw-bold mb-4">
        Activity Logs — {{ $user->name }}
    </h4>

    <div class="card shadow-sm p-3">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Action</th>
                    <th>IP</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                @foreach($activities as $log)
                    <tr>
                        <td>{{ $log->action }}</td>
                        <td>{{ $log->ip }}</td>
                        <td>{{ $log->created_at }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>

</div>
@endsection