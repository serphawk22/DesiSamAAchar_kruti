 <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DesiSamAAchar</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <link rel="icon" href="{{ asset('favicon.ico') }}" type="image/x-icon">
<link rel="shortcut icon" href="{{ asset('favicon.ico') }}">
    {{-- Bootstrap --}}
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    @include('components.styles')
    <style>
/* Hide Google translate top banner completely */
.goog-te-banner-frame {
    display: none !important;
}

.skiptranslate iframe {
    display: none !important;
}

/* Remove body offset */
body {
    top: 0px !important;
}

/* Remove highlight */
.goog-text-highlight {
    background: none !important;
    box-shadow: none !important;
}

/* Hide tooltip */
.goog-tooltip {
    display: none !important;
}
/* Hide Google Translate widget completely */
.goog-te-banner-frame,
.goog-te-banner-frame.skiptranslate,
.goog-te-gadget,
.goog-te-gadget-icon,
.goog-logo-link,
.goog-te-balloon-frame,
#goog-gt-tt,
.skiptranslate {
    display: none !important;
}

</style>
</head>
<body>

<x-navbar />

<div class="d-flex">
   @if(session()->has('user_id'))
    @php
        $user = \App\Models\Users::find(session('user_id'));
    @endphp

    @if($user && $user->role === 'editor')
        <x-editorsidebar />
        @elseif($user && $user->role === 'admin')
        <x-adminsidebar />
         @elseif($user && $user->role === 'user')
        <x-usersidebar />
    @else
        <x-sidebar />
    @endif
@else
    <x-sidebar />
@endif

    <main class="main-content flex-fill p-4">
        @yield('content')
    </main>
</div>

<div id="google_translate_element" style="display:none;"></div>

<script>
function googleTranslateElementInit() {
    new google.translate.TranslateElement({
        pageLanguage: 'en',
        includedLanguages: 'en,hi,gu,mr,bn,ta,te,kn,ml,pa,ur',
        autoDisplay: false
    }, 'google_translate_element');
}

/* Change language */
function changeLang(lang) {
    var interval = setInterval(function () {
        var select = document.querySelector(".goog-te-combo");
        if (select) {
            select.value = lang;
            select.dispatchEvent(new Event("change"));
            clearInterval(interval);
        }
    }, 300);
}

/* Remove Google top bar */
function hideGoogleTranslateBar() {

    const banner = document.querySelector('.goog-te-banner-frame');
    if (banner) {
        banner.remove();
    }

    document.body.style.top = "0px";

}

/* Run continuously */
setInterval(hideGoogleTranslateBar, 200);
</script>

<script src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
 
<script>
/* Sidebar Toggle */
const sidebar = document.getElementById('sidebar');
const toggleBtn = document.getElementById('sidebarToggle');

toggleBtn.addEventListener('click', () => {
    sidebar.classList.toggle('collapsed');
});
</script>

 <meta name="csrf-token" content="{{ csrf_token() }}">

<div id="aiChatbot">

<button id="chatToggle">
💬
</button>

<div id="chatWindow">

<div id="chatHeader">
<div class="ai-title">
<span class="dot"></span>
Finance AI Assistant
</div>

<span id="chatClose">✕</span>
</div>

<div id="chatMessages"></div>

<div id="chatInputArea">
<input type="text" id="chatInput" placeholder="Ask about stocks, crypto, markets...">
<button id="chatSend">➤</button>
</div>

</div>

</div>
 
<script>

document.addEventListener("DOMContentLoaded", function(){

const toggle = document.getElementById("chatToggle");
const chatWindow = document.getElementById("chatWindow");
const chatMessages = document.getElementById("chatMessages");
const chatInput = document.getElementById("chatInput");
const chatSend = document.getElementById("chatSend");

toggle.onclick = function(){

chatWindow.style.display =
chatWindow.style.display === "flex" ? "none" : "flex";

};

const closeBtn = document.getElementById("chatClose");

closeBtn.onclick = function(){
chatWindow.style.display = "none";
};
chatSend.onclick = sendMessage;
chatInput.addEventListener("keypress", function(e){
if(e.key === "Enter"){
sendMessage();
}
});
function sendMessage(){

let message = chatInput.value.trim();

if(message === "") return;


/* USER MESSAGE */

chatMessages.innerHTML += `
<div class="user">
<span>${message}</span>
</div>
`;
chatMessages.scrollTo({
top: chatMessages.scrollHeight,
behavior: "smooth"
});

chatInput.value = "";


/* LOADING MESSAGE */

const typingId = "typing-" + Date.now();

chatMessages.innerHTML += `
<div class="bot" id="${typingId}">
<span class="loading-dots"></span>
</div>
`;
chatMessages.scrollTo({
top: chatMessages.scrollHeight,
behavior: "smooth"
});
chatInput.value = "";

fetch("{{ route('chatbot.ask') }}",{

method:"POST",

headers:{
"Content-Type":"application/json",
"X-CSRF-TOKEN":document.querySelector('meta[name="csrf-token"]').content
},

body:JSON.stringify({
message:message
})

})
.then(res => res.json())
.then(data => {
document.getElementById(typingId)?.remove();
chatMessages.innerHTML += `<div class="bot"><span>${data.answer}</span></div>`;

chatMessages.scrollTo({
top: chatMessages.scrollHeight,
behavior: "smooth"
});

})
.catch(err => {

chatMessages.innerHTML += `<div class="bot">⚠️ AI not responding</div>`;
chatMessages.scrollTo({
top: chatMessages.scrollHeight,
behavior: "smooth"
});

});

}

});
</script>
<script>
function hideGoogleTranslate() {
    /* remove widget container */
    const gadget = document.querySelector(".goog-te-gadget");
    if(gadget) gadget.style.display = "none";
    /* remove floating iframe */
    const frame = document.querySelector(".goog-te-banner-frame");
    if(frame) frame.remove();
    /* remove translate tooltip */
    const tooltip = document.querySelector("#goog-gt-tt");
    if(tooltip) tooltip.remove();
    /* reset body position */
    document.body.style.top = "0px";
}
/* run continuously because google re-injects it */
setInterval(hideGoogleTranslate, 500);

</script>
@include('components.footer')
 
</body>
</html>
