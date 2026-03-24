@props([
    'fixedCategories' => [],
    'allCategories' => collect()
])

<nav class="navbar navbar-expand-lg px-4 py-2 notranslate">
    <div class="d-flex w-100 align-items-center position-relative">

        {{-- Left: Sidebar & Brand --}}
        <div class="d-flex align-items-center">
           <button id="sidebarToggle" class="btn btn-light me-3">☰</button>
    <a class="navbar-brand fw-bold" href="{{ url('/') }}">DesiSamAAchar</a>
        </div>
 

    {{-- Mobile Toggle --}}
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="mainNavbar">

        {{-- Center Categories --}}
        @php
            $userRole = session('user_role') ?? null;
        @endphp

         <ul class="navbar-nav position-absolute start-50 translate-middle-x mb-0">
            @if($userRole === 'user'||$userRole === null)
                @foreach($fixedCategories as $cat)
                    <li class="nav-item dropdown d-flex align-items-center">
                        {{-- Main Link --}}
                        <a class="nav-link {{ request()->is(strtolower($cat['name'])) ? 'active-nav' : '' }}"
                           href="{{ $cat['url'] }}">
                            {{ $cat['name'] }}
                        </a>

                        {{-- Dropdown --}}
                        @if(!empty($cat['subcategories']) && $cat['subcategories']->count())
                            <a class="nav-link dropdown-toggle dropdown-toggle-split"
                               href="#"
                               role="button"
                               data-bs-toggle="dropdown">
                            </a>

                            <ul class="dropdown-menu shadow-sm">
                                @foreach($cat['subcategories'] as $sub)
                                    @php $subName = Str::lower($sub->name); @endphp
                                    <li>
                                        <a class="dropdown-item"
                                           href="
                                            @if($subName === 'sensex/nifty')
                                                {{ route('sensex.index') }} 
                                            @elseif($subName === 'stock')
                                                {{ url('/stock-news') }}  
                                            @else
                                                {{ route('category.show', ['name' => $sub->name]) }}
                                            @endif
                                           ">
                                            {{ $sub->name }}
                                        </a>
                                    </li>
                                @endforeach
                            </ul>
                        @endif
                    </li>
                @endforeach
            @endif
        </ul>

        {{-- Right Section --}}
        <div class="d-flex align-items-center gap-3 ms-auto">
            <button class="theme-btn" id="themeBtn">
                <i class="bi bi-sun" id="themeIcon"></i>
            </button>

            {{-- Language Dropdown --}}
          <div class="dropdown">
                <button class="btn btn-outline-secondary btn-sm" type="button" data-bs-toggle="dropdown">
                    <i class="bi bi-globe"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow-sm lang-dropdown">
                <li><a class="dropdown-item lang-btn" href="javascript:void(0)" data-lang="en">English</a></li>

                <li><a class="dropdown-item lang-btn" href="javascript:void(0)" data-lang="hi">हिन्दी</a></li>

                <li><a class="dropdown-item lang-btn" href="javascript:void(0)" data-lang="gu" >ગુજરાતી</a></li>

                <li><a class="dropdown-item lang-btn" href="javascript:void(0)" data-lang="mr"  >मराठी</a></li>

                <li><a class="dropdown-item lang-btn" href="javascript:void(0)" data-lang="bn" >বাংলা</a></li>

                <li><a class="dropdown-item lang-btn" href="javascript:void(0)" data-lang="ta" >தமிழ்</a></li>

                <li><a class="dropdown-item lang-btn" href="javascript:void(0)" data-lang="te" >తెలుగు</a></li>

                <li><a class="dropdown-item lang-btn" href="javascript:void(0)" data-lang="kn" >ಕನ್ನಡ</a></li>

                <li><a class="dropdown-item lang-btn" href="javascript:void(0)" data-lang="ml" >മലയാളം</a></li>

                <li><a class="dropdown-item lang-btn" href="javascript:void(0)" data-lang="pa">ਪੰਜਾਬੀ</a></li>

                <li><a class="dropdown-item lang-btn" href="javascript:void(0)" data-lang="ur">اردو</a></li>
                </ul>
            </div>

        {{-- Login / Logout --}}
@if(session()->has('user_id'))

    @if(session('user_role') === 'user')
        <a href="{{ route('user.dashboard') }}" 
           class="btn btn-outline-primary btn-sm ms-2">
            <i class="bi bi-speedometer2"></i>
        </a> 
       <div class="dropdown position-relative me-3">
    <a href="#" id="notifDropdown" data-bs-toggle="dropdown"
       class="text-dark position-relative">
        <!-- Bell Icon -->
        <i class="bi bi-bell" style="font-size:22px;"></i>
        <!-- Notification Count -->
       <span id="notifCount">
0
</span>
    </a> 
    <!-- Dropdown -->
    <ul class="dropdown-menu dropdown-menu-end shadow"
        id="notifList"
        style="width:320px; max-height:400px; overflow-y:auto;">
        <li class="dropdown-item text-muted text-center">
            No notifications
        </li>
    </ul>
</div>
    @endif
    <a href="{{ url('/logout') }}" class="btn btn-danger btn-sm ms-2">
        <i class="bi bi-box-arrow-right"></i>
    </a>

@else
    <a href="{{ url('/signin') }}" class="btn login-btn btn-sm ms-2">
        <i class="bi bi-person"></i>
    </a>
@endif
        </div>
    </div>
</nav> 

<script>
async function loadNotifications(){

    let res = await fetch("/notifications/news");
    let data = await res.json();

    let list = document.getElementById("notifList");
    let count = document.getElementById("notifCount");

    list.innerHTML = "";
    count.innerText = data.length;

    if(data.length === 0){
        list.innerHTML = `<li class="dropdown-item">No news</li>`;
        return;
    }

    data.forEach(news => {

        let li = document.createElement("li");

        li.innerHTML = `
        <a class="dropdown-item" href="${news.url}">
            ${news.type === 'stock' ? '📈' : '📰'} ${news.title}
        </a>`;

        list.appendChild(li);
    });
}

setInterval(loadNotifications,60000);
loadNotifications();
</script>
<script>
/* Dark Mode */
const btn = document.getElementById('themeBtn');
const icon = document.getElementById('themeIcon');

if(localStorage.theme === 'dark'){
    document.body.classList.add('dark');
    icon.className = 'bi bi-moon';
}

btn.onclick = () => {
    document.body.classList.toggle('dark');
    const dark = document.body.classList.contains('dark');
    icon.className = dark ? 'bi bi-moon' : 'bi bi-sun';
    localStorage.theme = dark ? 'dark' : 'light';
};
</script>
<script>
document.addEventListener("DOMContentLoaded", function(){

    console.log("Language handler ready");

    document.querySelectorAll(".lang-btn").forEach(function(btn){

        btn.addEventListener("click", function(){

            let lang = this.getAttribute("data-lang");

            console.log("Clicked language:", lang);

            localStorage.setItem("selectedLang", lang);
            document.cookie = "selectedLang=" + lang + "; path=/";

            let select = document.querySelector(".goog-te-combo");

            if(select){
                select.value = lang;
                select.dispatchEvent(new Event("change"));
            }

        });

    });

});
</script>