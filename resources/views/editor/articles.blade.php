@extends('components.app')

@section('content')
<style>

/* Modal Background */
body.dark .modal-content {
    background-color: #0f172a;  /* Deep dark */
    color: #e2e8f0;
    border: 1px solid #1e293b;
}

/* Header */
body.dark .modal-header {
    border-bottom: 1px solid #1e293b;
}

body.dark .modal-title {
    color: #f1f5f9;
}

/* Body */
body.dark .modal-body {
    background-color: #0f172a;
}

/* Footer */
body.dark .modal-footer {
    border-top: 1px solid #1e293b;
}

/* Labels */
body.dark .modal label {
    color: #cbd5e1;
    font-weight: 500;
}

/* Inputs & Selects */
body.dark .modal .form-control,
body.dark .modal select,
body.dark .modal textarea {
    background-color: #1e293b;
    border: 1px solid #334155;
    color: #f1f5f9;
}

body.dark .modal .form-control:focus,
body.dark .modal select:focus,
body.dark .modal textarea:focus {
    background-color: #1e293b;
    border-color: #2563eb;
    box-shadow: none;
    color: #fff;
}

/* Placeholder */
body.dark .modal .form-control::placeholder,
body.dark .modal textarea::placeholder {
    color: #94a3b8;
}

/* Select dropdown arrow fix */
body.dark .modal select {
    background-color: #1e293b;
    color: #f1f5f9;
}
#aiResult{
    background-color:#f8f9fa;
}

body.dark #aiResult{
    background-color:#1e293b;
    color:#f1f5f9; 
}
/* Close button */
body.dark .btn-close {
    filter: invert(1);
}

/* Media Preview Box */
body.dark #mediaContainer img {
    border: 1px solid #334155;
    border-radius: 6px;
}

/* Modal backdrop darker */
body.dark .modal-backdrop.show {
    background-color: #000;
    opacity: 0.8;
}

</style>
<div class="card shadow-sm p-4">
@if(session('success'))
    <div class="alert alert-success">
        {{ session('success') }}
    </div>
@endif
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="fw-bold">My Articles</h4>

        <button class="btn btn-primary px-4"
                data-bs-toggle="modal"
                data-bs-target="#articleModal"
                onclick="openCreateModal()">
            + New Article
        </button>
    </div>

    <table class="table align-middle">
        <thead>
            <tr>
                <th>Title</th>
                <th>Status</th>
                <th width="180">Actions</th>
            </tr>
        </thead>

        <tbody>
            @forelse($articles as $article)
            <tr>
                <td>{{ $article->title }}</td>
                <td>
                    <span class="badge
                        {{ $article->status == 'published' ? 'bg-success' : 'bg-warning text-dark' }}">
                        {{ ucfirst($article->status) }}
                    </span>
                </td>
                <td>
                    <button 
    class="btn btn-sm btn-primary editBtn"
    data-id="{{ $article->id }}"
    data-title="{{ $article->title }}"
    data-category="{{ $article->category_id }}"
    data-subcategory="{{ $article->subcategory_id }}"
    data-short="{{ $article->short_description }}"
    data-content="{{ $article->full_content }}"
    data-status="{{ $article->status }}"
    data-meta_title="{{ $article->meta_title }}"
    data-meta_description="{{ $article->meta_description }}"
   data-media="{{ json_encode($article->media->map(function($m){
        return [
            'type' => $m->type,
            'file_url' => asset($m->file_url),
            'name' => $m->file_name ?? null,
            'size' => $m->size
        ];
    })) }}"
>
Edit
</button>

                    <form action="{{ route('articles.delete', $article->id) }}"
                          method="POST"
                          class="d-inline">
                        @csrf
                        @method('DELETE')
                        <button class="btn btn-sm btn-outline-danger"
                                onclick="return confirm('Delete this article?')">
                            Delete
                        </button>
                    </form>
                </td>
            </tr>
            @empty
            <tr>
                <td colspan="3" class="text-center text-muted">
                    No Articles Found
                </td>
            </tr>
            @endforelse
        </tbody>
    </table>

</div>


<!-- Modal -->
<div class="modal fade" id="articleModal"><br/><br/>
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Article</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form id="articleForm" method="POST" enctype="multipart/form-data">
                @csrf

                <div class="modal-body">
                    <div class="row g-3">

                        <div class="col-md-6">
                            <label>Category</label>
                            <select name="category_id" id="categorySelect" class="form-control" required>
                                <option value="">Select</option>
                                @foreach($categories as $cat)
                                    <option value="{{ $cat->id }}">{{ $cat->name }}</option>
                                @endforeach
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label>Subcategory</label>
                            <select name="subcategory_id" id="subcategorySelect" class="form-control">
                                <option value="">Select</option>
                            </select>
                        </div>

                        <div class="col-md-12">
                        <label>Title</label>
                        <div class="input-group">
                        <input type="text" name="title" id="titleInput" class="form-control" style=" box-shadow: none !important;border-color: #2563eb;">
                        <button type="button" id="aiSuggestBtn" class="btn btn-dark h-100">
                        🤖 AI Suggest
                        </button>
                        </div>
                        </div>

                         <div class="col-md-12">
                            <label>🤖 AI Writing Suggestions</label>

                            <div id="aiResult" class="p-3 border rounded" style="min-height:120px">
                            AI suggestions will appear here...
                            </div>
                            </div>

                        <div class="col-md-12">
                            <label>Short Description</label>
                            <textarea name="short_description" class="form-control"></textarea>
                        </div>

                        <div class="col-md-12">
                            <label>Full Content</label>
                            <textarea name="full_content" id="fullContent" class="form-control"></textarea>
                        </div>

                        <div class="col-md-4">
                            <label>Status</label>
                            <select name="status" class="form-control">
                                <option value="draft">Draft(Save As Draft)</option> 
                                <option value="pending">Request(Sent For Approval)</option>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label>Upload Media</label>
                            <input type="file" name="media[]" multiple class="form-control">
                        </div>

                        <div class="col-md-12">
                            <label>Existing Media</label> 
                              <div id="mediaContainer" class="d-flex flex-wrap gap-2"></div>
                        </div>

                    </div>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-primary">Save Article</button>
                </div>
            </form>

        </div>
    </div>
