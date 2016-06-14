<?php

namespace App\Models;

use App\Kernel\Database;

/**
 * Class Model
 * @package App\Models
 */
abstract class Model
{
    /**
     * @var db instance
     */
    private $db;
    /**
     * @var string
     */
    public $table;

    /**
     * Model constructor.
     */
    function __construct()
    {
        $this->db = Database::getInstance();
    }

    /**
     * @param $result
     * @return null
     */
    private function fetch($result){
        while ($row = $result->fetch(\PDO::FETCH_ASSOC)) {
            return $row;
        }
        return null;
    }

    /**
     * @param $result
     * @return array
     */
    private function fetchList($result){
        while ($row = $result->fetch(\PDO::FETCH_ASSOC)) {
            $array[] = $row;
        }
        return $array;
    }

    /**
     * @param null $limit
     * @return array
     */
    public function all($limit = null){
        $sql = 'select * from '.$this->table;
        if(is_null($limit) === false) {
            $sql .= ' limit '.$limit;
        }
        $result = $this->db->query($sql);
        return $this->fetchList($result);
    }

    /**
     * @param $id
     * @return null
     */
    public function find($id){
        $sql= 'select * from '.$this->table.' where id = :id limit 1';
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':id',$id);
        $stmt->execute();
        return $this->fetch($stmt);
    }

    /**
     * @param $condition
     * @param $parameters
     * @param string $selection
     * @param string $join
     * @return array
     */
    public function query($condition, $parameters, $selection = '*', $join=''){
        $sql = 'select '.$selection.' from '.$this->table.' '.$join.' where '.$condition;
        $stmt = $this->db->prepare($sql);
        foreach ($parameters as $key => $value) {
            $stmt->bindParam(':'.$key, ($value));
        } 
        $stmt->execute();
        return $this->fetchList($stmt);
    }

    /**
     * @param $sql
     * @return mixed
     */
    public function statement($sql){
        $stmt = $this->db->prepare($sql);
        return $stmt->execute();
    }

    /**
     * @param $array
     * @return mixed
     */
    public function insert($array){
        $keys = array_keys($array);
        $sqlColumn = implode(', ',$keys);

        array_walk($keys,function(&$key){ $key = ':'.$key; });
        $sqlValue = implode(', ',$keys);

        $sql= 'insert into '.$this->table.' ('.$sqlColumn.') values ('.$sqlValue.')';
        $stmt = $this->db->prepare($sql);

        return  $stmt->execute($array);
    }

    /**
     * @param $id
     * @param $array
     * @return mixed
     */
    public function update($id, $array){
        $keys = array_keys($array);
        array_walk($keys,function(&$key){ $key = $key.' = :'.$key; });
        $sqlColumn = implode(', ',$keys);

        $sql= 'update '.$this->table.' set '.$sqlColumn.' where id = :id limit 1';
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':id',$id);
        foreach ($array as $key => $value) {
            $stmt->bindParam(':'.$key,$value);
        }

        return $stmt->execute();
    }
}