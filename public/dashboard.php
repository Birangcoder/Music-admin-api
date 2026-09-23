<?php
require_once __DIR__.'/../app/bootstrap.php'; require_login();
?>
<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Dashboard — Music Admin</title><link rel="stylesheet" href="assets/app.css"></head><body>
<?php include __DIR__.'/partials/sidebar.php'; ?>
<main class="main"><header class="topbar"><div><h1>Dashboard</h1><p class="muted">Music catalog overview</p></div><a class="btn ghost" href="logout.php">Logout</a></header>
<div id="toast"></div>
<section class="stats" id="stats"><div class="loading">Loading dashboard…</div></section>
<section class="panel"><div class="panel-head"><div><h2>Recent songs</h2><p class="muted">Latest 10 songs from the API</p></div><a class="btn ghost" href="songs.php">Manage songs</a></div>
<div class="table-wrap"><table><thead><tr><th>Song</th><th>Language</th><th>Release</th><th>Created</th></tr></thead><tbody id="recent"></tbody></table></div></section>
</main><script src="assets/app.js"></script><script>
(async()=>{try{const r=await api('/dashboard'); if(!r.success)throw Error(r.message); const c=r.data.counts||{}; document.querySelector('#stats').innerHTML=['songs','albums','artists','genres','languages'].map(k=>card(k,c[k]??0)).join(''); document.querySelector('#recent').innerHTML=(r.data.recent_songs||[]).map(s=>`<tr><td><b>${esc(s.title)}</b></td><td>${esc(s.language||'—')}</td><td>${esc(s.release_date||'—')}</td><td>${esc(s.created_at||'—')}</td></tr>`).join('')||emptyRow(4,'No songs found');}catch(e){document.querySelector('#stats').innerHTML='<div class="alert danger">'+esc(e.message)+'</div>';}})();
function card(k,v){return `<div class="stat"><div class="stat-icon">${k[0].toUpperCase()}</div><div><span>${k[0].toUpperCase()+k.slice(1)}</span><strong>${Number(v).toLocaleString()}</strong></div></div>`}
</script></body></html>
