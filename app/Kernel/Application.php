<?php

namespace App\Kernel;

/**
 * Class Application
 * @package App\Kernel
 */
class Application
{
	use Singleton;

    /**
     * @var array
     */
    public static $config = array();

    /**
     * Application constructor.
     */
    function __construct()
    {
        static::$config = include __DIR__.'/../../config/app.php';
    }

    /**
     * @return mixed
     */
    public function run(){
        session_start();
        $route = Route::getInstance();
        return $route->call(Request::method(),Request::url());
    }
}