<?php

function config($key){
    return \App\Kernel\Application::$config[$key];
}