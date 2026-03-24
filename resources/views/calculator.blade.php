@extends('components.app')

@section('content')

<div class="calculator-page">
    <h2>Financial Calculators</h2>

    <div class="calculator-grid">

        <div class="calculator-menu">
            <a href="#" onclick="loadCalculator('sip',this)">SIP Calculator</a>
            <a href="#" onclick="loadCalculator('fd',this)">Fixed Deposit</a>
            <a href="#" onclick="loadCalculator('rd',this)">Recurring Deposit</a>
            <a href="#" onclick="loadCalculator('emi',this)">Loan EMI</a>
            <a href="#" onclick="loadCalculator('ltcg',this)">LTCG Tax</a>
            <a href="#" onclick="loadCalculator('income',this)">Income Tax</a>
            <a href="#" onclick="loadCalculator('hra',this)">HRA</a>
            <a href="#" onclick="loadCalculator('epf',this)">EPF</a>
            <a href="#" onclick="loadCalculator('nps',this)">NPS</a>
            <a href="#" onclick="loadCalculator('risk',this)">Risk Tolerance</a>
            <a href="#" onclick="loadCalculator('fitness',this)">Financial Fitness</a>
        </div>

        <div class="calculator-content" id="calculatorContent">
            <h3>Select a calculator</h3>
        </div>

    </div>
</div>

<script>
function setActive(el){
    document.querySelectorAll('.calculator-menu a')
        .forEach(a => a.classList.remove('active'));
    el.classList.add('active');
}

function loadCalculator(type, el){
    if(el) setActive(el);
    const c = document.getElementById('calculatorContent');

    const forms = {

sip: `
<h3>SIP Calculator</h3>
<input type="number" id="sipAmount" placeholder="Monthly Investment">
<input type="number" id="sipRate" placeholder="Annual Return %">
<input type="number" id="sipYears" placeholder="Years">
<button onclick="calcSIP()">Calculate</button>
<div class="result-box" id="result"></div>`,

fd: `
<h3>Fixed Deposit</h3>
<input type="number" id="fdAmount" placeholder="Deposit Amount">
<input type="number" id="fdRate" placeholder="Interest %">
<input type="number" id="fdYears" placeholder="Years">
<button onclick="calcFD()">Calculate</button>
<div class="result-box" id="result"></div>`,

rd: `
<h3>Recurring Deposit</h3>
<input type="number" id="rdAmount" placeholder="Monthly Deposit">
<input type="number" id="rdRate" placeholder="Interest %">
<input type="number" id="rdYears" placeholder="Years">
<button onclick="calcRD()">Calculate</button>
<div class="result-box" id="result"></div>`,

emi: `
<h3>Loan EMI</h3>
<input type="number" id="loanAmount" placeholder="Loan Amount">
<input type="number" id="loanRate" placeholder="Interest %">
<input type="number" id="loanYears" placeholder="Years">
<button onclick="calcEMI()">Calculate</button>
<div class="result-box" id="result"></div>`,

ltcg: `
<h3>LTCG Tax</h3>
<input type="number" id="buyPrice" placeholder="Buy Price">
<input type="number" id="sellPrice" placeholder="Sell Price">
<button onclick="calcLTCG()">Calculate</button>
<div class="result-box" id="result"></div>`,

income: `
<h3>Income Tax</h3>
<input type="number" id="income" placeholder="Annual Income">
<button onclick="calcIncome()">Calculate</button>
<div class="result-box" id="result"></div>`,

hra: `
<h3>HRA Calculator</h3>
<input type="number" id="basic" placeholder="Basic Salary">
<input type="number" id="hra" placeholder="HRA Received">
<input type="number" id="rent" placeholder="Rent Paid">
<button onclick="calcHRA()">Calculate</button>
<div class="result-box" id="result"></div>`,

epf: `
<h3>EPF Calculator</h3>
<input type="number" id="epfSalary" placeholder="Monthly Salary">
<button onclick="calcEPF()">Calculate</button>
<div class="result-box" id="result"></div>`,

nps: `
<h3>NPS Calculator</h3>
<input type="number" id="npsAmount" placeholder="Monthly Investment">
<input type="number" id="npsYears" placeholder="Years">
<button onclick="calcNPS()">Calculate</button>
<div class="result-box" id="result"></div>`,

risk: `
<h3>Risk Tolerance</h3>
<input type="number" id="age" placeholder="Your Age">
<button onclick="calcRisk()">Check</button>
<div class="result-box" id="result"></div>`,

fitness: `
<h3>Financial Fitness</h3>
<input type="number" id="savings" placeholder="Monthly Savings">
<input type="number" id="expenses" placeholder="Monthly Expenses">
<button onclick="calcFitness()">Check</button>
<div class="result-box" id="result"></div>`
};

    c.innerHTML = forms[type];
}

/* ===== Calculations ===== */

function val(id){ return parseFloat(document.getElementById(id)?.value) || 0; }
function show(text){ document.getElementById("result").innerHTML = text; }

function calcSIP(){
    let P=val("sipAmount"), r=val("sipRate")/100/12, n=val("sipYears")*12;
    let FV=P*((Math.pow(1+r,n)-1)/r)*(1+r);
    show("Future Value: ₹"+FV.toFixed(2));
}

function calcFD(){
    let A=val("fdAmount")*Math.pow(1+val("fdRate")/100,val("fdYears"));
    show("Maturity Amount: ₹"+A.toFixed(2));
}

function calcRD(){
    let P=val("rdAmount"), r=val("rdRate")/100/4, n=val("rdYears")*4;
    let M=P*n+(P*n*(n+1)/2)*r;
    show("Maturity Amount: ₹"+M.toFixed(2));
}

function calcEMI(){
    let P=val("loanAmount"), r=val("loanRate")/100/12, n=val("loanYears")*12;
    let EMI=(P*r*Math.pow(1+r,n))/(Math.pow(1+r,n)-1);
    show("Monthly EMI: ₹"+EMI.toFixed(2));
}

function calcLTCG(){
    let gain=val("sellPrice")-val("buyPrice");
    let tax=gain>100000?(gain-100000)*0.1:0;
    show("Tax Payable: ₹"+tax.toFixed(2));
}

function calcIncome(){
    let inc=val("income");
    let tax=inc>1000000?inc*0.2:inc*0.1;
    show("Estimated Tax: ₹"+tax.toFixed(2));
}

function calcHRA(){
    let exemption=Math.min(val("hra"), val("rent")-(0.1*val("basic")));
    show("HRA Exemption: ₹"+exemption.toFixed(2));
}

function calcEPF(){
    show("Monthly EPF: ₹"+(val("epfSalary")*0.12).toFixed(2));
}

function calcNPS(){
    show("Total Invested: ₹"+(val("npsAmount")*12*val("npsYears")).toFixed(2));
}

function calcRisk(){
    show("Suggested: "+(val("age")<35?"High Risk":"Moderate Risk"));
}

function calcFitness(){
    show("Financial Score: "+((val("savings")/val("expenses"))*100).toFixed(0));
}
</script>

@endsection