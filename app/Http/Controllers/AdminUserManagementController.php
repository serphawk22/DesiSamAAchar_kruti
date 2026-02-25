<?php

namespace App\Http\Controllers;
use App\Models\Users;
use App\Models\ActivityLog;
use Illuminate\Http\Request;

class AdminUserManagementController extends Controller
{
    public function index(Request $request)
{
    $query = Users::query();

    // 🔍 Search by name
        if ($request->search) {
            $query->where('name', 'LIKE', '%' . $request->search . '%');
        }

    // Filter by role
    if ($request->has('role')) {
        $query->where('role', $request->role);
    }

    // Filter by status
    if ($request->has('status')) {
        $query->where('status', $request->status);
    }

    $users = $query->orderByDesc('id')->paginate(15)->withQueryString();

    return view('admin.users', compact('users'));
}

 public function suggestions(Request $request)
    {
        $search = $request->search;

        $users = Users::where('name', 'LIKE', "{$search}%")
                      ->limit(5)
                      ->pluck('name');

        return response()->json($users);
    }

    public function promote($id)
    {
        $user = Users::findOrFail($id);
        $user->role = 'editor';
        $user->save();

        return back()->with('success', 'User promoted to Editor.');
    }

    public function block($id)
    {
        $user = Users::findOrFail($id);

        $user->status = $user->status === 'active' ? 'blocked' : 'active';
        $user->save();

        return back()->with('success', 'User status updated.');
    }

    public function activity($id)
    {
        $user = Users::findOrFail($id);

        $activities = ActivityLog::where('user_id', $id)
            ->orderByDesc('created_at')
            ->get();

        return view('admin.activity', compact('user', 'activities'));
    }
}
