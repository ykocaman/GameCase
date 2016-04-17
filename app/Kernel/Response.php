<?php

namespace App\Kernel;

define('VIEW_DIR', __DIR__ . '/../../views/');

class Response
{

    public static function view($name){
        return include VIEW_DIR.$name.'.php';
    }

    public static function error($no=404){
        return include VIEW_DIR.'error/'.$no.'.php';
    }

}