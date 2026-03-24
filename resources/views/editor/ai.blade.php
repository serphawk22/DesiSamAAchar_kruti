
@extends('components.app')

@section('content')

<h2>🤖 AI Writing Tools</h2>

<textarea id="prompt" class="form-control" rows="5"></textarea>

<button id="generateBtn" class="btn btn-primary mt-3">
    Generate
</button>

<hr>

<div id="result" class="mt-3"></div>

<script>
document.getElementById('generateBtn').addEventListener('click', function () {

    fetch("{{ route('editor.ai.generate') }}", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            "X-CSRF-TOKEN": "{{ csrf_token() }}"
        },
        body: JSON.stringify({
            prompt: document.getElementById('prompt').value
        })
    })
    .then(res => res.json())
    .then(data => {
        document.getElementById('result').innerHTML =
            "<pre>" + data.content + "</pre>";
    });

});
</script>

@endsection
