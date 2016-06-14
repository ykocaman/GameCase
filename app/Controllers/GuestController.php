<?php

namespace App\Controllers;

use App\Kernel\Response;
use App\Kernel\Request;
use App\Kernel\Session;
use App\Models\User;

/**
 * Class GuestController
 * @package App\Controllers
 */
class GuestController extends Controller
{

	/**
	 * @return mixed|string
     */
	public function getLogin(){
    	$user = new User();
    	$data['users'] = $user->all();
        return Response::view('login',$data);
    }


	/**
	 * @return void
	 */
	public function postLogin(){
    	$users = new User();
    	$user = $users->find(Request::post('user'));
 		Session::setUser($user);
		Response::redirect('/');
    }


	/**
	 * @return void
	 */
	public function logout(){
 		Session::deleteUser();
		Response::redirect('/');
    }
}