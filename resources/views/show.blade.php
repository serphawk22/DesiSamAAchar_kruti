@extends('components.app')

@section('content')
<div class="container my-5">
    <div class="row">

        {{-- ================= MAIN ARTICLE ================= --}}
        <div class="col-lg-8">

            {{-- Title --}}
            <h2 class="mb-3 fw-bold" style="color:#6f42c1;">
                {{ $article['title'] ?? 'Untitled Article' }}
            </h2>

            {{-- Published Time --}}
            @if(!empty($article['publishedAt']))
                <p class="text-muted mb-3">
                    {{ \Carbon\Carbon::parse($article['publishedAt'])->diffForHumans() }}
                </p>
            @endif

            {{-- Image --}}
           @if(!empty($article['urlToImage']))
    <div class="article-image-wrapper mb-4">
        <img src="{{ $article['urlToImage'] }}"
             alt="Article Image"
             onerror="this.src='{{ asset('no-image.png') }}'">
    </div>
@endif
 {{-- AI SUMMARY --}}
@if(!empty($aiSummary))

<div class="ai-summary-box mb-4" id="aiSummaryContent">
    <div class="ai-summary-header">
        ✨ AI Powered Summary  
        <span id="readSummaryBtn" style="cursor:pointer;color:red;">
🔊
</span>
    </div>

    <ul class="ai-summary-list">
        @foreach($aiSummary['summary'] ?? [] as $point)
            <li>{{ $point }}</li>
        @endforeach
    </ul>

    @if(!empty($aiSummary['sector']))
        <div class="mt-3">
            <strong>Sector:</strong> {{ $aiSummary['sector'] }}
        </div>
    @endif

    @if(!empty($aiSummary['companies']))
    <div class="mt-3">
        <strong>This news impacts:</strong><br>

        @foreach($aiSummary['companies'] as $company)
            <span class="badge bg-success me-1">✔ {{ $company }}</span>
        @endforeach
    </div>
@endif
<hr>
    @if(!empty($aiSummary['impact']))
        <div class="ai-impact mt-3">
            <div class="ai-summary-header">📊 Why market Moved</div>
            <ul>
                @foreach($aiSummary['impact'] as $impact)
                    <li>{{ $impact }}</li>
                @endforeach
            </ul>
        </div>
    @endif
<hr>
    @if(!empty($aiSummary['global_impact']))
    <div class="mt-3">
        <div class="ai-summary-header">🌍 Global Impact</div>

        <ul>
            @foreach($aiSummary['global_impact'] as $g)
                <li>{{ $g }}</li>
            @endforeach
        </ul>
    </div>
@endif
<hr>
@if(!empty($aiSummary['learning']))
    <div class="mt-3">
        <div class="ai-summary-header">🧠 Learning Mode (For Beginners)</div>

       <ul style="list-style:none; padding-left:0;">
    @foreach($aiSummary['learning'] as $learn)
        <li>👉 {{ $learn }}</li>
    @endforeach
</ul>
    </div>
@endif

</div>
@endif
            {{-- Description --}}
            @if(!empty($article['description']))
                <p class="lead fw-semibold">
                    {{ $article['description'] }}
                </p>
            @endif

           {{-- Clean Content --}}
         @php
$rawContent = $article['full_content'] ?? $article['content'] ?? '';
$cleanContent = preg_replace('/\[\+\d+\schars\]/', '', $rawContent);
$cleanContent = trim($cleanContent); // remove extra spaces/newlines
// Convert double newlines into <p> blocks
$cleanContent = '<p>' . implode('</p><p>', array_filter(array_map('trim', preg_split("/\r?\n\r?\n/", $cleanContent)))) . '</p>';
@endphp

<div id="articleContent" class="article-content collapsed">
    {!! $cleanContent ?: '<p>Full content not available.</p>' !!}
</div>

            <div class="text mt-3">
                <button id="readMoreBtn" class="btn btn-primary">
                    Read More
                </button>
                <button id="shareBtn" class="btn btn-primary">
    <i class="bi bi-send"></i>  
</button>
            </div>

        </div>

        {{-- ================= SIMILAR NEWS ================= --}}
       <div class="col-lg-4">
    <div class="card similar-news-card">
        <!-- Header -->
        <div class="card-header similar-news-header">
            Similar News
        </div>
        <!-- Body -->
        <div class="card-body p-0">
            @forelse($similarNews as $news)
                @php
                    $similarTitle = $news['title'] ?? '';
                @endphp
                <div class="similar-news-item">
                    <a href="{{ route('news.show', urlencode($similarTitle)) }}"
                       class="similar-news-link">
                        {{ $similarTitle }}
                    </a>
                    @if(!empty($news['publishedAt']))
                        <div class="similar-news-time">
                            {{ \Carbon\Carbon::parse($news['publishedAt'])->diffForHumans() }}
                        </div>
                    @endif
                </div>
            @empty
                <p class="text-muted p-3">No similar news found.</p>
            @endforelse
        </div>
    </div>
