 @extends('components.app')

@section('content')
<div class="container mt-4">

<h4 class="fw-bold mb-4">Reports Dashboard</h4>

{{-- Selection List --}}
<form method="GET" action="{{ route('admin.reports.export') }}" class="mb-4">
    <div class="row g-2 align-items-center">
        <div class="col-md-4">
            <select name="type" class="form-select" required>
                <option value="">Select Report</option>
                <option value="most_viewed">Most Viewed Articles</option>
                <option value="category">Category Popularity</option>
                <option value="editor">Editor Publish Count</option>
                <option value="interaction">Most User Interaction</option>
            </select>
        </div>
        <div class="col-md-2">
            <button class="btn btn-primary w-100">
                Generate Excel
            </button>
        </div>
    </div>
</form>

{{-- Registration Chart Only --}}
<div class="card p-3 shadow-sm" style="max-width:600px;">
  <h6>📈 User Registrations</h6>
    <canvas id="userChart"></canvas>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
 
new Chart(document.getElementById('userChart'), {
    type: 'line',
    data: {
        labels: {!! json_encode($userRegistrations->pluck('date')) !!},
        datasets: [{
            label: 'Users',
            data: {!! json_encode($userRegistrations->pluck('total')) !!},
            borderColor: '#6f42c1',
            fill: false
        }]
    }
});
</script>

@endsection