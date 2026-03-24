<?php

namespace App\Models;
use App\Models\Articles;
use Illuminate\Database\Eloquent\Model;

class Bookmark extends Model
{
     protected $table = 'bookmarks';

    // Fillable fields
    protected $fillable = [
        'user_id',
        'article_id',
        'page_location',
    ];
public $timestamps = false; 
    // Relationships
    public function article()
    {
        return $this->belongsTo(Articles::class, 'article_id');
    }
}
