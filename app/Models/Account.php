<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Auth\Authenticatable as Authenticatable;

class Account extends Model implements AuthenticatableContract
{
    use Authenticatable;

    // Basic configuration
    // $connection is the database name in config/database.php
    // $table is the table name used
    // $primaryKey is the table primary key
    protected $connection = 'evaluat0r';
    protected $table = 'account';
    //protected $primaryKey = 'id';


    protected $fillable = ['firstname', 'lastname', 'email', 'rank']; //can be mass assignable
    protected $hidden = ['sha1_pass', 'session_key', 'token_key']; //exclude from the api
}