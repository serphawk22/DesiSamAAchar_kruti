@extends('components.app')

@section('content')

<style>
.hero-section {
    height: 90vh;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    text-align:center;
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
 .suggestion-buttons {
        margin-top: 25px;
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 12px;
    }

    .suggestion-buttons a {
        padding: 6px 14px;
        background: #e5e7eb;
        border-radius: 20px;
        font-size: 0.9rem;
        text-decoration: none;
        color: #374151;
        transition: 0.2s ease;
    }

    .suggestion-buttons a:hover {
        background: #d1d5db;
    }

    body.dark .suggestion-buttons a {
    background: #111827;
    color: #d1d5db;
    border: 1px solid #2d3748;
    transition: all 0.2s ease;
}

body.dark .suggestion-buttons a:hover {
    background: #6f42c1;
    color: #ffffff;
    transform: translateY(-2px);
}
</style>

<div class="hero-section">

    <h1><span style="color:#6f42c1;">Stock Screener</span> for Indian Stocks</h1>
    <p class="text-muted mb-4">Get high-value insights for your stock analysis</p>

    <div class="search-box">
        <input type="text" id="searchInput" class="search-input"
               placeholder="Search for companies and stocks" style=" box-shadow: none !important;border-color: #2563eb;">

        <ul id="suggestions" class="list-group position-absolute w-100"></ul>
    </div>
 <div class="suggestion-buttons">
    <a href="{{ route('company.show','HDFCBANK') }}">HDFC Bank</a>
    <a href="{{ route('company.show','HINDALCO') }}">Hindalco Industries</a>
    <a href="{{ route('company.show','ICICIBANK') }}">ICICI Bank</a>
    <a href="{{ route('company.show','RELIANCE') }}">Reliance Industries</a>
    <a href="{{ route('company.show','TCS') }}">TCS</a>
    <a href="{{ route('company.show','IRFC') }}">IRFC</a>
    <a href="{{ route('company.show','TATASTEEL') }}">Tata Steel</a>
</div>
</div>

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