<?php
namespace App\Kernel;

use \PDO as PDO;

/**
 * Class Database
 * @package App\Kernel
 */
class Database
{
    use Singleton;

    /**
     * @var array|mixed
     */
    private $config = array();
    /**
     * @var PDO
     */
    private $connection;

    /**
     * Database constructor.
     */
    protected function __construct() {
        $this->config       = include __DIR__.'/../../config/database.php';
        $this->connection   = new PDO('mysql:host='.$this->config['host'].';dbname='.$this->config['dbname'].';charset=utf8',
                                $this->config['username'], $this->config['password']);
        $this->connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }

    /**
     * @param $sql
     * @return \PDOStatement
     */
    public function query($sql){
        return $this->connection->query($sql);
    }

    /**
     * @param $sql
     * @return \PDOStatement
     */
    public function prepare($sql){
        return $this->connection->prepare($sql);
    }

    /**
     * destruct
     */
    function __destruct()
    {
        unset ($this->connection);
    }

}