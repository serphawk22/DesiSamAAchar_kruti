@extends('components.app')

@section('content')

<div class="container mt-4">

    <div class="d-flex justify-content-between mb-3">
        <h4 class="fw-bold">📌 Categories</h4>

        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
            + New Category
        </button>
    </div>
  <form method="GET" action="{{ route('admin.categories') }}" class="mb-3">
    <div class="input-group position-relative">

        <input type="text"
               id="categorySearchInput"
               name="search"
               class="form-control"
               placeholder="Search categories..."
               autocomplete="off"
               value="{{ request('search') }}">

        <div id="categorySuggestionsBox"
             class="list-group position-absolute w-100"
             style="z-index:1000; top:100%; left:0;"></div>

        <button class="btn btn-primary">Search</button>

        @if(request('search'))
            <a href="{{ route('admin.categories') }}"
               class="btn btn-outline-secondary">
                Clear
            </a>
        @endif

    </div>
</form> 
    @if(session('success'))
        <div class="alert alert-success">{{ session('success') }}</div>
    @endif

    <table class="table table-bordered align-middle">
        <thead class="table-light">
            <tr>
                <th width="5%"></th>
                <th>Category</th>
                <th>Position</th>
                <th>Status</th>
                <th width="20%">Action</th>
            </tr>
        </thead>

        <tbody>

        @foreach($categories as $category)

            <tr>
                <td>
                    <button class="btn btn-sm btn-outline-secondary"
                        data-bs-toggle="collapse"
                        data-bs-target="#sub{{ $category->id }}">
                        +
                    </button>
                </td>

                <td>
                    <input type="text" class="form-control"
                           value="{{ $category->name }}">
                </td>

                <td>{{ $category->position }}</td>

                <td>
                    {!! $category->status ? 
                        '<span class="badge bg-success">Active</span>' : 
                        '<span class="badge bg-danger">Disabled</span>' !!}
                </td>

                <td>

    {{-- Toggle Status --}}
    <form action="{{ route('admin.categories.toggle',$category->id) }}"
          method="POST" class="d-inline">
        @csrf
        <button class="btn btn-sm {{ $category->status ? 'btn-primary' : 'btn-success' }}">
            {{ $category->status ? 'Deactivate' : 'Activate' }}
        </button>
    </form>

    {{-- Delete --}}
    <form action="{{ route('admin.categories.delete',$category->id) }}"
          method="POST" class="d-inline">
        @csrf
        @method('DELETE')
        <button class="btn btn-danger btn-sm">
            Delete
        </button>
    </form>

</td>
            </tr>

            <!-- Subcategories -->
            <tr class="collapse bg-light" id="sub{{ $category->id }}">
                <td colspan="5">

                    <table class="table">
                        @foreach($category->subcategories as $sub)
                        <tr>
                            <td width="5%"></td>
                            <td>
                                <input type="text"
                                       class="form-control"
                                       value="{{ $sub->name }}">
                            </td>

                            <td width="20%">
                                <form action="{{ route('admin.subcategories.delete',$sub->id) }}"
                                      method="POST">
                                    @csrf @method('DELETE')
                                    <button class="btn btn-danger btn-sm">
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                        @endforeach

                        <!-- Add Subcategory -->
                        <tr>
                            <form action="{{ route('admin.subcategories.store') }}" method="POST">
                                @csrf
                                <input type="hidden" name="category_id" value="{{ $category->id }}">
                                <td></td>
                                <td>
                                    <input type="text" name="name"
                                           class="form-control"
                                           placeholder="Add subcategory">
                                </td>
                                <td>
                                    <button class="btn btn-success btn-sm">
                                        + Add
                                    </button>
                                </td>
                            </form>
                        </tr>

                    </table>

                </td>
            </tr>

        @endforeach

        </tbody>
    </table>
<div class="mt-4">
        {{ $categories->links('pagination::bootstrap-5') }}
    </div>
    <!-- Modal -->
<div class="modal fade" id="addCategoryModal">
    <div class="modal-dialog modal-lg">
        <form method="POST" action="{{ route('admin.categories.store') }}">
            @csrf

            <div class="modal-content">
                <div class="modal-header">
                    <h5>Create Category</h5>
                </div>

                <div class="modal-body">

                    <div class="mb-3">
                        <label>Main Category</label>
                        <input type="text" name="name"
                               class="form-control" required>
                    </div>

                    <div id="subCategoryWrapper">
                        <label>Subcategories</label>
                        <div class="d-flex mb-2">
                            <input type="text" name="subcategories[]"
                                   class="form-control">
                            <button type="button"
                                    class="btn btn-success ms-2"
                                    onclick="addSubInput()">+</button>
                        </div>
                    </div>

                </div>

                <div class="modal-footer">
                    <button class="btn btn-primary">
                        Save Category
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
</div>
@endsection
<script>
function addSubInput() {
    let wrapper = document.getElementById('subCategoryWrapper');

    let div = document.createElement('div');
    div.classList.add('d-flex','mb-2');

    div.innerHTML = `
        <input type="text" name="subcategories[]" class="form-control">
        <button type="button" class="btn btn-danger ms-2"
            onclick="this.parentElement.remove()">-</button>
    `;

    wrapper.appendChild(div);
}
</script>
<script>
document.addEventListener("DOMContentLoaded", function () {

    const input = document.getElementById("categorySearchInput");
    const box = document.getElementById("categorySuggestionsBox");

    input.addEventListener("keyup", function () {

        let query = this.value;

        if (query.length < 2) {
            box.innerHTML = "";
            box.style.display = "none";
            return;
        }

        fetch("{{ route('admin.categories.suggestions') }}?search=" + query)
            .then(response => response.json())
            .then(data => {

                box.innerHTML = "";

                if (data.length === 0) {
                    box.style.display = "none";
                    return;
                }

                box.style.display = "block";

                data.forEach(name => {

                    let item = document.createElement("a");
                    item.href = "#";
                    item.className = "list-group-item list-group-item-action";
                    item.textContent = name;

                    item.addEventListener("click", function (e) {
                        e.preventDefault();
                        input.value = name;
                        box.innerHTML = "";
                        box.style.display = "none";
                    });

                    box.appendChild(item);
                });

            })
            .catch(error => console.log(error));
    });

    document.addEventListener("click", function (e) {
        if (!input.contains(e.target) && !box.contains(e.target)) {
            box.style.display = "none";
        }
    });

});
</script>