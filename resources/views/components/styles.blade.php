<style>
:root{
--bg:#f9fafb;
--card:#ffffff;
--text:#0f172a;
--muted:#64748b;
--border:#e5e7eb;
--green:#22c55e;
--red:#ef4444;
--brand1:#6366f1; /* indigo */
--brand2:#9333ea; /* purple */
--chart-fill:linear-gradient(180deg,rgba(99,102,241,.25),rgba(147,51,234,.05));
}

body.dark{
--bg:#05070c;
--card:#0b0f19;
--text:#f8fafc;
--muted:#9ca3af;
--border:#1f2933;
--chart-fill:linear-gradient(180deg,rgba(34,197,94,.35),rgba(0,0,0,.05));
}

body{
background:var(--bg);
 top:0 !important;
color:var(--text);
font-family:Inter,Segoe UI,sans-serif; 
    transition: 0.3s ease;
}

.dashboard-card {
    background: #1e293b;
    color: #e2e8f0;
    border: 1px solid #1e293b;
}
.dark-table {
    color: #cbd5e1;
}

.dark-table td {
    background: transparent !important;
    border-color: #334155 !important;
}

.dark-table tr:hover td {
    background: #1f2937 !important;
}
.navbar{ 
    position: relative;
    z-index: 2000 !important;  
background:var(--card);
border-bottom:1px solid var(--border);
}

.navbar-brand{
background:linear-gradient(45deg,var(--brand1),var(--brand2));
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;
font-weight:800;
} 
/* Active Navbar Item */
.nav-link.active-nav {
    color: #6f42c1 !important;
    font-weight: 700;
    position: relative;
}

/* Underline effect */
.nav-link.active-nav::after {
    content: "";
    position: absolute;
    left: 0;
    bottom: -6px;
    width: 100%;
    height: 2px;
    background: #6f42c1;
}

