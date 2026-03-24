@extends('components.app')

@section('content')
<style>
    a{
        color:black;
        text-decoration:none;
    }
    .search-box {
    max-width:700px;
    width:100%;
    position:relative;
}

.search-input {
    width:100%;
    padding:12px;
    border-radius:8px; 
}
 
.metric-card {
    background-color: #f8f9fa; /* light gray */
    border-radius: 12px;
    padding: 20px;
    text-align: center;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    margin-bottom: 20px;
    transition: transform 0.2s, box-shadow 0.2s;
}

.metric-card h6 {
    font-weight: 600;
    color: #6c757d;
    margin-bottom: 10px;
}

.metric-card h5 {
    font-weight: 700;
    font-size: 1.4rem;
    color: #343a40;
}

.metric-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}

.metric-row {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

body.dark .metric-card {
    background-color: #1b1b25;
    color: #e0e0e0;
    box-shadow: 0 4px 10px rgba(255,255,255,0.05);
}

body.dark .metric-card h6 {
    color: #a0a0a0;
}

body.dark .metric-card h5 {
    color: #ffffff;
}

body.dark .metric-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 20px rgba(255,255,255,0.1);
}
</style> 
<div class="container mt-4">

    <!-- Top Search -->
    <div class="row mb-4">
        <div class="col-md-6 position-relative">
           <div class="search-box">
        <input type="text" id="searchInput" class="search-input"
               placeholder="Search for companies and stocks" style=" box-shadow: none !important;border-color: #2563eb;">

        <ul id="suggestions" class="list-group position-absolute w-100"></ul>
    </div>
        </div>
    </div>

    <!-- Company Header -->
    <div class="d-flex justify-content-between mb-4">
        <div>
            <h2 class="fw-bold">
                {{ $company['name'] ?? 'N/A' }}
            </h2>
            <span class="text-muted">
                {{ $company['ticker'] ?? $company['symbol'] ?? '' }}
            </span>
        </div>

        <div class="text-end">
            <h3>₹{{ number_format($quote['c'] ?? 0, 2) }}</h3>
            <span class="{{ ($quote['d'] ?? 0) >= 0 ? 'text-success':'text-danger' }}">
                {{ $quote['d'] ?? 0 }}
                ({{ $quote['dp'] ?? 0 }}%)
            </span>
        </div>
    </div>


    <div class="row">
        <!-- Chart -->
        <div class="col-lg-8">
            <div class="card p-3">
                <canvas id="companyChart"></canvas>
            </div>
        </div>

        <!-- Key Stats -->
        <div class="col-lg-4">
            <div class="card p-3">
                <h6>Key Stats</h6>
                <p>Open: ₹{{ $quote['o'] ?? '-' }}</p>
                <p>High: ₹{{ $quote['h'] ?? '-' }}</p>
                <p>Low: ₹{{ $quote['l'] ?? '-' }}</p>
                <p>Previous Close: ₹{{ $quote['pc'] ?? '-' }}</p> 
            </div>
        </div>
    </div>

 
    <!-- Fundamentals -->
    <div class="mt-5">
    <h3 class="mb-3">Peer Comparison</h3>

    @if(!empty($peers))
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Company</th>
                        <th class="text-end">LTP (₹)</th>
                        <th class="text-end">Market Cap (₹ Cr.)</th>
                        <th class="text-end">P/E</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($peers as $peer)
                        <tr>
                            <td>
                                <a href="{{ route('company.show', $peer['symbol']) }}" 
                                   class="fw-semibold text-decoration-none">
                                    {{ $peer['name'] }}
                                </a>
                                <div class="text-muted small">
                                    {{ $peer['symbol'] }}
                                </div>
                            </td>

                            <td class="text-end">
                                {{ $peer['ltp'] ? number_format($peer['ltp'], 2) : 'N/A' }}
                            </td>

                            <td class="text-end">
                                {{ $peer['marketCap'] ?? 'N/A' }}
                            </td>

                            <td class="text-end">
                                {{ $peer['pe'] ?? 'N/A' }}
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    @else
        <div class="alert alert-secondary">
            No peers found for this sector.
        </div>
    @endif
</div>

<div class="mt-5">
    <h3 class="mb-3">Fundamentals</h3>

    <div class="row g-3"> <!-- g-3 adds gutters (spacing) between columns -->
        <div class="col-md-3 col-sm-6">
            <div class="metric-card p-3 text-center border rounded">
                <h6>Market Cap</h6>
                <h5>{{ $scrapedData['marketCap'] ?? 'N/A' }}</h5>
            </div>
        </div>

        <div class="col-md-3 col-sm-6">
            <div class="metric-card p-3 text-center border rounded">
                <h6>Book Value</h6>
                <h5>{{ $scrapedData['bookValue'] ?? 'N/A' }}</h5>
            </div>
        </div>

        <div class="col-md-3 col-sm-6">
            <div class="metric-card p-3 text-center border rounded">
                <h6>Dividend Yield</h6>
                <h5>{{ $scrapedData['dividendYield'] ?? 'N/A' }}</h5>
            </div>
        </div>

        <div class="col-md-3 col-sm-6">
            <div class="metric-card p-3 text-center border rounded">
                <h6>ROE</h6>
                <h5>{{ $scrapedData['roe'] ?? 'N/A' }}</h5>
            </div>
        </div>
    </div>
