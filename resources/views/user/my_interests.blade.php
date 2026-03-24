@extends('components.app')

@section('content')

<div class="container my-4">

    <h3 class="fw-bold mb-4">🎯 My Interests</h3>

    {{-- Auto open modal if no interest --}}
   @if($interests->isEmpty())
<script>
document.addEventListener("DOMContentLoaded", function () {
    var interestModal = new bootstrap.Modal(
        document.getElementById('interestModal')
    );
    interestModal.show();
});
</script>
@endif


    @if($interests->isNotEmpty())

    <div class="row">

        {{-- ================= LEFT SIDE (API NEWS) ================= --}}
        <div class="col-lg-8">

            <h5 class="mb-3">Latest News</h5>

            <div class="row">
                @forelse($apiNews as $news)
                <div class="col-md-6 mb-4">
                    <div class="card h-100 shadow-sm border-0 news-card">
                        <img src="{{ $news['urlToImage'] ?? 'https://via.placeholder.com/400x200' }}"
                             class="card-img-top news-img">

                        <div class="card-body d-flex flex-column">
                            <h6 class="fw-semibold">
                                {{ Str::limit($news['title'], 80) }}
                            </h6>

                            <a href="{{ route('news.show', urlencode($news['title'])) }}"
                               target="_blank"
                               class="btn btn-sm btn-primary mt-auto">
                               Read More
                            </a>
                        </div>
                    </div>
                </div>
                @empty
                <p>No API news found.</p>
                @endforelse
            </div>

            {{-- API Pagination --}}
            <div class="mt-4">
                {{ $apiNews->links('pagination::bootstrap-5') }}
            </div>

        </div>


        {{-- ================= RIGHT SIDE ================= --}}
        <div class="col-lg-4">

            {{-- Editor Articles --}}
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header fw-bold">
                    📰 Editor Articles
                </div>

                <div class="card-body">

                    @forelse($articles as $article)
                        <div class="mb-3 pb-3 border-bottom">
                            <h6 class="fw-semibold mb-1">
                                {{ Str::limit($article->title, 60) }}
                            </h6>

                            <p class="small text-muted mb-2">
                                {{ Str::limit($article->short_description, 90) }}
                            </p>

                            <a href="{{ route('articles.show', $article->slug) }}"
                               class="btn btn-sm btn-outline-dark">
                               Read
                            </a>
                        </div>
                    @empty
                        <p>No editor articles available.</p>
                    @endforelse

                    {{-- Article Pagination --}}
                    <div class="mt-3">
                        {{ $articles->links('pagination::bootstrap-5') }}
                    </div>

                </div>
            </div>


            {{-- Update Interest (Bottom) --}}
            <div class="card shadow-sm border-0 text-center p-3">
                <h6 class="fw-bold mb-3">Manage Your Interests</h6>

                <button class="btn btn-outline-primary w-100"
                        data-bs-toggle="modal"
                        data-bs-target="#interestModal">
                    Update Interest
                </button>
            </div>

        </div>

    </div>

    @endif

 <!-- INTEREST MODAL -->
<div class="modal fade" id="interestModal" tabindex="-1">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content interest-modal">

            <!-- HEADER -->
            <div class="modal-header border-0 sticky-top bg-white">
                <h5 class="fw-bold mb-0">Select Your Interest</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="{{ route('user.interests.store') }}" method="POST">
                @csrf

                <!-- BODY -->
                <div class="modal-body interest-scroll">

                    <div class="row">

                        <!-- CATEGORY LIST -->
                        <div class="col-lg-5 category-column">
                            @foreach($categories as $cat)
                               <label class="interest-option">
                                <input type="checkbox"
                                    name="category_id[]"
                                    value="{{ $cat->id }}"
                                    class="category-checkbox"
                                    data-target="sub-{{ $cat->id }}">

                                <span class="custom-radio"></span>
                                <span class="label-text">{{ $cat->name }}</span>
                            </label>
                            @endforeach
                        </div>

                        <!-- SUBCATEGORY LIST -->
                        <div class="col-lg-7">
                            @foreach($categories as $cat)
                                <div class="sub-box d-none"
                                     id="sub-{{ $cat->id }}">
                                    <div class="sub-title">
                                        {{ $cat->name }} Topics
                                    </div>

                                    @foreach($cat->subcategories as $sub)
                                        <label class="interest-option small-option">
                                            <input type="checkbox"
                                                name="subcategory_id[]"
                                                value="{{ $sub->id }}">

                                            <span class="custom-radio"></span>
                                            <span class="label-text">{{ $sub->name }}</span>
                                        </label>
                                    @endforeach
                                </div>
                            @endforeach
                        </div>

                    </div>
                </div>

                <!-- FOOTER -->
                <div class="modal-footer border-0 sticky-bottom bg-white">
                    <button type="submit" class="btn btn-primary px-4">
                        Save Interest
                    </button>
                </div>

            </form>

        </div>
    </div>
</div>

</div>
<script>
document.querySelectorAll('.category-checkbox').forEach(cb => {

    cb.addEventListener('change', function() {

        const targetBox = document.getElementById(this.dataset.target);

        if (this.checked) {
            targetBox.classList.remove('d-none');
        } else {
            targetBox.classList.add('d-none');

            // Uncheck subcategories when category is unchecked
            targetBox.querySelectorAll('input[type="checkbox"]').forEach(sub => {
                sub.checked = false;
            });
        }
    });

});
</script>

@endsection