/* Gradient Button Same as Brand */
.btn-brand{
    background:linear-gradient(45deg,#6366f1,#9333ea);
    color:#fff;
    border:none;
    border-radius:8px;
    transition:all .3s ease;
}

.btn-brand:hover{
    opacity:.9;
    transform:translateY(-2px);
    box-shadow:0 6px 18px rgba(99,102,241,.3);
}

/* Dropdown polish */
.dropdown-menu{
    border-radius:12px;
    border:1px solid #e5e7eb; 
    z-index: 2100 !important;  /* always above chart */
}

.dropdown-item:hover{
    background:#f3f4f6;
}

.card{
background:var(--card);
border-radius:20px;
border:1px solid var(--border);
box-shadow:0 0 0 rgba(0,0,0,0);
}

body.dark .card{
background:radial-gradient(circle at top,#0f172a,#05070c);
border:1px solid #111827;
box-shadow:0 0 40px rgba(34,197,94,.08);
}

.text-muted{color:var(--muted)!important}

.badge-green{
background:rgba(34,197,94,.15);
color:#22c55e;
}

.index-item{
display:flex;
justify-content:space-between;
padding:14px 0;
border-bottom:1px solid var(--border)
}

.index-item:last-child{border:none}

.trend-up{color:var(--green)}
.trend-down{color:var(--red)}

.trend-card{
border-radius:18px;
padding:18px;
background:var(--card);
}

body.dark .trend-card{
background:linear-gradient(180deg,#0f172a,#020617);
border:1px solid #111827;
}

.theme-btn{
border:none;
background:#6f42c1;
border-radius:50%;
width:38px;height:38px;
display:flex;align-items:center;justify-content:center;
}

body.dark .theme-btn{
background:#020617;
color:#fff;
border:1px solid #1f2933;
}


/* ================= DARK MODE TEXT FIX ================= */

body.dark{
  color:#ffffff !important;
}

/* Main headings */
body.dark h1,
body.dark h2,
body.dark h3,
body.dark h4,
body.dark h5,
body.dark h6,
body.dark strong{
  color:#ffffff !important;
}

/* Normal text */
body.dark p,
body.dark span,
body.dark div{
  color:#e5e7eb;
}

/* Secondary / muted text */
body.dark .text-muted,
body.dark small{
  color:#cfd3da !important;
}

/* Navbar + links */
/* NAVBAR DARK */
body.dark .navbar{
  background:#0b0f19;
  border-color:#1f2933;
}

body.dark .nav-link{
  color:#e5e7eb !important;
}

body.dark .nav-link:hover{
  color:#ffffff !important;
}

/* DROPDOWN DARK */
body.dark .dropdown-menu{
  background:#0f172a;
  border:1px solid #1f2933;
}

body.dark .dropdown-item{
  color:#e5e7eb;
}

body.dark .dropdown-item:hover{
  background:#1e293b;
  color:#ffffff;
}

/* Inputs */
body.dark input{
  background:#020617;
  color:#ffffff;
  border:1px solid #1f2933;
}

/* Card content */
body.dark .card *{
  color:#e5e7eb;
}

/* Prices / Main numbers */
body.dark h2,
body.dark h3{
  color:#ffffff !important;
}

/* Green / Red keep visible */
body.dark .trend-up,
body.dark .text-success{
  color:#22c55e !important;
}

body.dark .trend-down,
body.dark .text-danger{
  color:#ef4444 !important;
}
/* ================= THEME BASED TABLE ================= */

.table {
    background: var(--card);
    color: var(--text);
    border-color: var(--border);
}

.table thead {
    background: var(--card);
    color: var(--text);
}

.table th,
.table td {
    background: var(--card);
    color: var(--text);
    border-color: var(--border);
}

.table-hover tbody tr:hover {
    background: rgba(99,102,241,0.06); /* subtle indigo hover */
}
 
/* SIDEBAR */
 
/* Links */
/* ========== SIDEBAR BASE ========== */
/* Sidebar Base */
.sidebar {
    position: fixed;
    top: 0;
    left: 0;
    width: 260px;
    height: 100vh;
    background: #ffffff;
    padding: 20px 15px;
    overflow-y: auto;
    transform: translateX(-100%);
    transition: transform 0.3s ease;
    z-index: 1050 !important;
    box-shadow: 2px 0 10px rgba(0,0,0,0.05);
}

/* Show Sidebar */
.sidebar.active {
    transform: translateX(0);
}

/* Header */
.sidebar-header {
    margin-bottom: 15px;
}

/* Close Button */
.sidebar-close {
    border: none;
    background: transparent;
    font-size: 16px;
    cursor: pointer;
    color: #555;
}

.sidebar-close:hover {
    color: #000;
}

/* Links */
.sidebar-link,
.sidebar-category {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 8px 10px;
    font-size: 14px;
    color: #000000; 
    text-decoration: none;
    border-radius: 6px;
    cursor: pointer;
    transition: 0.2s;
}

.sidebar-link:hover,
.sidebar-category:hover {
    background: #f1f5f9;
}

/* Subcategories */
.sidebar-sub-wrapper {
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.3s ease;
}

.sidebar-sub {
    display: block;
    padding: 6px 18px;
    font-size: 13px;
    color: #555;
    text-decoration: none;
    border-radius: 6px;
}

.sidebar-sub:hover {
    background: #f1f5f9;
}

/* Arrow */
.arrow {
    font-size: 12px;
    transition: transform 0.3s;
}

.rotate {
    transform: rotate(180deg);
}

/* Overlay */
.sidebar.active{
    left:0;
}

.sidebar-overlay{
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:100%;
    background:rgba(0,0,0,0.4);
    display:none;
    z-index:999;
}

 

/* Sidebar */
.sidebar{
    z-index:999;
}

/* Toggle Button Above Overlay */
#sidebarToggle{
    position: relative;
    z-index:1001;
}
/* STOCK DASHBOARD TABS */

#stockTabs .nav-link {
    color: #6f42c1;              /* Purple text */
    font-weight: 600;            /* Slightly bold */
    background: transparent;
    border-radius: 8px;
    padding: 8px 18px;
    transition: 0.2s ease;
}

/* Hover effect */
#stockTabs .nav-link:hover {
    background-color: rgba(111, 66, 193, 0.08);
}

/* Active tab */
#stockTabs .nav-link.active {
    background-color: #6f42c1;   /* Solid purple */
    color: #ffffff;
    font-weight: 700;
}
/* */

/* DARK MODE */
body.dark .sidebar{
background:#0b0f19;
border-color:#1f2933;
color:#fff;
}

body.dark .sidebar a{
color:#ffffff;
}
body.dark .sidebar-category{
color:#ffffff;
}
body.dark .sidebar a:hover{
color:#6f42c1;
}
.main-content{
transition:.3s;
}
/* ================= LOGIN BUTTON ================= */

