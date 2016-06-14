<?php

namespace App\Models;

use App\Kernel\Session;

/**
 * Class GiftSent
 * @package App\Models
 */
class GiftSent extends Model
{
    /**
     * @var string
     */
    public $table = 'gifts_sent';

    /**
     * @param $sender_id
     * @param $gift_id
     * @return int
     */
    public function countByUserId($sender_id, $gift_id){
        $condition = 'sender_id = :sender_id and gift_id = :gift_id and DATE(date) = CURDATE()';

        $result = $this->query($condition,compact('sender_id','gift_id'),'count(id) as count');

        if(empty($result['0']['count'])){
        	return 0;
        }

        return intval($result['0']['count']);
    }

    /**
     * @param $to_id
     * @return array
     */
    public function toUser($to_id){
        $condition  = 'to_id = :to_id and gifts_sent.status = \'active\' group by gift_id';

        return $this->query($condition,compact('to_id'),
        					'count(gifts_sent.id) as count, g.id, g.name',
        					'left join gifts g on g.id = gifts_sent.gift_id');
    }

}