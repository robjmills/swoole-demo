<?php
$server = new \Swoole\Client("0.0.0.0", 9502);
$server->send("Some data");