<br/>
     <button
                class="analyse-btn"
                data-title="{{ $article['title'] }}"
                data-date="{{ $article['publishedAt'] }}">
                Analyse Impact
            </button>

            <div class="result-box" style="display:none;"></div>
            <canvas class="mini-chart mt-3" height="80" style="display:none;"></canvas>
</div>


    </div>
</div> 
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
$(document).ready(function(){

   $('.analyse-btn').click(function(e){
    e.stopPropagation();

    let btn = $(this);
    let card = btn.closest('div.col-lg-4'); // updated
    let resultBox = card.find('.result-box');
    let chartCanvas = card.find('.mini-chart');

    if(resultBox.is(':visible')){
        resultBox.slideUp();
        chartCanvas.hide();
        return;
    }

    // Close other boxes
    $('.result-box').slideUp();
    $('.mini-chart').hide();

    resultBox.html("Analysing... ⏳").slideDown();

    $.post('{{ route("news.analyse") }}', {
        _token: '{{ csrf_token() }}',
        title: btn.data('title'),
        publishedAt: btn.data('date')
    }, function(data){
       let emoji = "⚪";

if(data.sentiment_label == "Bullish") emoji = "🟢";
if(data.sentiment_label == "Bearish") emoji = "🔴";
if(data.sentiment_label == "Neutral") emoji = "🟡";

resultBox.html(`
<div style="font-size:15px">

<p><strong>Market Sentiment:</strong> 
${emoji} ${data.sentiment_label} (${data.sentiment_score}%)
</p>
 

<hr>

<p><strong>📈 If You Invested ₹10,000:</strong><br>
Today Value = ₹${data.investment_today}
</p>

<hr>

<p><strong>⚠ Risk Level:</strong> ${data.risk}</p>

<p><strong>📊 Price Change:</strong> ${data.price_change_percent}%</p>

<p><strong>🚀 Volume Spike:</strong> ${data.volume_spike ? 'YES' : 'NO'}</p>

<hr>

<p><strong>🧠 Strategy Suggestion:</strong> ${data.strategy}</p>

<p><strong>🔮 Future Outlook:</strong> ${data.future_outlook}</p>

</div>
`);

        chartCanvas.show();
        let ctx = chartCanvas[0].getContext('2d');

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Before News','After News'],
                datasets: [{
                    data: [0, data.price_change_percent],
                    borderColor: '#6f42c1',
                    borderWidth: 2,
                    fill: false
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } }
            }
        });

    }).fail(function(){
        resultBox.html("Error analysing news ❌");
    });
});
});
</script>
<script>
document.getElementById('readMoreBtn').addEventListener('click', function() {

    const article = document.getElementById('articleContent');

    if(article.classList.contains('collapsed')){
        article.classList.remove('collapsed');
        article.classList.add('expanded');
        this.innerText = 'Show Less';
    }else{
        article.classList.remove('expanded');
        article.classList.add('collapsed');
        this.innerText = 'Read More';
    }

});
</script>
<script>
document.addEventListener("DOMContentLoaded", function(){

    let voices = [];

    // Wait for voices to load
    speechSynthesis.onvoiceschanged = function() {
        voices = speechSynthesis.getVoices();
        console.log("Available voices:", voices);
    };

    const btn = document.getElementById("readSummaryBtn");
    const summary = document.getElementById("aiSummaryContent");

    let speech;
    btn.addEventListener("click", function(){

        if(!summary){
            alert("Summary not found");
            return;
        }

        let text = summary.innerText;

        // remove emojis/icons
        text = text.replace(/[\p{Emoji_Presentation}\p{Extended_Pictographic}]/gu, '');

        // get language from navbar selection
        let lang = localStorage.getItem("selectedLang") || "en";

        // map selected languages to SpeechSynthesis codes
        const langMap = {
            en: "en-US",
            hi: "hi-IN",
            gu: "gu-IN",
            mr: "mr-IN",
            bn: "bn-IN",
            ta: "ta-IN",
            te: "te-IN",
            pa: "pa-IN",
            ur: "ur-PK"
        };

        let speechLang = langMap[lang];

        if (!speechLang) {
            alert("Selected language not supported.");
            return;
        }

        // Find the voice for this language
        let voice = voices.find(v => v.lang === speechLang);

        if (!voice) {
            alert(`Voice for "${lang}" not installed.
Please install the voice in your OS:
Windows: Settings → Time & Language → Language → Add a language → install TTS
Mac: System Preferences → Accessibility → Spoken Content → System Voice → Customize`);
            return;
        }

        if (speechSynthesis.speaking) {
            speechSynthesis.cancel();
            btn.innerText = "🔊";
            btn.classList.remove("stop");
            return;
        }

        speech = new SpeechSynthesisUtterance(text);

        // use the exact installed voice
        speech.voice = voice;
        speech.lang = voice.lang;
        speech.rate = 1;
        speech.pitch = 1;

        speechSynthesis.speak(speech);

        btn.innerText = "🔇";
        btn.classList.add("stop"); // add red

        speech.onend = function(){
            btn.innerText = "🔊";
            btn.classList.remove("stop");
        };

    });

});
</script>
<script>
    document.addEventListener("DOMContentLoaded", function() {

    const shareBtn = document.getElementById("shareBtn");

    shareBtn.addEventListener("click", function() {
        const url = window.location.href; // full page URL
        const title = document.querySelector('h2').innerText; // article title

        if (navigator.share) {
            // Mobile / modern browsers
            navigator.share({
                title: title,
                url: url
            }).catch(console.error);
        } else {
            // Fallback: copy full page URL
            navigator.clipboard.writeText(url).then(() => {
                alert("Article link copied to clipboard!");
            });
        }
    });

});
</script>
@endsection
<style>
/* Bootstrap Purple */
.bg-purple {
    background-color: #6f42c1;
}

