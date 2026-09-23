async function api(path,method='GET',body=null){let o={method,headers:{'Content-Type':'application/json','Accept':'application/json'}};if(body!==null)o.body=JSON.stringify(body);let r=await fetch('api.php?path='+encodeURIComponent(path),o);let j=await r.json().catch(()=>({success:false,message:'Invalid response'}));if(r.status===401){location.href='login.php';throw Error(j.message||'Session expired');}return j}
function esc(v){return String(v??'').replace(/[&<>"']/g,m=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#039;'}[m]))}
function fmt(sec){sec=Number(sec||0);return Math.floor(sec/60)+':'+String(sec%60).padStart(2,'0')}
function emptyRow(n,msg){return `<tr><td colspan="${n}" class="empty">${esc(msg)}</td></tr>`}
function toast(msg,type='success'){let t=document.querySelector('#toast');if(!t)return; t.innerHTML=`<div class="toast ${type}">${esc(msg)}</div>`;setTimeout(()=>t.innerHTML='',3500)}
function closeModal(){document.querySelectorAll('.modal').forEach(x=>x.classList.remove('show'))}
document.addEventListener('click',e=>{if(e.target.classList.contains('modal'))e.target.classList.remove('show')})
