<?php

namespace App\Kernel;

/**
 * Class Session
 * @package App\Kernel
 */
class Session
{
    /**
     * @param $key
     * @param $value
     * @return mixed
     */
    public static function set($key, $value){
        return $_SESSION[$key] = $value;
    }

    /**
     * @param $key
     * @return mixed
     */
    public static function get($key){
        return empty($_SESSION[$key]) ? null : $_SESSION[$key];
    }

    /**
     * @param $key
     * @return mixed
     */
    public static function delete($key){
        return $_SESSION[$key] = null;
    }

    /**
     * @param $user
     * @return mixed
     */
    public static function setUser($user){
        return static::set('user', $user);
    }

    /**
     * @return object
     */
    public static function getUser(){
        return static::get('user');
    }

    /**
     * @return mixed
     */
    public static function getUserId(){
        return static::get('user')['id'];
    }

    /**
     * @return bool
     */
    public static function deleteUser(){
        return static::delete('user');
    }

    /**
     * @return bool
     */
    public static function isGuest(){
        return empty($_SESSION['user']);
    }
}