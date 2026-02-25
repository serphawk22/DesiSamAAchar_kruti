<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MarketController;
use App\Http\Controllers\IndexController; 
use App\Http\Controllers\SensexController;
use App\Http\Controllers\IPOController;
use App\Http\Controllers\NewsController;  
use App\Http\Controllers\ArticleController;   
use App\Http\Controllers\StockNewsController;
use App\Http\Controllers\SIPController;
use App\Http\Controllers\CurrencyController;
use App\Http\Controllers\CompanyController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\EditorDashboardController;
use App\Http\Controllers\EditorArticleController;
use App\Http\Controllers\ArticleMediaController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\AdminDashboardController;
use App\Http\Controllers\AdminUserManagementController;
use App\Http\Controllers\ContentController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\AdminCommentController;

Route::get('/company', [CompanyController::class, 'index'])->name('company');
Route::get('/company/search', [CompanyController::class, 'search'])->name('company.search');

Route::get('/currency', [CurrencyController::class, 'index'])->name('currency.index');
Route::get('/sips', [SIPController::class, 'index'])->name('sips.index');

Route::get('/stock-news', [StockNewsController::class, 'index']);
Route::post('/analyse-news', [StockNewsController::class, 'analyse']);

Route::get('/', function () {
    return view('welcome');
});
Route::get('/', [HomeController::class, 'index'])->name('home'); 
Route::get('/', [MarketController::class, 'home']);
// routes/web.php
Route::get('/category/{name}', [MarketController::class, 'category'])->name('category.show'); 
Route::get('/sensex', [SensexController::class, 'index'])->name('sensex.index'); 
Route::get('/ipo', [IPOController::class, 'index'])->name('ipo.index');  
Route::get('/news', [NewsController::class, 'index'])->name('news.index');
Route::get('/news/{title}', [NewsController::class, 'show'])->name('news.show');
Route::get('/editor-articles', [ArticleController::class, 'index'])
    ->name('articles.index');
Route::get('/editor-articles/{slug}', [ArticleController::class, 'show'])
    ->name('articles.show'); 
Route::get('/signin', function () {
    return view('login');
});
Route::get('/signup', function () {
    return view('signup');
});
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login'])->name('login');
Route::get('/logout', [AuthController::class, 'logout'])->name('logout');

Route::get('/editor/dashboard', function () {
if (session('user_role') !== 'editor') {
    return redirect('/login');
}
return view('editor.dashboard');
})->name('editor.dashboard');

Route::get('/user/dashboard', function () {
    if (!session()->has('user_id')) {
        return redirect('/login');
    }
    return view('user.dashboard');
})->name('user.dashboard');

Route::get('/admin/dashboard', function () {
    if (session('user_role') !== 'admin') {
        return redirect('/login');
    }
    return view('admin.dashboard');
})->name('admin.dashboard');

Route::get('/editor/dashboard', [EditorDashboardController::class, 'index'])
    ->name('editor.dashboard');

Route::prefix('editor')->group(function () {

    Route::get('/articles', [EditorArticleController::class, 'index'])->name('articles');

    Route::post('/articles', [EditorArticleController::class, 'store'])
        ->name('articles.store');

    Route::post('/articles/update/{id}', [EditorArticleController::class, 'update'])->name('articles.update');

    Route::delete('/articles/delete/{id}', [EditorArticleController::class, 'delete'])->name('articles.delete');

   Route::get('/subcategories/{category}', 
    [EditorArticleController::class, 'getSubcategories']
)->name('editor.subcategories');

    Route::get('/articles/{id}/media', [EditorArticleController::class, 'getMedia']);

    Route::delete('/media/{id}', [EditorArticleController::class, 'deleteMedia']);
});
Route::get('/editor/media', [ArticleMediaController::class, 'index'])->name('editor.media'); 
Route::delete('/amedia/{id}', [ArticleMediaController::class, 'destroy'])->name('media.destroy');
Route::put('/amedia/{id}', [ArticleMediaController::class, 'update'])->name('media.update');
Route::get('/editor/comments', [CommentController::class, 'index'])->name('comments.index');
Route::get('/profile', [ProfileController::class, 'show'])->name('profile.show');
Route::post('/profile', [ProfileController::class, 'update'])->name('profile.update');

Route::get('/admin/dashboard', [AdminDashboardController::class, 'index'])
    ->name('admin.dashboard');

Route::prefix('admin')->group(function () {

    Route::get('/users', [AdminUserManagementController::class, 'index'])
        ->name('admin.users');

     Route::get('/users/suggestions', [AdminUserManagementController::class, 'suggestions'])
        ->name('admin.users.suggestions');

    Route::post('/users/promote/{id}', [AdminUserManagementController::class, 'promote'])
        ->name('admin.users.promote');

    Route::post('/users/block/{id}', [AdminUserManagementController::class, 'block'])
        ->name('admin.users.block');

    Route::get('/users/activity/{id}', [AdminUserManagementController::class, 'activity'])
        ->name('admin.users.activity');

     Route::get('/content', [ContentController::class, 'index'])
        ->name('admin.content');

    Route::post('/content/publish/{id}', [ContentController::class, 'publish'])
        ->name('admin.content.publish');

    Route::post('/content/delete/{id}', [ContentController::class, 'delete'])
        ->name('admin.content.delete');
 
    Route::get('/content/suggestions', 
    [ContentController::class, 'suggestions']
)->name('admin.content.suggestions');

   Route::get('/categories', [CategoryController::class, 'index'])
    ->name('admin.categories');
    Route::get('/admin/categories/suggestions',
    [CategoryController::class, 'suggestions']
)->name('admin.categories.suggestions');

Route::post('/categories/store', [CategoryController::class, 'store'])
    ->name('admin.categories.store');

Route::delete('/categories/delete/{id}', [CategoryController::class, 'destroy'])
    ->name('admin.categories.delete');

Route::post('/categories/toggle/{id}', [CategoryController::class, 'toggleStatus'])
    ->name('admin.categories.toggle');

Route::post('/subcategories/store', [CategoryController::class, 'storeSubcategory'])
    ->name('admin.subcategories.store');

Route::delete('/subcategories/delete/{id}', [CategoryController::class, 'destroySub'])
    ->name('admin.subcategories.delete');

 Route::get('/comments', [AdminCommentController::class, 'index'])
        ->name('admin.comments');

    Route::post('/comments/approve/{id}', [AdminCommentController::class, 'approve'])
        ->name('admin.comments.approve');

    Route::post('/comments/delete/{id}', [AdminCommentController::class, 'delete'])
        ->name('admin.comments.delete');

    Route::post('/users/ban/{id}', [AdminCommentController::class, 'banUser'])
        ->name('admin.users.ban');

    Route::get('/reports-dashboard', 
    [AdminReportController::class, 'index']
)->name('admin.reports.dashboard');

});
