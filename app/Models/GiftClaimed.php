<?php

namespace App\Models;

use App\Kernel\Session;

/**
 * Class GiftClaimed
 * @package App\Models
 */
class GiftClaimed extends Model
{
    /**
     * @var string
     */
    public $table = 'gifts_claimed';

    /**
     * @param $claimer_id
     * @param $gift_id
     * @return int
     */
    public function countByUserId($claimer_id, $gift_id){
        $condition = 'claimer_id = :claimer_id and gift_id = :gift_id and DATE(date) = CURDATE()';

        $result = $this->query($condition,compact('claimer_id','gift_id'),'count(id) as count');

        if(empty($result['0']['count'])){
        	return 0;
        }

        return intval($result['0']['count']);
    }

    /**
     * @param $from_id
     * @return array
     */
    public function fromUser($from_id){
        $condition  = 'from_id = :from_id order by gifts_claimed.date desc';

        return $this->query($condition,compact('from_id'),
        	'gifts_claimed.id, u.name as claimer_name, g.name as gift_name, gifts_claimed.status',
        	'left join users u on u.id = gifts_claimed.claimer_id '.
        	'left join gifts g on g.id = gifts_claimed.gift_id');
    }

    /**
     * @param $from_id
     * @return mixed
     */
    public function setAllAsSeen($from_id){
    	return $this->statement('update '.$this->table.' set status = "seen" where status = "sent" and from_id = '.$from_id.' order by id desc limit 10');
    }
}