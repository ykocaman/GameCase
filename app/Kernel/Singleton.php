<?php

namespace App\Kernel;


/**
 * Class Singleton
 * @package App\Kernel
 */
trait Singleton
{

    /**
     * @var object
     */
    private static $instance;

    /**
     * @return mixed
     */
    public static function getInstance()
    {
        if (null === static::$instance) {
            static::$instance = new static();
        }

        return static::$instance;
    }


    /**
     * Singleton constructor.
     */
    protected function __construct()
    {
    }

    /**
     * block cloning object
     */
    protected function __clone()
    {
    }

    /**
     * block cloning object
     */
    protected function __wakeup()
    {
    }
}
