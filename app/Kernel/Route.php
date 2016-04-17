<?php

namespace App\Kernel;

use App\Kernel\Kernel;

class Route
{
    use Singleton;
    
    private $list = array();
    
    private function addRoute($method,$url,$function){
        $this->list[$method][$url] = $function;
    }

    public function get($path,$function){
        static::addRoute('GET',$path,$function);
    }

    public function post($path,$function){
        static::addRoute('POST',$path,$function);
    }

    public function call($method,$url){
        $controller = $this->list[$method][$url];
        if(empty($controller)){
            return Response::error();
        }

        try{
            $exploded   = explode('@',$this->list[$method][$url]);
            $class      = 'App\\Controllers\\'.$exploded[0];
            $function   = $exploded[1];
            return call_user_func(array($class,$function));
        }catch (\Exception $e){
            throw $e;
        }
    }

    public function all(){
        return $this->list;
    }
}