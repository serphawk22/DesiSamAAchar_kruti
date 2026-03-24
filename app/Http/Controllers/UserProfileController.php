<?php

namespace App\Http\Controllers;
use App\Models\Users;
use Illuminate\Http\Request;

class UserProfileController extends Controller
{
     public function index()
    {
        $userId = session('user_id');

        if (!$userId) {
            return redirect('/login');
        }

        $user = Users::find($userId);

        if (!$user) {
            return redirect('/login');
        }

        return view('user.profile', compact('user'));
    }

    /*
    |--------------------------------------------------------------------------
    | Update Profile
    |--------------------------------------------------------------------------
    */

    public function update(Request $request)
{
    $userId = session('user_id');

    if (!$userId) {
        return redirect('/login');
    }

    $user = Users::find($userId);

    if (!$user) {
        return redirect('/login');
    }

    /*
    |--------------------------------------------------------------------------
    | Validation
    |--------------------------------------------------------------------------
    */
/*
|--------------------------------------------------------------------------
| Validation
|--------------------------------------------------------------------------
*/

$request->validate([
    'name'      => 'required|max:150',
    'email'     => 'required|email|max:150|unique:users,email,' . $user->id,
    'language'  => 'nullable|max:20',
    'avatar'    => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
    'password'  => 'nullable|min:6|confirmed',
]);


/*
|--------------------------------------------------------------------------
| Update Basic Fields
|--------------------------------------------------------------------------
*/

$user->name     = $request->name;
$user->email    = $request->email;
$user->language = $request->language;


/*
|--------------------------------------------------------------------------
| Password Update (ONLY if filled)
|--------------------------------------------------------------------------
*/

if ($request->filled('password')) {
    $user->password = bcrypt($request->password);
}

    /*
    |--------------------------------------------------------------------------
    | Avatar Upload
    |--------------------------------------------------------------------------
    */

    if ($request->hasFile('avatar')) {

        // Delete old avatar
        if ($user->avatar && file_exists(public_path('images/news/' . $user->avatar))) {
            unlink(public_path('images/news/' . $user->avatar));
        }

        $file = $request->file('avatar');
        $filename = time() . '_' . $file->getClientOriginalName();

        $file->move(public_path('images/news'), $filename);

        $user->avatar = $filename;
    }

    /*
    |--------------------------------------------------------------------------
    | Save
    |--------------------------------------------------------------------------
    */

    $user->save();

    // Update session values
    session([
        'user_name' => $user->name,
    ]);

    return back()->with('success', 'Profile updated successfully.');
}
}
