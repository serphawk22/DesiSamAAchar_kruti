<div id="sidebar" class="editor-sidebar">
 
    <a href="{{ route('user.dashboard') }}">
        <i class="bi bi-speedometer2"></i>
        <span>Dashboard</span>
    </a>

    <a href="{{ route('stocks.index') }}">
        <i class="bi bi-eye"></i>
        <span>Watchlist</span>
    </a>

    <a href="{{ route('user.interests') }}">
        <i class="bi bi-heart"></i>
        <span>My Interests</span>
    </a>

    <a href="{{route('user.bookmarks')}}">
        <i class="bi bi-bookmark"></i>
        <span>Bookmarks</span>
    </a>
<a href="{{ route('user.smart-money') }}">
<i class="bi bi-cash-stack"></i>
<span>Smart Money</span>
</a>
    <a href="{{route('stocks.liked')}}">
        <i class="bi bi-graph-up-arrow"></i>
        <span>Liked Stocks</span>
    </a>

     <a href="{{ route('user.recommendations') }}">
        <i class="bi bi-lightbulb"></i>
        <span>Recommendations</span>
    </a>
    
    <a href="{{route('profile.index')}}">
        <i class="bi bi-person-circle"></i>
        <span>Profile</span>
    </a>

    <a href="{{url('/logout')}}" class="text-danger">
        <i class="bi bi-box-arrow-right"></i>
        <span>Logout</span>
    </a>

</div>