</div>
</div>

@endsection


<script>
function openCreateModal() {
    document.getElementById('modalTitle').innerText = "New Article";
      document.getElementById('articleForm').action = 
        "{{ route('articles.store') }}";
    document.getElementById('articleTitle').value = '';
    document.getElementById('articleStatus').value = 'draft';
}

function openEditModal(id, title, status) {
    document.getElementById('modalTitle').innerText = "Update Article";
    document.getElementById('articleForm').action = "editor/articles/update/" + id;
    document.getElementById('articleTitle').value = title;
    document.getElementById('articleStatus').value = status;

    new bootstrap.Modal(document.getElementById('articleModal')).show();
}
</script> 
<script>
document.addEventListener('DOMContentLoaded', function () {

    let category = document.getElementById('categorySelect');

    category.addEventListener('change', function () {

        fetch(`/editor/subcategories/${this.value}`)
            .then(response => response.json())
            .then(data => {

                let sub = document.getElementById('subcategorySelect');
                sub.innerHTML = '<option value="">Select Subcategory</option>';

                data.forEach(item => {
                    sub.innerHTML += `<option value="${item.id}">${item.name}</option>`;
                });

                // If editing, select correct subcategory
                if (category.dataset.selectedSubcategory) {
                    sub.value = category.dataset.selectedSubcategory;
                    category.dataset.selectedSubcategory = '';
                }

            })
            .catch(error => console.error(error));
    });

});
</script>
<script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js"></script>
<script>
tinymce.init({
  selector: 'textarea[name=full_content]',
  height: 400,
  plugins: 'lists link image table code',
  toolbar: 'undo redo | styles | bold italic | alignleft aligncenter alignright | bullist numlist | link image | code'
});
</script> <script>
document.addEventListener('DOMContentLoaded', function () {
    const modalElement = document.getElementById('articleModal');
    const modal = new bootstrap.Modal(modalElement);

    document.querySelectorAll('.editBtn').forEach(button => {
        button.addEventListener('click', function() {
            let articleId = this.dataset.id;
            document.getElementById('articleForm').action = "/editor/articles/update/" + articleId;

            document.querySelector('.modal-title').innerText = "Update Article";
            document.querySelector('input[name=title]').value = this.dataset.title;
            document.querySelector('textarea[name=short_description]').value = this.dataset.short;
            document.querySelector('select[name=status]').value = this.dataset.status;

            // Category
            const categorySelect = document.querySelector('select[name=category_id]');
            categorySelect.value = this.dataset.category;
            categorySelect.dataset.selectedSubcategory = this.dataset.subcategory;
            categorySelect.dispatchEvent(new Event('change'));

            // Full content
            document.querySelector('textarea[name=full_content]').value = this.dataset.content; 

            // Existing media
           const mediaContainer = document.getElementById('mediaContainer');
const mediaFiles = JSON.parse(this.dataset.media || '[]');
mediaContainer.innerHTML = '';

if (mediaFiles.length === 0) {
    mediaContainer.innerHTML = 'No existing media';
} else {
    mediaFiles.forEach(media => {
        let html = '';
        let fileUrl = media.file_url;

        switch(media.type) {
            case 'image':
                html = `<img src="${fileUrl}" width="100" alt="Image">`;
                break;
            case 'video':
                html = `<video width="150" controls>
                            <source src="${fileUrl}" type="video/${fileUrl.split('.').pop()}">
                        </video>`;
                break;
            case 'audio':
                html = `<audio controls>
                            <source src="${fileUrl}" type="audio/${fileUrl.split('.').pop()}">
                        </audio>`;
                break;
            case 'document':
                html = `<a href="${fileUrl}" target="_blank">${media.name || fileUrl.split('/').pop()}</a>`;
                break;
        }

        if(media.size) {
            let sizeKB = (media.size / 1024).toFixed(2);
            html += ` <small>(${sizeKB} KB)</small>`;
        }

        mediaContainer.innerHTML += html + ' ';
    });
}

            modal.show();
        });
    });
});
</script>
<script>
function deleteMedia(id) {

    if (!confirm('Delete this media?')) return;

    fetch('/media/' + id, {
        method: 'DELETE',
        headers: {
            'X-CSRF-TOKEN': '{{ csrf_token() }}'
        }
    })
    .then(res => location.reload());
}
</script>
<script>

document.addEventListener("DOMContentLoaded", function(){

let btn = document.getElementById("aiSuggestBtn");

if(!btn) return;

btn.addEventListener("click", function(){

let title = document.getElementById("titleInput").value;

if(title.trim() === ""){
alert("Enter article topic first");
return;
}

document.getElementById("aiResult").innerHTML = "Generating AI suggestions...";

fetch("{{ route('editor.ai.generate') }}", {

method: "POST",

headers: {
"Content-Type": "application/json",
"X-CSRF-TOKEN": "{{ csrf_token() }}"
},

body: JSON.stringify({
prompt: title
})

})
.then(response => response.json())
.then(data => {

document.getElementById("aiResult").innerHTML =
"<pre>"+data.content+"</pre>";

})
.catch(error => {

document.getElementById("aiResult").innerHTML =
"AI error occurred";

console.error(error);

});

});

});

</script>