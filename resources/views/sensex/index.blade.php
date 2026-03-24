@extends('components.app')

@section('content')
<div class="container my-4">

    <!-- NIFTY & SENSEX SIDE BY SIDE -->
    <div class="row g-4 mb-4">

        <!-- NIFTY -->
        <div class="col-lg-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="fw-bold">NIFTY 50</h5>
                    @if($nifty)
                        <h3>
                            ₹{{ number_format($nifty['price'],2) }}
                            <span class="{{ $nifty['percent'] >= 0 ? 'text-success' : 'text-danger' }}">
                                ({{ $nifty['percent'] }}%)
                            </span>
                        </h3>
                        <div style="height:250px;">
                            <canvas id="niftyChart"></canvas>
                        </div>
                    @else
                        <p>No Data</p>
                    @endif
                </div>
            </div>
        </div>

        <!-- SENSEX -->
        <div class="col-lg-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="fw-bold">SENSEX</h5>
                    @if($sensex)
                        <h3>
                            ₹{{ number_format($sensex['price'],2) }}
                            <span class="{{ $sensex['percent'] >= 0 ? 'text-success' : 'text-danger' }}">
                                ({{ $sensex['percent'] }}%)
                            </span>
                        </h3>
                        <div style="height:250px;">
                            <canvas id="sensexChart"></canvas>
                        </div>
                    @else
                        <p>No Data</p>
                    @endif
                </div>
            </div>
        </div>

    </div>

  <div class="row g-4 mt-3">

    <!-- NIFTY 50 -->
    <div class="col-lg-6">
        <div class="card shadow-sm">
            <div class="card-body">

                <h5 class="fw-bold mb-3">Nifty 50 Companies</h5>

                <div class="table-responsive" style="max-height:350px; overflow-y:auto;">
                    <table class="table table-bordered table-sm">

                        <thead class="table-dark">
                            <tr>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Change</th>
                                <th>%</th>
                            </tr>
                        </thead>

                        <tbody>
                        @foreach($niftyStocks as $s)
                            <tr>
                                <td>
                                    {{ $s['name'] }}
                                    <div class="small text-muted">{{ $s['exchange'] }}</div>
                                </td>

                                <td>{{ $s['price'] }}</td>

                                <td class="{{ str_contains($s['change'],'-') ? 'text-danger':'text-success' }}">
                                    {{ $s['change'] }}
                                </td>

                                <td class="{{ str_contains($s['percent'],'-') ? 'text-danger':'text-success' }}">
                                    {{ $s['percent'] }}
                                </td>
                            </tr>
                        @endforeach
                        </tbody>

                    </table>
                </div>

            </div>
        </div>
    </div>

    <!-- SENSEX -->
    <div class="col-lg-6">
        <div class="card shadow-sm">
            <div class="card-body">

                <h5 class="fw-bold mb-3">Sensex Companies</h5>

                <div class="table-responsive" style="max-height:350px; overflow-y:auto;">
                    <table class="table table-bordered table-sm">

                        <thead class="table-dark">
                            <tr>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Change</th>
                                <th>%</th>
                            </tr>
                        </thead>

                        <tbody>
                        @foreach($sensexStocks as $s)
                            <tr>
                                <td>
                                    {{ $s['name'] }}
                                    <div class="small text-muted">{{ $s['exchange'] }}</div>
                                </td>
                                <td>{{ $s['price'] ?? 'N/A' }}</td>
                                <td class="{{ str_contains($s['change'] ?? '', '-') ? 'text-danger':'text-success' }}">
                                    {{ $s['change'] ?? 'N/A' }}
                                </td>
                                <td class="{{ str_contains($s['percent'] ?? '', '-') ? 'text-danger':'text-success' }}">
                                    {{ $s['percent'] ?? 'N/A' }}
                                </td>
                            </tr>
                        @endforeach
                        </tbody>

                    </table>
                </div>

            </div>
        </div>
    </div>

</div>


<!-- SECOND ROW -->

