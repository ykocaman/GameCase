<?php

namespace App\Kernel;

class Application
{
    public static $config = array();

    function __construct()
    {
        static::$config = include __DIR__.'/../../config/app.php';
    }
    
    public function run(){
        $route = Route::getInstance();
        return $route->call(Request::method(),Request::url());
    }
}