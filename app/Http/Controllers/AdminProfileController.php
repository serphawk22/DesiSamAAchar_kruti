<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;

class AdminProfileController extends Controller
{
    public function index()
    {
        if (!session('user_id')) {
            return redirect('/login');
        }

        $user = DB::table('users')
            ->where('id', session('user_id'))
            ->first();

        return view('admin.profile', compact('user'));
    }

     public function update(Request $request)
    {
        if (!session('user_id')) {
            return redirect('/login');
        }

        $userId = session('user_id');

        // Validation
        $request->validate([
            'name' => 'required|max:150',
            'email' => 'required|email|max:150|unique:users,email,' . $userId,
            'password' => 'nullable|confirmed|min:6',
            'avatar' => 'nullable|image|max:2048',
            'language' => 'nullable|max:255'
        ]);

        $user = DB::table('users')->where('id', $userId)->first();

        $updateData = [
            'name' => $request->name,
            'email' => $request->email,
            'language' => $request->language
        ];

        // Avatar Upload
        if ($request->hasFile('avatar')) {

            // Create folder if not exists
            if (!file_exists(public_path('images/news'))) {
                mkdir(public_path('images/news'), 0755, true);
            }

            // Delete old avatar
            if ($user->avatar && file_exists(public_path('images/news/' . $user->avatar))) {
                unlink(public_path('images/news/' . $user->avatar));
            }

            $file = $request->file('avatar');
            $filename = time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('images/news'), $filename);

            $updateData['avatar'] = $filename;
        }

        // Update password only if entered
        if ($request->filled('password')) {
            $updateData['password'] = Hash::make($request->password);
        }

        DB::table('users')
            ->where('id', $userId)
            ->update($updateData);

        session(['user_name' => $request->name]);

        return back()->with('success', 'Profile Updated Successfully');
    }
}