.text-purple {
    color: #f1eff5;
}

/* Hover effect */
.hover-purple:hover {
    color: #6f42c1 !important;
}

/* Article content styling */
.article-content {
    font-size: 16px;
    line-height: 1.8;
    color: #333;
}

.article-content p {
    margin-bottom: 15px;
}
/* ===== ARTICLE IMAGE FIXED SIZE ===== */

.article-image-wrapper {
    width: 100%;
    height: 420px;        /* Fixed height like news portals */
    overflow: hidden;
    border-radius: 12px;
}

.article-image-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;    /* Crop nicely */
    display: block;
}
.article-content.collapsed {
    max-height: 300px;
    overflow: hidden;
    position: relative;
    padding-bottom: 0;     /* ensures button is right after content */
}
.article-content p {
    margin-bottom: 1em;
    line-height: 1.8;  /* reduce spacing if needed */
}

.article-content br {
    line-height: 0;        /* removes extra spacing from <br> */
} 
/* ===== SIMILAR NEWS DARK CARD ===== */

/* ===== SIMILAR NEWS - LIGHT MODE ===== */

.similar-news-card {
    background: #ffffff;
    border-radius: 14px;
    border: 1px solid #e5e7eb;
    overflow: hidden;
    color: #111827;
}

/* Header */
.similar-news-header {
    background: #f9fafb;
    color: #111827;
    font-weight: 600;
    padding: 14px 18px;
    border-bottom: 1px solid #e5e7eb;
    font-size: 16px;
}

/* Each News Item */
.similar-news-item {
    padding: 15px 18px;
    border-bottom: 1px solid #e5e7eb;
    transition: background 0.3s ease;
}

/* Remove last border */
.similar-news-item:last-child {
    border-bottom: none;
}

/* Hover Effect */
.similar-news-item:hover {
    background: #f3f4f6;
}

/* News Link */
.similar-news-link {
    color: #111827;
    font-weight: 600;
    text-decoration: none;
    display: block;
    line-height: 1.4;
}

/* Hover → Bootstrap Purple */
.similar-news-link:hover {
    color: #6f42c1;
    text-decoration: underline;
}

/* Time */
.similar-news-time {
    margin-top: 6px;
    font-size: 13px;
    color: #6b7280;
}
/* ===== SIMILAR NEWS - DARK MODE ===== */

body.dark .similar-news-card {
    background: linear-gradient(135deg, #020617, #020617);
    border: 1px solid #1e293b;
    color: #ffffff;
}

body.dark .similar-news-header {
    background: transparent;
    color: #ffffff;
    border-bottom: 1px solid #1e293b;
}

body.dark .similar-news-item {
    border-bottom: 1px solid #1e293b;
}

body.dark .similar-news-item:hover {
    background: rgba(255, 255, 255, 0.05);
}

body.dark .similar-news-link {
    color: #ffffff;
}

body.dark .similar-news-time {
    color: #94a3b8;
}
/* AI SUMMARY BOX */
 
.ai-summary-header{
    font-weight:700;
    color:#16a34a;
    font-size:18px;
    margin-bottom:10px;
}

.ai-summary-list,
.ai-impact ul{
    padding-left:20px;
}

.ai-summary-list li,
.ai-impact li{
    margin-bottom:8px;
    line-height:1.7;
}

/* remove smaller font */
.ai-impact{
    font-size:16px;
}

.ai-summary-box h5{
    font-weight:600;
}

.ai-summary-box hr{
    border:none;
    border-top:1px solid #b0b0b0;
    margin:16px 0;
}
  
/* Dark Mode */

body.dark .ai-summary-box{
    background:#020617;
    border:1px solid #22c55e;
}

body.dark .ai-summary-header{
    color:#4ade80;
}
 
 #sharebtn{
    height:35px;
 }
 .ai-summary-box {
    max-height: 430px;   /* adjust as needed */
    overflow-y: auto;
    padding-right: 5px; 
      border:1px solid #22c55e;
    border-radius:12px;
    padding:18px;
    background:#f8fff9;
    font-size:16px;        /* unified font size */
    line-height:1.7; /* avoids scrollbar overlap */
}

/* Optional: smooth scrollbar (modern look) */
.ai-summary-box::-webkit-scrollbar {
    width: 6px;
}

.ai-summary-box::-webkit-scrollbar-thumb {
    background: #7b3fe4;
    border-radius: 10px;
}
</style>