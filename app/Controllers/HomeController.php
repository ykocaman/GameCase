<?php

namespace App\Controllers;

use App\Kernel\Auth;
use App\Kernel\Response;
use App\Kernel\Session;

use App\Models\User;
use App\Models\Gift;
use App\Models\GiftSent;
use App\Models\GiftClaimed;

/**
 * Class HomeController
 * @package App\Controllers
 */
class HomeController extends AuthedController
{
    /**
     * @return mixed|string
     */
    public function index(){
    	$user = new User();

    	$data['people']        = $user->all();
    	$data['user']          = Session::getUser();

    	$gift                  = new Gift();
    	$data['gifts']         = $gift->all();

    	$gift_sent             = new GiftSent();
    	$data['gifts_sent']    = $gift_sent->toUser(Session::getUserId());

        $gift_claimed          = new GiftClaimed();
        $gift_claimed->setAllAsSeen(Session::getUserId());
        $data['gifts_claimed'] = $gift_claimed->fromUser(Session::getUserId());

        return Response::view('home',$data);
    }

}