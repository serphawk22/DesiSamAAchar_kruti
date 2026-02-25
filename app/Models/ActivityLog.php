<?php

namespace App\Models;
use App\Models\Users;
use Illuminate\Database\Eloquent\Model;

class ActivityLog extends Model
{
     protected $table = 'activity_logs';

    public $timestamps = false; // because you only have created_at

    protected $fillable = [
        'user_id',
        'action',
        'ip',
        'created_at',
    ];

    // Relationship
    public function user()
    {
        return $this->belongsTo(Users::class);
    }
}