<div class="row g-4 mt-2">

    <!-- BANK NIFTY -->
    <div class="col-lg-6">
        <div class="card shadow-sm">
            <div class="card-body">

                <h5 class="fw-bold mb-3">Bank Nifty Companies</h5>

                <div class="table-responsive" style="max-height:350px; overflow-y:auto;">
                    <table class="table table-bordered table-sm">

                        <thead class="table-dark">
                            <tr>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Change</th>
                                <th>%</th>
                            </tr>
                        </thead>

                        <tbody>
                        @foreach($bankNiftyStocks as $s)
                            <tr>
                                <td>
                                    {{ $s['name'] }}
                                    <div class="small text-muted">{{ $s['exchange'] }}</div>
                                </td>

                                <td>{{ $s['price'] }}</td>

                                <td class="{{ str_contains($s['change'],'-') ? 'text-danger':'text-success' }}">
                                    {{ $s['change'] }}
                                </td>

                                <td class="{{ str_contains($s['percent'],'-') ? 'text-danger':'text-success' }}">
                                    {{ $s['percent'] }}
                                </td>
                            </tr>
                        @endforeach
                        </tbody>

                    </table>
                </div>

            </div>
        </div>
    </div>

    <!-- NIFTY IT -->
    <div class="col-lg-6">
        <div class="card shadow-sm">
            <div class="card-body">

                <h5 class="fw-bold mb-3">Nifty IT Companies</h5>

                <div class="table-responsive" style="max-height:350px; overflow-y:auto;">
                    <table class="table table-bordered table-sm">

                        <thead class="table-dark">
                            <tr>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Change</th>
                                <th>%</th>
                            </tr>
                        </thead>

                        <tbody>
                        @foreach($niftyITStocks as $s)
                            <tr>
                                <td>
                                    {{ $s['name'] }}
                                    <div class="small text-muted">{{ $s['exchange'] }}</div>
                                </td>

                                <td>{{ $s['price'] }}</td>

                                <td class="{{ $s['change'] < 0 ? 'text-danger':'text-success' }}">
                                    {{ $s['change'] }}
                                </td>

                                <td class="{{ str_contains($s['percent'],'-') ? 'text-danger':'text-success' }}">
                                    {{ $s['percent'] }}
                                </td>
                            </tr>
                        @endforeach
                        </tbody>

                    </table>
                </div>

            </div>
        </div>
    </div>

</div>
 
  <div class="container my-4">
    <div class="row">
        <div class="col-lg-12">

            <div class="card shadow-sm">
                <div class="card-body">

                    <h5 class="fw-bold mb-4">Latest Market News</h5>

                    @forelse($marketNews as $index => $news)

                        <div class="mb-3 border-bottom pb-3 {{ $index >= 5 ? 'extra-news d-none' : '' }}">
                            <a href="{{ route('news.show', urlencode($news['title'])) }}"  
                               class="fw-semibold text-decoration-none text-dark d-block">
                                {{ $news['title'] }}
                            </a>

                            <div class="small text-muted mt-1">
                                {{ \Carbon\Carbon::parse($news['publishedAt'])->diffForHumans() }}
                            </div>
                        </div>

                    @empty
                        <p class="text-muted">No Market News Available</p>
                    @endforelse

                    @if(count($marketNews) > 5)
                        <div class="text-end mt-3">
                            <a href="javascript:void(0)" id="loadMoreNews" 
                               class="fw-semibold text-primary text-decoration-none">
                                View More News →
                            </a>
                        </div>
                    @endif

                </div>
            </div>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
@if($nifty)
new Chart(document.getElementById('niftyChart'), {
    type: 'line',
    data: {
        labels: @json(array_map(fn($ts)=>date('H:i',$ts), $nifty['timestamps'])),
        datasets: [{
            data: @json($nifty['closes']),
            borderColor: '#22c55e',
            fill: false,
            tension: 0.3,
            pointRadius: 0
        }]
    },
    options: { plugins:{legend:{display:false}}, scales:{x:{display:false}} }
});
@endif

@if($sensex)
new Chart(document.getElementById('sensexChart'), {
    type: 'line',
    data: {
        labels: @json(array_map(fn($ts)=>date('H:i',$ts), $sensex['timestamps'])),
        datasets: [{
            data: @json($sensex['closes']),
            borderColor: '#ef4444',
            fill: false,
            tension: 0.3,
            pointRadius: 0
        }]
    },
    options: { plugins:{legend:{display:false}}, scales:{x:{display:false}} }
});
@endif
</script>
<script>
document.addEventListener("DOMContentLoaded", function(){

    const btn = document.getElementById("loadMoreNews");

    if(btn){
        btn.addEventListener("click", function(){

            document.querySelectorAll(".extra-news").forEach(function(el){
                el.classList.remove("d-none");
            });

            btn.style.display = "none";
        });
    }

});
</script>
@endsection
