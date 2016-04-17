<?php
namespace App\Kernel;

use \PDO as PDO;

class Database
{
    use Singleton;

    private $config = array();
    private $connection;

    protected function __construct() {
        $this->config       = include __DIR__.'/../../config/database.php';
        $this->connection   = new PDO('mysql:host='.$this->config['host'].';dbname='.$this->config['dbname'].';charset=utf8',
                                $this->config['username'], $this->config['password']);
        $this->connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        //$this->connection->setAttribute(PDO::MYSQL_ATTR_INIT_COMMAND,  'SET NAMES utf8');
    }

    public function query($sql){
        return $this->connection->query($sql);
    }

    public function prepare($sql){
        return $this->connection->prepare($sql);
    }

    function __destruct()
    {
        unset ($this->connection);
    }

}