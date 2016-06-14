<?php

namespace App\Controllers;

use App\Kernel\Response;
use App\Kernel\Request;
use App\Kernel\Session;
use App\Models\Gift;
use App\Models\GiftSent;
use App\Models\GiftClaimed;


/**
 * Class GiftController
 * @package App\Controllers
 */
class GiftController extends Controller
{

    /**
     * @param $gift_id
     * @param $to_id
     * @return bool
     */
    public function sendGift($gift_id, $to_id){

        $gift = new Gift();
        $gift_type = $gift->find($gift_id);
      
        $gift_sent = new GiftSent();
        $gift_result = $gift_sent->countByUserId(Session::getUserId(),$gift_id);

        if(is_null($gift_type['send_daily_max']) || $gift_result < $gift_type['send_daily_max']){
   
            $gift_sent->insert(array(
                                    'sender_id' => Session::getUserId(),
                                    'to_id'     => $to_id,
                                    'gift_id'   => $gift_id,
                                    'date'      => date('Y-m-d H:i:s'),
                                    'status'    => 'active'
                                ));
            return true;
        }else{
            return false;
        }
    }


    /**
     * @return object
     */
    public function send(){
        if($this->sendGift(Request::post('gift'),Request::post('to')) == true){
        	$result = 'Hediye gönderildi';
        }else{
        	$result = 'Günlük limitiniz doldu';
        }

        return Response::json(compact('result'));
    }

    /**
     * @return object
     */
    public function claim(){
        $gift = new Gift();
        $gift_type = $gift->find(Request::post('gift')); 

        $gift_claimed = new GiftClaimed();
        $gift_result = $gift_claimed->countByUserId(Session::getUserId(),Request::post('gift'));

        if(is_null($gift_type['claim_daily_max']) || $gift_result < $gift_type['claim_daily_max']){
            $gift_claimed->insert(array(
                                    'claimer_id'    => Session::getUserId(),
                                    'from_id'       => Request::post('from'),
                                    'gift_id'       => Request::post('gift'),
                                    'date'          => date('Y-m-d H:i:s'),
                                    'status'        => 'sent'
                                ));
            $result = 'İstek gönderildi';
        }else{
            $result = 'Günlük limitiniz doldu';
        }

        return Response::json(compact('result'));
    }


    /**
     * @return object
     */
    public function accept(){
        $gifts_claimed   = new GiftClaimed();
        $gift_claimed    = $gifts_claimed->find(Request::post('gift_claimed'));

        if($gift_claimed['status'] == 'seen'){

            if($this->sendGift($gift_claimed['gift_id'],$gift_claimed['claimer_id']) == true){         
                $gifts_claimed->update($gift_claimed['id'],array('status' => 'accepted'));

                $result = 'accepted';
            }else{
                $result = 'seen';
            }

        }else{
            $result = $gift_claimed['status'];
        }

        return Response::json(compact('result'));
    }

    /**
     * @return object
     */
    public function reject(){
        $gifts_claimed   = new GiftClaimed();
        $gift_claimed    = $gifts_claimed->find(Request::post('gift_claimed'));

        if($gift_claimed['status'] == 'seen'){
            $gifts_claimed->update($gift_claimed['id'],array('status' => 'rejected'));
            $result = 'rejected';
        }else{
            $result = $gift_claimed['status'];
        }

       return Response::json(compact('result'));
    }
}