/* Light Mode */
.login-btn {
    background-color: #6f42c1;
    color: #ffffff;
    border: 1px solid #6f42c1;
    transition: 0.3s;
}

.login-btn:hover {
    background-color: #5a32a3;
    border-color: #5a32a3;
    color: #ffffff;
}

/* Dark Mode */
body.dark .login-btn {
    background-color: #8b5cf6;
    border-color: #8b5cf6;
    color: #ffffff;
}

body.dark .login-btn:hover {
    background-color: #7c3aed;
    border-color: #7c3aed;
}

 
/* Dark mode */
body.dark .sidebar-link {
    color: #ffffff !important;
}

body.dark .sidebar-link:hover {
    color: #6f42c1 !important;
}

.trading-dashboard{
    display:flex;
    height:90vh;
    background:#0f172a;
    color:white;
}

.chart-section{
    flex:3;
}

.analysis-section{
    flex:1;
    padding:20px;
    background:#1e293b;
}
/* ================= MOBILE COMPATIBLE LAYOUT ================= */
@media (max-width: 1024px) {
    /* Sidebar collapses */
    .sidebar {
        width: 0;
        transform: translateX(-100%);
        position: fixed;
        z-index: 1050;
    }

    .sidebar.active {
        width: 260px;
        transform: translateX(0);
    }

    .sidebar-overlay {
        display: block;
    }

    /* Main content takes full width when sidebar is hidden */
    .main-content {
        margin-left: 0 !important;
        padding: 15px;
    }

    /* Cards stack vertically */
    .card,
    .dashboard-card,
    .trend-card {
        width: 100% !important;
        margin-bottom: 16px;
    }

    /* Charts resize automatically */
    canvas, svg {
        width: 100% !important;
        height: auto !important;
    }

    /* Tables full width */
    .table {
        display: block;
        width: 100%;
        overflow-x: auto;
    }

    /* Navbar brand smaller */
    .navbar-brand {
        font-size: 18px;
    }

    /* Buttons smaller for touch */
    .btn-brand {
        padding: 6px 14px;
        font-size: 13px;
    }

    /* Stock dashboard tabs stack */
    #stockTabs {
        flex-wrap: wrap;
    }

    #stockTabs .nav-link {
        margin-bottom: 6px;
        width: 48%; /* two tabs per row */
        text-align: center;
    }

    /* Trend items stack */
    .index-item {
        flex-direction: column;
        align-items: flex-start;
        padding: 12px 8px;
    }

    .index-item span {
        margin-top: 6px;
    }
}

/* Extra small screens (mobile portrait) */
@media (max-width: 768px) {
    .sidebar-link,
    .sidebar-category {
        font-size: 13px;
        padding: 6px 10px;
    }

    .sidebar-sub {
        padding: 5px 16px;
        font-size: 12px;
    }

    .theme-btn {
        width: 32px;
        height: 32px;
    }

    /* Charts full width */
    .chart-container {
        width: 100% !important;
    }

    /* Table cells smaller */
    .table th,
    .table td {
        font-size: 12px;
        padding: 5px 6px;
    }
}

/* Extra small: very small screens */
@media (max-width: 480px) {
    #stockTabs .nav-link {
        width: 100%;
        font-size: 12px;
        padding: 5px 10px;
    }

    .card,
    .dashboard-card,
    .trend-card {
        padding: 10px;
        margin-bottom: 12px;
    }

    .trend-card .chart-container {
        height: 200px; /* smaller chart height */
    }
}
footer a:hover {
    color: #6f42c1 !important;
}

footer h5 {
    color: #6f42c1;
}
/* =========================
   DARK FOOTER
========================= */

.footer-dark {
    background-color: #0f172a;
    color: #cbd5e1;
    border-top: 1px solid #1e293b;
}

/* Remove bootstrap muted gray */
.footer-dark .text-muted {
    color: #94a3b8 !important;
}

/* Headings */
.footer-dark h5,
.footer-dark h6 {
    color: #ffffff;
}

/* Links */
.footer-dark a {
    color: #94a3b8 !important;
    text-decoration: none;
    transition: 0.2s ease;
}

.footer-dark a:hover {
    color: #38bdf8 !important;
}

