<?php
/**
 * PHP Coding Case
 *
 * @package  GameCase
 * @author   Yusuf Kocaman <yusuf.kocaman@msn.com>
 */

require_once  __DIR__ . '/../vendor/autoload.php';

Use App\Kernel\Application;
use App\Kernel\Response;

$app = Application::getInstance();

try {
	$app->run();
} catch (\Exception $e) {
	if(config('env') == 'production'){
		return Response::error(500);
	}else{
		echo '<pre>'.$e.'</pre>';
	}
}
