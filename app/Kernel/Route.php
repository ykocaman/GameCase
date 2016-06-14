<?php

namespace App\Kernel;

use App\Kernel\Kernel;

/**
 * Class Route
 * @package App\Kernel
 */
class Route
{
    use Singleton;

    /**
     * @var array
     */
    private $list = array();

    /**
     * @param $method
     * @param $url
     * @param $function
     */
    private function addRoute($method, $url, $function){
        $this->list[$method][$url] = $function;
    }

    /**
     * @param $path
     * @param $function
     */
    public function get($path, $function){
        static::addRoute('GET',$path,$function);
    }

    /**
     * @param $path
     * @param $function
     */
    public function post($path, $function){
        static::addRoute('POST',$path,$function);
    }

    /**
     * @param $method
     * @param $url
     * @return mixed
     * @throws \Exception
     */
    public function call($method, $url){
        $controller = $this->list[$method][$url];
        if(empty($controller)){
            return Response::error();
        }

        try{
            $exploded   = explode('@',$this->list[$method][$url]);
            $class      = 'App\\Controllers\\'.$exploded[0];
            $function   = $exploded[1];
            $controller = new $class;
            return $controller->$function();
           // return call_user_func(array($class,$function));
        }catch (\Exception $e){
            throw $e;
        }
    }

    /**
     * @return array
     */
    public function all(){
        return $this->list;
    }
}