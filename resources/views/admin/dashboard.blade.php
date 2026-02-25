@extends('components.app')

@section('content')
<div class="container-fluid">

    <h4 class="mb-4 fw-bold">📊 Admin Dashboard</h4>

    {{-- 🔹 Overview Cards --}}
    <div class="row g-4">

        <div class="col-md-3">
            <div class="card shadow-sm p-3 text-center">
                <h6>Total Users</h6>
                <h3>{{ $totalUsers }}</h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card shadow-sm p-3 text-center">
                <h6>Total Editors</h6>
                <h3>{{ $totalEditors }}</h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card shadow-sm p-3 text-center">
                <h6>Total Articles</h6>
                <h3>{{ $totalArticles }}</h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card shadow-sm p-3 text-center">
                <h6>Active Today</h6>
                <h3>{{ $activeToday }}</h3>
            </div>
        </div>

    </div>

    {{-- 🔹 AI Requests --}}
   <!-- <div class="row mt-4">
        <div class="col-md-3">
            <div class="card shadow-sm p-3 text-center bg-light">
                <h6>AI Requests</h6>
                <h3>{{ $aiRequests }}</h3>
            </div>
        </div>
    </div>-->

    {{-- 🔹 Traffic Chart --}}
    <div class="card mt-5 shadow-sm p-4">
        <h5 class="mb-3">📈 Visitors (Last 7 Days)</h5>
        <canvas id="trafficChart"></canvas>
    </div>

    {{-- 🔹 Trending Topics --}}
    <div class="card mt-5 shadow-sm p-4">
        <h5 class="mb-3">🔥 Trending Topics</h5>

        <ul class="list-group">
            @foreach($trending as $item)
                <li class="list-group-item d-flex justify-content-between">
                    {{ $item->title }}
                    <span class="badge bg-danger">{{ $item->views }} views</span>
                </li>
            @endforeach
        </ul>
    </div>

</div>


{{-- Chart Script --}}
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
const ctx = document.getElementById('trafficChart');

new Chart(ctx, {
    type: 'line',
    data: {
        labels: {!! json_encode($traffic->pluck('date')) !!},
        datasets: [{
            label: 'Articles Published',
            data: {!! json_encode($traffic->pluck('total')) !!},
            borderWidth: 2,
            fill: false
        }]
    }
});
</script>

@endsection