/* Brand color adjustment */
.footer-dark .text-primary {
    color: #38bdf8 !important;
}

/* Divider */
.footer-dark hr {
    border-color: #1e293b;
}
/* Pagination */
.pagination{
    justify-content:center;
    margin-top:25px;
}
.pagination .page-link {
    color:#6f42c1 !important;
    border-color:#e5e7eb;
}

.pagination .active .page-link {
    background:#6f42c1 !important;
    border-color:#6f42c1 !important;
    color:#fff !important;
}

.pagination .page-link:hover {
    background:#f3f0ff;
    color:#6f42c1 !important;
}
body.dark a{
    color:#ffffff;
}
/* Light Mode */
.short-desc-box {
    background-color: #f8f9fa;
    border-color: #6f42c1 !important;
}

/* Dark Mode */
body.dark .short-desc-box {
     background-color: #0f172a;
    color: #e0e0e0;
    border-color: #8a63d2 !important;
}
/* Dark mode pagination */
body.dark .page-link {
    background-color: #0f172a !important;
    color: #ffffff !important;
    border-color: #1e293b !important;
}

body.dark .page-item.active .page-link {
    background-color: #6f42c1 !important;
    border-color: #6f42c1 !important;
}
/*see in my news website i want a feature like i m fetching news about stocks of indian and world companies last 1 week news now list news and then give button analyse so that will show if that news has spiked any volume impact on stock and yes or no but what future imapct can be for example some company rate is higher to 15 lakh for like 15 min or sometime then what news impact that volume change and what can be future impacts*/
/* =========================
   Editor Sidebar - LIGHT (Default)
========================= */
/* =========================
   Editor Sidebar - Light Default
========================= */

.editor-sidebar {
    width: 260px;
    min-height: 100vh;
    background: #ffffff;
    color: #1f2937;
    border-right: 1px solid #e5e7eb;
    transition: width 0.3s ease;
    overflow: hidden;
}

.editor-sidebar a {
    color: #374151;
    text-decoration: none;
    padding: 12px 20px;
    display: flex;
    align-items: center;
    gap: 12px;
    white-space: nowrap;
    transition: 0.2s;
}

.editor-sidebar a i {
    font-size: 18px;
    min-width: 22px;
    text-align: center;
}

.editor-sidebar a:hover {
    background: #f3f4f6;
}

/* Sidebar Title */
.editor-sidebar .sidebar-title {
    padding: 16px 20px;
    font-weight: 600;
    border-bottom: 1px solid #e5e7eb;
    white-space: nowrap;
}

/* =========================
   COLLAPSED MODE
========================= */

.editor-sidebar.collapsed {
    width: 70px;
}

.editor-sidebar.collapsed a {
    justify-content: center;
    padding: 12px 0;
}

.editor-sidebar.collapsed a span {
    display: none;
}

.editor-sidebar.collapsed .sidebar-title {
    display: none;
}

/* =========================
   DARK MODE editor
========================= */

body.dark .editor-sidebar {
    background: #111827;
    color: #fff;
    border-right: 1px solid #1f2937;
}

body.dark .editor-sidebar a {
    color: #cbd5e1;
}

body.dark .editor-sidebar a:hover {
    background: #1f2937;
}
.card {
    border-radius: 12px;
}

.table th {
    font-weight: 600;
}

.btn-primary {
    background: #6f42c1;
    border: none;
}
.btn-outline-primary { 
    border-color: #6f42c1;
    color:#6f42c1;
}
.btn-outline-primary:hover { 
    background: #6f42c1;
    color:white;
}
.btn-primary:hover {
    background: #5a35a0;
}
#suggestionsBox {
    background: white;
    border: 1px solid #ddd;
}

/*calculator*/
/* Layout */
.calculator-page {
    padding: 40px 20px;
    max-width: 1200px;
    margin: auto;
}

.calculator-grid {
    display: grid;
    grid-template-columns: 260px 1fr;
    gap: 30px;
}

/* Sidebar */
.calculator-menu {
    background: #f3f4f6;
    padding: 20px;
    border-radius: 12px;
}

.calculator-menu a {
    display: block;
    padding: 10px;
    margin-bottom: 8px;
    text-decoration: none;
    color: #374151;
    border-radius: 8px;
    transition: 0.2s ease;
}

