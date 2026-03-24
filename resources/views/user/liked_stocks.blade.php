@extends('components.app')

@section('content')

<div class="container my-4">

    <!-- Liked Stocks -->
    <h3 class="fw-bold mb-4">❤️ Liked Stocks</h3>

    @forelse($stocks as $stock)
        <div class="card mb-3 shadow-sm border-0">
            <div class="card-body d-flex justify-content-between align-items-center">

                <div>
                    <h5 class="mb-1">{{ $stock->symbol }}</h5>
                    <small class="text-muted">
                        Added on {{ $stock->created_at }}
                    </small>
                </div>

                <div>
                    <a href="{{ route('company.show', $stock->symbol) }}" class="btn btn-primary btn-sm">
                        View Details
                    </a>
                </div>

            </div>
        </div>
    @empty
        <div class="text-center py-5">
            <h5 class="text-muted">No liked stocks yet.</h5>
        </div>
    @endforelse

    <!-- Pagination -->
    <div class="mt-4">
        {{ $stocks->links('pagination::bootstrap-5') }}
    </div>
 

</div>

 

 

@endsection