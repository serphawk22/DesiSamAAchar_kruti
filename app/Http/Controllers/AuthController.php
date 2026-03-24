<?php

namespace App\Http\Controllers;
use App\Models\Users;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth; 
use Illuminate\Support\Facades\Session;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{
    
 public function register(Request $request)
{
    $request->validate([
        'name' => 'required|string|max:150',
        'email' => 'required|email|max:150|unique:users,email',
        'password' => 'required|min:6|confirmed',
        'role' => 'required|in:editor,user',
        'terms' => 'accepted',
    ]);

    $user = Users::create([
        'name' => $request->name,
        'email' => $request->email,
        'password' => Hash::make($request->password),
        'role' => $request->role,
        'language' => 'en',
        'avatar' => null,
    ]);

   // ✅ Normal Session Store
    session([
        'user_id'   => $user->id,
        'user_name' => $user->name,
        'user_role' => $user->role,
    ]);

    // ✅ Redirect based on role
    if ($user->role === 'editor') {
        return redirect()->route('editor.dashboard');
    }

    return redirect()->route('user.dashboard');
}

    // Login User
 public function login(Request $request)
{
    // ✅ Validation
    $request->validate([
        'email' => 'required|email',
        'password' => 'required|min:6',
    ], [
        'email.required' => 'Please enter your email address.',
        'email.email' => 'Enter a valid email address.',
        'password.required' => 'Please enter your password.',
        'password.min' => 'Password must be at least 6 characters.',
    ]);

    // ✅ Find user
  $user = Users::where('email', $request->email)->first();

if (!$user) {
    return back()->with('error', 'Invalid Credentials')->withInput();
}

try {
    if (!Hash::check($request->password, $user->password)) {
        return back()->with('error', 'Invalid Credentials')->withInput();
    }
} catch (\Exception $e) {
    return back()->with('error', 'Invalid Credentials')->withInput();
}
/* Remember Me Logic */
    if ($request->has('remember')) {
        // 30 days session
        config(['session.lifetime' => 43200]); // 30 days (minutes)
    } else {
        // Default 2 hours (120 minutes)
        config(['session.lifetime' => 120]);
    }
    // Regenerate session for security
    $request->session()->regenerate();
    // ✅ Store Session
    session([
        'user_id'   => $user->id,
        'user_name' => $user->name,
        'user_role' => $user->role,
    ]);

    // ✅ Update Last Login
    $user->update([
        'last_login' => now()
    ]); 

    // ✅ 🔥 INSERT LOGIN ACTIVITY LOG
    DB::table('activity_logs')->insert([
        'user_id' => $user->id,
        'action'  => $user->role . ' logged in',
        'ip'      => $request->ip(),
        'created_at' => now(),
    ]);

    // ✅ Redirect Based on Role
    if ($user->role === 'admin') {
        return redirect()->route('admin.dashboard')
            ->with('success', 'Welcome Admin');
    }

    if ($user->role === 'editor') {
        return redirect()->route('editor.dashboard')
            ->with('success', 'Welcome Editor');
    }

    return redirect()->route('user.dashboard')
        ->with('success', 'Login Successful');
}

    // Logout
    public function logout()
    {
        session()->flush();
        return redirect('/signin');
    }
}
