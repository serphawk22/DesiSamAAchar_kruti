 @extends('components.app')

@section('content')
<style>
    a{
        color:black;
    }
    body.dark a{
        color:white;
    }
    body.dark .list-group-item{
        background-color:#1e293b;
        color: white;
    }
 
a { color:black; }
body.dark a { color:white; }
body.dark .list-group-item { background-color:#1e293b; color:white; }

.heatmap-box {
    width: 120px; height: 60px; display:flex; flex-direction:column;
    align-items:center; justify-content:center; border-radius:6px; color:#fff;
    font-weight:bold; transition:transform 0.2s, box-shadow 0.2s;
}
.heatmap-box:hover { transform: scale(1.05); box-shadow:0 0 8px rgba(0,0,0,0.3);}
 
</style>
<div class="container py-4">

    {{-- 👋 Welcome --}}
    <div class="card shadow-sm mb-4 p-4">
        <h3>👋 Welcome back, {{ $userName ?? '-' }}!</h3>
        <p class="text-muted">Here’s your personalized market overview.</p>
    </div>

    {{-- 📊 Market Snapshot --}}
    <div class="row mb-4">
        {{-- Nifty --}}
        <div class="col-md-6">
            <a href="{{ route('sensex.index') }}" class="text-decoration-none">
            <div class="card p-3 shadow-sm">
                <h5>Nifty 50</h5>
                <h4>{{ $nifty['last_price'] ?? '-' }}</h4>
            </div></a>
        </div>

        {{-- Sensex --}}
        <div class="col-md-6">
             <a href="{{ route('sensex.index') }}" class="text-decoration-none">
            <div class="card p-3 shadow-sm">
                <h5>Sensex</h5>
                <h4>{{ $sensex['last_price'] ?? '-' }}</h4>
            </div></a>
        </div>
    </div>

    {{-- 🔼 Gainers & 🔽 Losers --}}
    <div class="row mb-4">
        {{-- Top Gainers --}}
        <div class="col-md-6">
            <div class="card shadow-sm p-3">
                <h5>🔼 Top Gainers</h5>
                @if(!empty($gainers))
                    @foreach($gainers as $stock)
                    <a href="{{ route('company.show', $stock['symbol']) }}" 
                                   class="text-decoration-none">
                        <div class="d-flex justify-content-between">
                            <span>{{ $stock['symbol'] ?? '-' }}</span>
                            <span class="text-success">{{ $stock['changePercent'] ?? '-' }}%</span>
                        </div>
                    </a>
                    @endforeach
                @else
                    <p>No data available.</p>
                @endif
            </div>
        </div>

        {{-- Top Losers --}}
        <div class="col-md-6">
            <div class="card shadow-sm p-3">
                <h5>🔽 Top Losers</h5>
                @if(!empty($losers))
                    @foreach($losers as $stock)
                    <a href="{{ route('company.show', $stock['symbol']) }}" 
                                   class="text-decoration-none">
                        <div class="d-flex justify-content-between">
                            <span>{{ $stock['symbol'] ?? '-' }}</span>
                            <span class="text-danger">{{ $stock['changePercent'] ?? '-' }}%</span>
                        </div></a>
                    @endforeach
                @else
                    <p>No data available.</p>
                @endif
            </div>
        </div>
    </div>

    {{-- ⭐ Watchlist --}}
    <div class="card shadow-sm p-3 mb-4">
        <h5>⭐ Your Watchlist</h5><br/>
        @if(!empty($watchlist) && $watchlist->count())
          <ul class="list-group">
    @forelse($watchlist as $item)
        <li class="list-group-item">
            <a href="{{ route('articles.show', $item->article->slug) }}" class="text-decoration-none">
                {{ $item->article->title ?? '-' }}
            </a>
        </li>
    @empty
        <li class="list-group-item text-muted">
            No watchlist items found.
        </li>
    @endforelse
</ul>
        @endif
    </div>

    {{-- 📰 Latest News --}}
   <div class="card shadow-sm p-3 mb-4">
    <h5>📰 News From Your Interests</h5>

    @if(!empty($latestNews) && count($latestNews))
        <ul class="list-group list-group-flush">
            @foreach($latestNews as $news)
                <li class="list-group-item">
                    <a href="{{ route('articles.show', $news->slug) }}" class="text-decoration-none">
                        {{ $news->title ?? '-' }}
                    </a>
                </li>
            @endforeach
        </ul>
    @else
        <p class="mb-2">No followed categories yet.</p>
    @endif
</div>
 
    {{-- 🏦 Dividend Tracker --}}
    <div class="card shadow-sm p-3 mb-4">
        <h5>🏦 Upcoming Dividends</h5>
        @if(!empty($dividends) && count($dividends))
            <div class="list-group">
                @foreach($dividends as $d)
                 <a href="{{ route('company.show', $d['symbol']) }}" 
                                   class="text-decoration-none">
                    <div class="list-group-item d-flex justify-content-between">
                        <span>{{ $d['company_name'] ?? $d['symbol'] }}</span>
                        <span>₹{{ $d['dividend_amount'] }}</span>
                    </div></a>
                @endforeach
            </div>
        @else
            <p class="text-muted">Dividend info not available via API.</p>
        @endif
    </div>
 
</div>
@endsection