<?php
namespace App\Controllers;

use App\Kernel\Response;
use App\Kernel\Session;

/**
 * Class AuthedController
 * @package App\Controllers
 */
class AuthedController extends Controller
{
    /**
     * AuthedController constructor.
     */
    public function __construct(){
        if(Session::isGuest() == true){
            Response::redirect('/login');
        }
    }
}