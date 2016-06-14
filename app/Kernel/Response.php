<?php

namespace App\Kernel;

/**
 *  view directory
 */
define('VIEW_DIR', __DIR__ . '/../../views/');

/**
 * Class Response
 * @package App\Kernel
 */
class Response
{

    /**
     * @param $name
     * @param $variables
     * @return mixed|string
     */
    public static function view($name, $variables){

        foreach ($variables as $key => $value) {
            global $$key;
            $$key = $value;
        }

        $includes  = include VIEW_DIR.'header.php';       
        $includes .= include VIEW_DIR.$name.'.php';        
        $includes .= include VIEW_DIR.'footer.php';
        
        foreach ($variables as $key => $value) {
            unset($$key);
        }

        return $includes;
    }

    /**
     * @param $name
     * @return mixed
     */
    public static function layout($name){
        return include VIEW_DIR.$name.'.php';
    }

    /**
     * @param $variable
     * @return bool
     */
    public static function json($variable){
        header('Content-type: application/json');
        echo json_encode($variable);
        return true;
    }

    /**
     * @param int $no
     * @return mixed
     */
    public static function error($no=404){
        return include VIEW_DIR.'error/'.$no.'.php';
    }

    /**
     * @param $url
     */
    public static function redirect($url){
        header('Location: '. $url);
        die;
    }
}