</div>

 
<!-- ================= QUARTERLY FINANCIALS ================= -->
<div class="mt-5">
    <h3 class="mb-3">Quarterly Financial Results</h3>
    @if(!empty($quarterly['headers']))
    <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
        <table class="table table-bordered table-hover mb-0">
            <thead class="table-dark">
                <tr>
                    @foreach($quarterly['headers'] as $header)
                        <th>{{ $header }}</th>
                    @endforeach
                </tr>
            </thead>
            <tbody>
                @foreach($quarterly['rows'] as $row)
                    <tr>
                         @foreach($row as $col)
                            <td>{{ !empty($col) ? $col : 'N/A' }}</td>
                        @endforeach
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>
    @else
        <p>No quarterly data available.</p>
    @endif
</div>

<!-- ================= TECHNICAL INDICATORS ================= -->
<div class="mt-5">
    <h3 class="mb-3">Technical Indicators</h3>
    <div class="row"> <!-- Use Bootstrap row -->
        @foreach($technical ?? [] as $key => $value)
            <div class="col-md-4 col-sm-6 mb-3"> <!-- 3 per row on md, 2 per row on sm -->
                <div class="metric-card p-3 text-center border rounded">
                    <h6>{{ $key }}</h6>
                    <h5>{{ $value ?? 'N/A' }}</h5>
                </div>
            </div>
        @endforeach
    </div>
</div>

    <!-- Company News -->
<div class="mt-4">
    <h5>Company News</h5>

    <div style="max-height: 400px; overflow-y: auto; padding-right: 5px;">
        
        @forelse($news as $item)
            <div class="card p-3 mb-3">
                <div class="row">

                    <div class="col">
                        <strong>
                            <a href="{{ route('news.show', urlencode($item['title'])) }}" class="text-decoration-none fw-semibold">
                                {{ $item['title'] }}
                            </a>
                        </strong>

                        <div class="text-muted small"> 
                            {{ \Carbon\Carbon::parse($item['publishedAt'])->format('M d, Y') }}
                        </div>
                    </div>

                </div>
            </div>
        @empty
            <p>No news available.</p>
        @endforelse

    </div>
</div>

<div class="mt-4">

<h5>📊 Stock vs Sector Performance</h5>

@if($sectorPerformance)

<div class="card p-3">

<div class="row text-center">

<div class="col-md-4">
<h6>Stock</h6>
<strong>{{ $company['symbol'] }}</strong>
</div>

<div class="col-md-4">
<h6>Today</h6>

<span class="{{ $sectorPerformance['today_stock'] >=0 ? 'text-success':'text-danger' }}">
{{ $sectorPerformance['today_stock'] }}%
</span>

<br>

<small class="text-muted">
Sector ({{ $sectorPerformance['sector'] }}) :
{{ $sectorPerformance['today_sector'] }}%
</small>

</div>

<div class="col-md-4">
<h6>1 Month</h6>

<span class="{{ $sectorPerformance['month_stock'] >=0 ? 'text-success':'text-danger' }}">
{{ $sectorPerformance['month_stock'] }}%
</span>

<br>

<small class="text-muted">
Sector :
{{ $sectorPerformance['month_sector'] }}%
</small>

</div>

</div>

</div>

@endif

</div>
 
</div>


<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
new Chart(document.getElementById('companyChart'), {
    type: 'line',
    data: {
        labels: @json($chartLabels),
        datasets: [{
            data: @json($chartPrices),
            borderColor: '#16a34a',
            backgroundColor: 'rgba(22,163,74,0.1)',
            fill:true,
            tension:0.4
        }]
    },
    options:{
        plugins:{legend:{display:false}},
        responsive:true
    }
});
</script>
<script>
const input = document.getElementById('searchInput');
const suggestions = document.getElementById('suggestions');

input.addEventListener('input', function(){
    let query = this.value;

    if(query.length < 1){
        suggestions.innerHTML = '';
        return;
    }

    fetch('/suggest?query=' + query)
    .then(res => res.json())
    .then(data => {
        suggestions.innerHTML = '';

        data.forEach(item => {
            let li = document.createElement('li');
            li.className = "list-group-item";
            li.textContent = item.symbol + " | " + item.name;
            li.onclick = () => window.location.href = item.url;
            suggestions.appendChild(li);
        });
    });
});
</script>
@endsection