<?php

use App\Kernel\Route;

$route = Route::getInstance();

$route->get('/','HomeController@index');

$route->get('/test','HomeController@test');