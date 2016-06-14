<?php

namespace App\Kernel;


/**
 * Class Request
 * @package App\Kernel
 */
class Request
{
    /**
     * @param $key
     * @param bool $default
     * @return mixed
     */
    public static function get($key, $default=false){
        return static::getParameter($_GET, $key, $default);
    }

    /**
     * @param $key
     * @param bool $default
     * @return mixed
     */
    public static function post($key, $default=false){
        return static::getParameter($_POST, $key, $default);
    }

    /**
     * @param $key
     * @return mixed
     */
    public static function cookie($key){
        return static::getParameter($_COOKIE, $key, false);
    }

    /**
     * @param $key
     * @param bool $default
     * @return mixed
     */
    public static function server($key, $default=false){
        return static::getParameter($_SERVER, $key, $default);
    }

    /**
     * @param $type
     * @param $key
     * @param $default
     * @return mixed
     */
    private static function getParameter($type, $key, $default){
        if($default === false) {
            return $type[$key];
        }
        else {
            return empty ($type[$key]) ? $default : $type[$key];
        }
    }

    /**
     * @return mixed
     */
    public static function uri(){
        return static::server('REQUEST_URI');
    }

    /**
     * @return string
     */
    public static function url(){
        return strtok(static::uri(),'?');
    }

    /**
     * @return mixed
     */
    public static function method(){
        return static::server('REQUEST_METHOD');
    }

    /**
     * @return mixed
     */
    public static function remoteIP(){
        return static::server('HTTP_X_FORWARDED_FOR',static::server('REMOTE_ADDR'));
    }


}