<?php

namespace App\Models;
use App\Models\Subcatagory;
use App\Models\Catagories;
use Illuminate\Database\Eloquent\Model;

class UserInterest extends Model
{
       protected $table = 'user_interests';

    // Fillable fields
    protected $fillable = [
        'user_id',
        'category_id',
        'subcategory_id',
    ];
    public $timestamps = false;
      public function category()
    {
        return $this->belongsTo(Catagories::class);
    }

    public function subcategory()
    {
        return $this->belongsTo(Subcatagory::class);
    }
}