.calculator-menu a:hover,
.calculator-menu a.active {
    background: var(--brand);
    color: white;
}

/* Content */
.calculator-content {
    background: #ffffff;
    padding: 30px;
    border-radius: 12px;
    min-height: 400px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.05);
}

input {
    width: 100%;
    padding: 10px;
    margin-bottom: 12px;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
}

input:focus {
    border-color: var(--brand);
    outline: none;
}

button {
    padding: 10px 18px;
    background: var(--brand);
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
}

button:hover {
    background: var(--brand-dark);
}

.result-box {
    margin-top: 15px;
    padding: 12px;
    background: #f3f4f6;
    border-radius: 8px;
    font-weight: 600;
}

/* Dark Mode */
body.dark .calculator-menu { background: #1f2937; }
body.dark .calculator-menu a { color: #e5e7eb; }
body.dark .calculator-menu a:hover,
body.dark .calculator-menu a.active { background: var(--brand); }

body.dark .calculator-content {
    background: #111827;
    color: #e5e7eb;
}

body.dark input {
    background: #1f2937;
    border: 1px solid #374151;
    color: white;
}
:root {
    --brand: #6f42c1;
    --brand-dark: #5936a2;
}

body.dark .result-box { background: #1f2937; }

@media(max-width: 900px){
    .calculator-grid { grid-template-columns: 1fr; }
}
/*user*/
/* Modal size */
.interest-modal {
    border-radius: 15px;
    max-height: 85vh;
    overflow: hidden;
}

/* Scroll inside body */
.modal-body {
    max-height: 65vh;
    overflow-y: auto;
    padding-right: 10px;
}

/* Category column scroll */
.category-column {
    max-height: 60vh;
    overflow-y: auto;
    border-right: 1px solid #eee;
}

/* Subcategory column scroll */
.subcategory-column {
    max-height: 60vh;
    overflow-y: auto;
}

/* Option Styling */
.interest-option {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 8px 5px;
    cursor: pointer;
    border-radius: 8px;
    transition: 0.2s ease;
}

.interest-option:hover {
    background: #f4f6ff;
}

/* Hide default radio */
.interest-option input {
    display: none;
}

/* Custom radio circle */
.custom-radio {
    width: 18px;
    height: 18px;
    border: 2px solid #6f42c1;
    border-radius: 50%;
    position: relative;
}

.interest-option input:checked + .custom-radio {
    background: #6f42c1;
    box-shadow: 0 0 0 3px rgba(111,66,193,0.2);
}

.label-text {
    font-weight: 500;
}

/* Smaller subcategory text */
.small-option .label-text {
    font-size: 14px;
}
/* SUCCESS ALERT */
body.dark .alert-success {
    background-color: #064e3b;   /* Dark green */
    border: 1px solid #065f46;
    color: #d1fae5;
}

/* ERROR ALERT */
body.dark .alert-danger {
    background-color: #7f1d1d;   /* Dark red */
    border: 1px solid #991b1b;
    color: #fee2e2;
}

/* Improve list inside validation */
body.dark .alert-danger ul {
    padding-left: 1.2rem;
}

/* Remove overly bright bootstrap shadow */
body.dark .alert {
    box-shadow: none;
}
 
/* CHAT BUTTON */
/* =================================
FLOATING CHAT BUTTON
================================= */

#chatToggle{
position:fixed;
bottom:25px;
right:25px;
width:70px;
height:70px;
border-radius:50%;
border:none;
background:linear-gradient(135deg,#7c4dff,#6f42c1);
color:white;
font-size:26px;
cursor:pointer;
display:flex;
align-items:center;
justify-content:center;
box-shadow:0 1px 10px rgba(124,77,255,0.5);
transition:.3s;
z-index:9999;
}

#chatToggle:hover{
transform:scale(1.08);
box-shadow:0 2px 12px rgba(124,77,255,0.7);
}


/* =================================
CHAT WINDOW
================================= */

#chatWindow{
position:fixed;
bottom:110px;
right:25px;
width:380px;
height:520px;

display:none;
flex-direction:column;

border-radius:16px;
background:#ffffff;

box-shadow:0 20px 50px rgba(0,0,0,0.25);

overflow:hidden;
z-index:9999;
}


/* =================================
HEADER
================================= */

#chatHeader{

display:flex;
justify-content:space-between;
align-items:center;

padding:14px 16px;

background:linear-gradient(90deg,#7c4dff,#6f42c1);

color:white;

font-size:14px;
font-weight:600;

}

.ai-title{
display:flex;
align-items:center;
gap:8px;
}

.dot{
width:8px;
height:8px;
background:#22c55e;
border-radius:50%;
box-shadow:0 0 6px #22c55e;
}

#chatClose{
cursor:pointer;
opacity:.8;
}


