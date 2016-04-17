<?php

namespace App\Controllers;

use App\Kernel\Response;
use App\Models\User;

class HomeController extends Controller
{
    public function index(){
        //$user = new User();
        //var_dump($user->insert(array('name' => 'test','nickname' => 'testci','password' => 'asdasd')));
        //var_dump($user->find(1));

        return Response::view('index');
    }

    public function test(){

        return Response::view('index');
    }
}