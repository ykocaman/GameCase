<?php

namespace App\Kernel;


class Request
{
    function __construct()
    {

    }

    public static function get($key,$default=false){
        return static::getParameter($_GET, $key, $default);
    }

    public static function post($key,$default=false){
        return static::getParameter($_POST, $key, $default);
    }

    public static function cookie($key){
        return static::getParameter($_COOKIE, $key, false);
    }

    public static function server($key, $default=false){
        return static::getParameter($_SERVER, $key, $default);
    }

    private static function getParameter($type, $key, $default){
        if($default === false) {
            return $type[$key];
        }
        else {
            return empty ($type[$key]) ? $default : $type[$key];
        }
    }

    public static function url(){
        return static::server('REQUEST_URI');
    }
    
    public static function method(){
        return static::server('REQUEST_METHOD');
    }
    
    public static function remoteIP(){
        return static::server('HTTP_X_FORWARDED_FOR',static::server('REMOTE_ADDR'));
    }


}