@extends('components.app')

@section('content')
<style>
#link{
    color:black;
}
    </style>
<div class="container my-4">

    <h4 class="mb-3">📈 Market Stocks</h4>

    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr> 
                    <th>Name</th>
                    <th>Price</th>
                    <th>Change</th>
                    <th>% Change</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>
                @foreach($stocks as $stock)
                <tr>
             <td class="fw-bold">    <a href="{{ route('company.show', $stock->symbol) }}" class="text-decoration-none" id="link">
        {{ $stock->symbol }}
    </a>
</td> 

                    <td>₹{{ $stock->price }}</td>

                    <td class="{{ $stock->change_pts >= 0 ? 'text-success' : 'text-danger' }}">
                        {{ $stock->change_pts }}
                    </td>

                    <td class="{{ $stock->change_percent >= 0 ? 'text-success' : 'text-danger' }}">
                        {{ $stock->change_percent }}%
                    </td>

                    <td>
                        <button 
                            class="btn btn-sm watchlist-btn 
                                {{ in_array($stock->symbol, $watchlistSymbols ?? []) ? 'btn-primary' : 'btn-outline-primary' }}"
                            data-symbol="{{ $stock->symbol }}"
                        >
                            {{ in_array($stock->symbol, $watchlistSymbols ?? []) ? '★ Remove' : '☆ Add' }}
                        </button>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>
    </div>

</div>

<script>
document.querySelectorAll('.watchlist-btn').forEach(btn => {
    btn.addEventListener('click', function() {

        let symbol = this.dataset.symbol;
        let button = this;

        fetch("{{ route('stocks.toggle') }}", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "X-CSRF-TOKEN": "{{ csrf_token() }}"
            },
            body: JSON.stringify({ symbol: symbol })
        })
        .then(res => res.json())
        .then(data => {

            if (data.status === 'added') {
                button.classList.remove('btn-outline-primary');
                button.classList.add('btn-primary');
                button.innerHTML = '★ Remove';
            }

            if (data.status === 'removed') {
                button.classList.remove('btn-primary');
                button.classList.add('btn-outline-primary');
                button.innerHTML = '☆ Add';
            }

            if (data.error) {
                alert("Please login first.");
                window.location.href = "/signin";
            }
        });

    });
});
</script>

@endsection