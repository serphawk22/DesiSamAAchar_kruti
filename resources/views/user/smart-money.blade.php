@extends('components.app')

@section('content')
<style>
.smart-scroll{
height:350px;
overflow-y:auto;
border-radius:10px;
}

.smart-scroll::-webkit-scrollbar{
width:6px;
}

.smart-scroll::-webkit-scrollbar-thumb{
background:#ccc;
border-radius:10px;
}

a{
    color:black;
}
</style>
<div class="container my-4">

<h2 class="fw-bold mb-4">🚀 Smart Money Tracker</h2>

<!-- ROW 1 -->
<!-- ROW 1 -->
<div class="row">

    <!-- MOST BOUGHT -->
    <div class="col-md-4">
        <h5>🔥 Most Bought</h5>

        <div class="card p-2 smart-scroll">

        @foreach($data['most_bought'] as $stock)
<a href="{{ route('company.show', $stock['symbol']) }}" 
                                   class="text-decoration-none">
        <div class="d-flex justify-content-between border-bottom py-2">
            <b>{{ $stock['symbol'] }}</b>

            <span class="text-success">
                {{ $stock['deliveryPercent'] }}%
            </span>
        </div></a>

        @endforeach

        </div>
    </div>


    <!-- UNUSUAL VOLUME -->
    <div class="col-md-4">
        <h5>📈 Unusual Volume</h5>

        <div class="card p-2 smart-scroll">

        @foreach($data['unusual_volume'] as $stock)
        <a href="{{ route('company.show', $stock['symbol']) }}" 
                                   class="text-decoration-none">
        <div class="d-flex justify-content-between border-bottom py-2">
            <b>{{ $stock['symbol'] }}</b>

            <span>
                Vol : {{ number_format($stock['volume']) }}
            </span>
        </div></a>

        @endforeach

        </div>
    </div>


    <!-- MOMENTUM -->
    <div class="col-md-4">
        <h5>🚀 Momentum Stocks</h5>

        <div class="card p-2 smart-scroll">

        @foreach($data['momentum'] as $stock)
        <a href="{{ route('company.show', $stock['symbol']) }}" 
                                   class="text-decoration-none">
        <div class="d-flex justify-content-between border-bottom py-2">

            <b>{{ $stock['symbol'] }}</b>

            <span class="{{ $stock['changePercent'] > 0 ? 'text-success':'text-danger' }}">
                {{ $stock['changePercent'] }}%
            </span>

        </div></a>

        @endforeach

        </div>
    </div>

</div>


<!-- ROW 2 -->
<div class="row mt-4">

    <div class="col-md-12">

       <h5>🏦 FII / DII Activity</h5>

@if(!empty($data['fii_dii']))

<div class="row g-3">

@foreach($data['fii_dii'] as $item)

<div class="col-md-6">

<div class="card shadow-sm border-0 h-100">

<div class="card-body text-center">

<h5 class="fw-bold mb-3">
{{ $item['category'] }}
</h5>

<div class="d-flex justify-content-between px-3 mb-2">

<span class="text-muted">Buy</span>

<span class="fw-semibold text-success">
₹{{ number_format($item['buyValue'],2) }} Cr
</span>

</div>

<div class="d-flex justify-content-between px-3 mb-2">

<span class="text-muted">Sell</span>

<span class="fw-semibold text-danger">
₹{{ number_format($item['sellValue'],2) }} Cr
</span>

</div>

<hr>

<div class="fw-bold fs-5
{{ $item['netValue'] >= 0 ? 'text-success':'text-danger' }}">

Net :
₹{{ number_format($item['netValue'],2) }} Cr

</div>

</div>

</div>

</div>

@endforeach

</div>

@endif

    </div>

</div>

</div>

@endsection