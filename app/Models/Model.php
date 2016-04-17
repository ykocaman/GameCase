<?php

namespace App\Models;

use App\Kernel\Database;

abstract class Model
{
    private $db;
    public $table;

    function __construct()
    {
        $this->db = Database::getInstance();
    }

    private function fetch($result){
        while ($row = $result->fetch(\PDO::FETCH_ASSOC)) {
            return $row;
        }
        return null;
    }

    private function fetchList($result){
        while ($row = $result->fetch(\PDO::FETCH_ASSOC)) {
            $array[] = $row;
        }
        return $array;
    }

    public function all($limit = null){
        $sql = 'select * from '.$this->table;
        if(is_null($limit) === false) {
            $sql .= ' limit '.$limit;
        }
        $result = $this->db->query($sql);
        return $this->fetchList($result);
    }

    public function find($id){
        $sql= 'select * from '.$this->table.' where id = :id limit 1';
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':id',$id);
        $stmt->execute();
        return $this->fetch($stmt);
    }

    public function insert($array){
        $keys = array_keys($array);
        $sqlColumn = implode(', ',$keys);

        array_walk($keys,function(&$key){ $key = ':'.$key; });
        $sqlValue = implode(', ',$keys);

        $sql= 'insert into '.$this->table.' ('.$sqlColumn.') values ('.$sqlValue.')';
        $stmt = $this->db->prepare($sql);

        return  $stmt->execute($array);
    }

    public function update($id,$array){
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