<?php
require_once __DIR__.'/../app/bootstrap.php';
if(logged_in()){header('Location: dashboard.php');exit;}
$error='';
if($_SERVER['REQUEST_METHOD']==='POST'){
    $r=api_request('POST','/auth/login',[
        'username'=>trim($_POST['username']??''),
        'password'=>$_POST['password']??''
    ]);
    $token=$r['data']['token']??$r['token']??null;
    if(($r['success']??false) && $token){
        $_SESSION['api_token']=$token;
        $_SESSION['admin_username']=trim($_POST['username']??'');
        header('Location: dashboard.php');exit;
    }
    $error=$r['message']??'Invalid credentials.';
}
?>
<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Music Admin — Login</title><link rel="stylesheet" href="assets/app.css"></head>
<body class="login">
<div class="login-box">
<div class="logo"><span>♪</span><div><strong>Music Admin</strong><small>MusicAPI-v2 control panel</small></div></div>
<h1>Sign in</h1><p class="muted">Use the admin credentials configured in MusicAdminAPI.</p>
<?php if($error):?><div class="alert danger"><?=h($error)?></div><?php endif;?>
<form method="post">
<label>Username<input name="username" autocomplete="username" required></label>
<label>Password<input type="password" name="password" autocomplete="current-password" required></label>
<button class="btn primary full">Sign in</button>
</form>
</div></body></html>