/* =================================
MESSAGES AREA
================================= */

#chatMessages{
flex:1;
overflow-y:auto;
padding:14px;
background:#f7f8fb;
font-size:14px;
}

/* USER MESSAGE */

.user{
text-align:right;
margin-bottom:10px;
}

.user span{

display:inline-block;

background:#7c4dff;
color:white;

padding:9px 13px;

border-radius:14px 14px 4px 14px;

max-width:75%;

}


/* BOT MESSAGE */

.bot{
text-align:left;
margin-bottom:10px;
}

.bot span{

display:inline-block;

background:#eef0f5;
color:#222;

padding:9px 13px;

border-radius:14px 14px 14px 4px;

max-width:85%;

}


/* =================================
INPUT AREA
================================= */

#chatInputArea{
display:flex;
align-items:center;
gap:10px;
padding:10px;
border-top:1px solid #eee;
background:white;
}

/* INPUT BOX */

#chatInput{

flex:1;

border:1px solid #ddd;

border-radius:20px;

padding:10px 14px;

font-size:14px;

outline:none;

}

#chatInput:focus{
border-color:#7c4dff;
}


/* SEND BUTTON */

#chatSend{

width:38px;
height:38px;

border-radius:50%;

border:none;

background:#7c4dff;

color:white;

font-size:16px;

display:flex;
align-items:center;
justify-content:center;

cursor:pointer;

transition:.2s;

}

#chatSend:hover{
background:#6a3df0;
transform:scale(1.05);
}

.alert-btn{
    width:34px;
    height:34px;
    border:2px solid #7b3fe4;
    border-radius:6px;
    background:transparent;
    display:flex;
    align-items:center;
    justify-content:center;
    color:#7b3fe4;
    padding:0;
    line-height:1;
}

.alert-btn:hover{
    background:#7b3fe4;
    color:white;
}
/* =================================
SCROLLBAR
================================= */

#chatMessages::-webkit-scrollbar{
width:6px;
}

#chatMessages::-webkit-scrollbar-thumb{
background:#ccc;
border-radius:10px;
}


/* =================================
DARK MODE
================================= */

body.dark #chatWindow{
background:#0f0f14;
border:1px solid #2a2a36;
}

body.dark #chatMessages{
background:#121218;
color:#ddd;
}

body.dark .bot span{
background:#1f1f28;
color:#eee;
border:1px solid #2a2a36;
}

body.dark #chatInputArea{
background:#111116;
border-top:1px solid #2a2a36;
}

body.dark #chatInput{
background:#1a1a24;
border:1px solid #2a2a36;
color:white;
}

body.dark #chatInput::placeholder{
color:#777;
}

body.dark #chatMessages::-webkit-scrollbar-thumb{
background:#555;
}

/* AI TYPING INDICATOR */

.loading-dots::after{
content:"...";
font-size:18px;
letter-spacing:3px;
animation:dots 1.2s steps(3,end) infinite;
}

@keyframes dots{
0%{content:".";}
33%{content:"..";}
66%{content:"...";}
100%{content:".";}
}

#notifList .dropdown-item{
    white-space: normal;      /* allow wrapping */
    word-break: break-word;   /* break long words */
    font-size:14px;
    line-height:1.3;
}

#notifList{
    width:320px;
    max-height:400px;
    overflow-y:auto;
    overflow-x:hidden;        /* remove horizontal scroll */
}

#notifCount{
    position:absolute;
    top:-6px;
    right:-8px;
    background:#7b3fe4;   /* your purple theme */
    color:white;
    font-size:11px;
    font-weight:bold;
    min-width:18px;
    height:18px;
    padding:0 4px;
    border-radius:50px;
    display:flex;
    align-items:center;
    justify-content:center;
    line-height:1;
}
::-webkit-scrollbar {
    width: 6px;
}
::-webkit-scrollbar-thumb {
    background: #7b3fe4;
    border-radius: 10px;
}
</style>