@extends('components.app')

@section('content')
<div class="container mt-4">

<h4 class="fw-bold mb-4">📊 Reports Dashboard</h4>

{{-- Most Viewed --}}
<div class="card p-3 mb-4 shadow-sm">
<h5>🔥 Most Viewed Articles</h5>
<table class="table">
@foreach($mostViewed as $article)
<tr>
<td>{{ $article->title }}</td>
<td><strong>{{ $article->views }}</strong> Views</td>
</tr>
@endforeach
</table>
</div>

{{-- Category Popularity --}}
<div class="card p-3 mb-4 shadow-sm">
<h5>📂 Category Popularity</h5>
<table class="table">
@foreach($categoryPopularity as $cat)
<tr>
<td>{{ $cat->name }}</td>
<td>{{ $cat->total_articles }} Articles</td>
</tr>
@endforeach
</table>
</div>

{{-- Editor Publish --}}
<div class="card p-3 mb-4 shadow-sm">
<h5>✍ Editor Publish Count</h5>
<table class="table">
@foreach($editorPublish as $editor)
<tr>
<td>{{ $editor->name }}</td>
<td>{{ $editor->total_published }} Published</td>
</tr>
@endforeach
</table>
</div>

{{-- Interaction --}}
<div class="card p-3 mb-4 shadow-sm">
<h5>💬 Most User Interaction</h5>
<table class="table">
@foreach($interaction as $item)
<tr>
<td>{{ $item->title }}</td>
<td>
Views: {{ $item->views }} |
Comments: {{ $item->total_comments }} |
Score: {{ $item->interaction_score }}
</td>
</tr>
@endforeach
</table>
</div>

{{-- Users Registration Chart --}}
<div class="card p-4 shadow-sm">
<h5>📈 User Registrations Per Date</h5>

<canvas id="userChart" height="100"></canvas>

</div>

</div>

{{-- Chart.js CDN --}}
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
const ctx = document.getElementById('userChart').getContext('2d');

new Chart(ctx, {
    type: 'line',
    data: {
        labels: {!! json_encode($userRegistrations->pluck('date')) !!},
        datasets: [{
            label: 'Users Registered',
            data: {!! json_encode($userRegistrations->pluck('total')) !!},
            borderColor: '#2563eb',
            backgroundColor: 'rgba(37,99,235,0.2)',
            tension: 0.3
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: { display: true }
        }
    }
});
</script>

@endsection