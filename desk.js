const SB='https://wnfmouleaanhloyoodvb.supabase.co',PK='sb_publishable_8GrLQ5xir0tU59nfcxPK8w_79HOrhOg',SURYA='surya@dugasta.co';
async function rpc(fn,body){const r=await fetch(SB+'/rest/v1/rpc/'+fn,{method:'POST',headers:{apikey:PK,Authorization:'Bearer '+PK,'Content-Type':'application/json'},body:JSON.stringify(body)});if(!r.ok)throw new Error(r.status);return r.json();}
function localTickets(){try{return JSON.parse(localStorage.lsqDesk||'{}')}catch(e){return{}}}
function saveLocal(t){const a=localTickets();a[t.code]=t;localStorage.lsqDesk=JSON.stringify(a);}
async function createTicket(p){
  try{const r=await rpc('lsq_ticket_create',{p});return{...r,mode:'db'};}
  catch(e){const d=new Date(),code='LSQ-'+String(d.getFullYear()).slice(2)+String(d.getMonth()+1).padStart(2,'0')+String(d.getDate()).padStart(2,'0')+'-'+Math.random().toString(36).slice(2,6).toUpperCase();
    const t={code,status:'Open',created_at:d.toISOString(),...p,mode:'local'};saveLocal(t);return t;}
}
async function getTicket(code){
  code=code.trim().toUpperCase();
  try{const r=await rpc('lsq_ticket_status',{p_code:code});if(r)return{...r,mode:'db'};}catch(e){}
  try{const j=await (await fetch('./tickets.json',{cache:'no-store'})).json();if(j[code])return{...j[code],mode:'mirror'};}catch(e){}
  const l=localTickets()[code];return l?{...l,mode:'local'}:null;
}
function esc(s){return String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));}
