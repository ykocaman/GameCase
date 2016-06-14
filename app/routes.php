<?php

use App\Kernel\Route;

$route = Route::getInstance();

$route->get     ('/',       'HomeController@index');

$route->get 	('/login',	'GuestController@getLogin');
$route->post 	('/login',	'GuestController@postLogin');
$route->get 	('/logout',	'GuestController@logout');

$route->post 	('/claim',	'GiftController@claim');
$route->post 	('/send',	'GiftController@send');
$route->post 	('/accept',	'GiftController@accept');
$route->post 	('/reject',	'GiftController@reject');