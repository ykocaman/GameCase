<?php
/**
 * PHP Coding Case
 *
 * @package  GameCase
 * @author   Yusuf Kocaman <yusuf.kocaman@msn.com>
 */

require_once  __DIR__ . '/../vendor/autoload.php';

Use App\Kernel\Application;

$app = new Application();
$app->run();