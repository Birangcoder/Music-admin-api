<?php
require_once __DIR__.'/../app/bootstrap.php';
header('Location: '.(logged_in()?'dashboard.php':'login.php')); exit;
