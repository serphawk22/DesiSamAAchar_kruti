<div id="sidebar" class="editor-sidebar">

    <div class="sidebar-title">
        Admin Panel
    </div>

    <a href="{{ route('admin.dashboard')}}">
        <i class="bi bi-speedometer2"></i>
        <span>Dashboard</span>
    </a>

    <a href="{{ route('admin.users') }}">
        <i class="bi bi-people"></i>
        <span>User Management</span>
    </a>

    <a href="{{ route('admin.content') }}">
        <i class="bi bi-file-earmark-text"></i>
        <span>Content Management</span>
    </a>

    <a href="{{ route('admin.categories') }}">
        <i class="bi bi-folder"></i>
        <span>Categories</span>
    </a>

  <!--  <a href="#">
        <i class="bi bi-images"></i>
        <span>Media Library</span>
    </a>
 <a href="#">
        <i class="bi bi-shield-lock"></i>
        <span>Security & Logs</span>
    </a>
    <a href="#">
        <i class="bi bi-robot"></i>
        <span>AI Center</span>
    </a>-->

    <a href="{{ route('admin.comments') }}">
        <i class="bi bi-chat-dots"></i>
        <span>Comments</span>
    </a>

    <a href="{{ route('admin.reports') }}">
        <i class="bi bi-bar-chart"></i>
        <span>Analytics & Reports</span>
    </a>

    <a href="{{route('admin.profile')}}">
        <i class="bi bi-gear"></i>
        <span>Profile</span>
    </a>

    <a href="{{ route('logout') }}" class="text-danger">
        <i class="bi bi-box-arrow-right"></i>
        <span>Logout</span>
    </a>

</div>