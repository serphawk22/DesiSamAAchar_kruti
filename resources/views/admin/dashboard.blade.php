@extends('components.app')

@section('content')
<style>
    body.dark .list-group-item-primary{
        background-color:#1e293b;
    }
</style>
<div class="container-fluid">

    <h4 class="mb-4 fw-bold">📊 Admin Dashboard</h4>

    {{-- 🔹 Overview Cards --}}
    <div class="row g-4">

        <div class="col-md-3">
             <a href="{{ route('admin.users') }}" class="text-decoration-none text-dark">
            <div class="card shadow-sm p-3 text-center">
                <h6>Total Users</h6>
                <h3>{{ $totalUsers }}</h3>
            </div></a>
        </div>

        <div class="col-md-3">
            <a href="{{ route('admin.users') }}" class="text-decoration-none text-dark">
            <div class="card shadow-sm p-3 text-center">
                <h6>Total Editors</h6>
                <h3>{{ $totalEditors }}</h3>
            </div></a>
        </div>

        <div class="col-md-3"><a href="{{ route('admin.content') }}" class="text-decoration-none text-dark">
            <div class="card shadow-sm p-3 text-center">
                <h6>Total Articles</h6>
                <h3>{{ $totalArticles }}</h3>
            </div></a>
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
 <br/>
  <ul class="list-group shadow-sm mb-3">
    <li class="list-group-item d-flex justify-content-between align-items-center 
        {{ $pendingArticles > 0 ? 'list-group-item-primary' : '' }}">
        
        <div>
            🕒 <strong>{{ $pendingArticles }}</strong> Articles Awaiting Review
        </div>

        @if($pendingArticles > 0)
            <a href="{{ route('admin.content') }}" 
               class="btn btn-sm btn-primary">
                Review Now
            </a>
        @endif
    </li>
</ul>

    {{-- 🔹 Traffic Chart --}}
   {{-- 🔹 User Activity Chart --}}
<div class="card mt-5 shadow-sm p-4">
    <h5 class="mb-3">👤 Visitors (Last 7 Days)</h5>
    <canvas id="trafficChart"  height="220"></canvas>
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
            label: 'User Logins',
            data: {!! json_encode($traffic->pluck('total')) !!},
            borderWidth: 2,
            tension: 0.4,
            fill: false
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                display: true
            }
        }
    }
});
</script>

@endsection