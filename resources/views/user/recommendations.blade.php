@extends('components.app')

@section('content')

<style>
.scroll-box{
    max-height:400px;
    overflow-y:auto;
}

.company-link{
    color:#7b3fe4;
    font-weight:600;
}

.company-link:hover{
    color:#5a2cc4;
}
</style>

<div class="container my-5">

<h2 class="fw-bold mb-4" style="color:#7b3fe4;">
⭐ Personalized Recommendations
</h2>

<div class="row">

{{-- ================= WATCHLIST ================= --}}
<div class="col-lg-6 mb-4">

<h4 class="fw-bold mb-3">📈 Stocks From Your Watchlist</h4>

<div class="scroll-box" id="watchlistContainer">

@foreach(collect($stocks)->take(5) as $stock)

<div class="card mb-2 shadow-sm">
<div class="card-body d-flex justify-content-between align-items-center">

<div>
<a href="{{ route('company.show',$stock['symbol']) }}"
class="company-link text-decoration-none">
{{ $stock['symbol'] }}
</a>
</div>

<div>
<span class="fw-bold">₹{{ $stock['price'] }}</span>

@if($stock['change'] > 0)
<span class="text-success ms-2">▲ {{ $stock['change'] }}</span>
@else
<span class="text-danger ms-2">▼ {{ $stock['change'] }}</span>
@endif

</div>

</div>
</div>

@endforeach

</div>

@if(count($stocks) > 5)
<div class="text-end mt-2">
<button id="loadMoreWatchlist" class="btn btn-sm btn-outline-primary">
Load More →
</button>
</div>
@endif

</div>


{{-- ================= TOP GAINERS ================= --}}
<div class="col-lg-6 mb-4">

<h4 class="fw-bold mb-3">🔥 Top Market Gainers</h4>

<div class="scroll-box" id="gainersContainer">

@foreach(collect($topMovers)->take(5) as $stock)

<div class="card mb-2 shadow-sm">
<div class="card-body d-flex justify-content-between">

<div>
<a href="{{ route('company.show',$stock['symbol']) }}"
class="company-link text-decoration-none">
{{ $stock['symbol'] }}
</a>
</div>

<div>

<span class="fw-bold">
₹{{ $stock['last_price'] ?? $stock['price'] }}
</span>

<span class="text-success ms-2">
▲ {{ $stock['percent_change'] ?? $stock['changePercent'] }}%
</span>

</div>

</div>
</div>

@endforeach

</div>

@if(count($topMovers) > 5)
<div class="text-end mt-2">
<button id="loadMoreGainers" class="btn btn-sm btn-outline-primary">
Load More →
</button>
</div>
@endif

</div>

</div>


{{-- ================= NEWS ================= --}}
<div class="mt-5">

<h4 class="fw-bold mb-3">📰 News Based On Your Interests</h4>

<div class="row">

@foreach($news as $article)

<div class="col-lg-4 mb-4">

<div class="card shadow-sm h-100">

@if(!empty($article['urlToImage']))
<img src="{{ $article['urlToImage'] }}"
class="card-img-top"
style="height:180px;object-fit:cover;">
@endif

<div class="card-body">

<h6 class="fw-bold">
<a href="{{ route('news.show', urlencode($article['title'])) }}"
class="text-decoration-none">
{{ $article['title'] }}
</a>
</h6>

<p class="text-muted small">
{{ \Illuminate\Support\Str::limit($article['description'] ?? '',120) }}
</p>

</div>

</div>

</div>

@endforeach

</div>

<div class="text-end">
<a href="{{ route('news.index') }}"
class="btn btn-sm btn-outline-primary">
Load More News →
</a>
</div>

</div>

</div>


{{-- ================= JAVASCRIPT ================= --}}

<script>

let watchIndex = 5;
let watchStocks = @json($stocks);

document.getElementById("loadMoreWatchlist")?.addEventListener("click",function(){

let container = document.getElementById("watchlistContainer");

for(let i=watchIndex;i<watchIndex+5;i++){

if(!watchStocks[i]) break;

let stock = watchStocks[i];

let arrow = stock.change > 0 ? "▲" : "▼";
let color = stock.change > 0 ? "text-success" : "text-danger";

let html = `
<div class="card mb-2 shadow-sm">
<div class="card-body d-flex justify-content-between align-items-center">

<div>
<a href="/company/${stock.symbol}" class="company-link text-decoration-none">
${stock.symbol}
</a>
</div>

<div>
<span class="fw-bold">₹${stock.price}</span>
<span class="${color} ms-2">${arrow} ${stock.change}</span>
</div>

</div>
</div>
`;

container.insertAdjacentHTML("beforeend",html);

}

watchIndex += 5;

});

</script>


<script>

let gainerIndex = 5;
let gainers = @json($topMovers);

document.getElementById("loadMoreGainers")?.addEventListener("click",function(){

let container = document.getElementById("gainersContainer");

for(let i=gainerIndex;i<gainerIndex+5;i++){

if(!gainers[i]) break;

let stock = gainers[i];

let html = `
<div class="card mb-2 shadow-sm">
<div class="card-body d-flex justify-content-between">

<div>
<a href="/company/${stock.symbol}" class="company-link text-decoration-none">
${stock.symbol}
</a>
</div>

<div>

<span class="fw-bold">
₹${stock.last_price ?? stock.price}
</span>

<span class="text-success ms-2">
▲ ${stock.percent_change ?? stock.changePercent}%
</span>

</div>

</div>
</div>
`;

container.insertAdjacentHTML("beforeend",html);

}

gainerIndex += 5;

});

</script>

@endsection