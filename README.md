# numerical-methods
A collection of MATLAB scripts implementating various numerical methods for derivative pricing and risk analysis.

<h3>Pricing derivatives via Monte Carlo Simulations</h3>
<h4>Crude Monte Carlo:</h4>
<ul>
  <li><a href=https://github.com/alexbk64/numerical-methods/blob/master/crude_MC/plain_vanilla_options/european_options/plain_vanilla_euro_callANDput.m>Plain Vanilla European call and put options:</a> computes the exact (crude) Monte Carlo price estimate of plain vanilla call and put options based on exact simulation of the geometric Brownian motion assumed for the underlying stock price. True option prices calculated via Black-Scholes model are also computed for comparison.</li>
  <li><a href=https://github.com/alexbk64/numerical-methods/blob/master/crude_MC/exotic_options/asian_options/arith_asian_fixed_strike_callANDput.m>Arithmetic Asian call and put options, with fixed strike:</a> computes the exact (crude) Monte Carlo price estimate of a fixed-strike arithmetic Asian call and put options, with discrete monitoring of the underlying S at times <i>{t1,t2, ..., tn}</i>. We implement exact simulation of the geometric Brownian motion assumed for the underlying stock price. See <a href=crude_MC/exotic_options/asian_options>Asian options</a> for individual call and put pricing scripts, as well as for pricing floating-strike arithmetic Asian options.</li>
  <li><a href=https://github.com/alexbk64/numerical-methods/blob/master/crude_MC/exotic_options/barrier_options/barrier_callANDput.m>Knock-in and Knock-out barrier options</a> computes the exact (crude) Monte Carlo price estimate of:
    <ul>
      <li>Down and Out</li>
      <li>Down and In</li>
      <li>Up and Out</li>
      <li>Up and In</li>
    </ul>
  call and put options, with discrete monitoring of the underlying S at times <i>{t1,t2, ..., tn}</i>. We implement exact simulation of the geometric Brownian motion assumed for the underlying stock price.</li>
</ul>
<h4>Variance reduction techniques:</h4>
<h5>Pricing via control variates Monte Carlo Simulations</h5>
<ul>
  <li><a href=https://github.com/alexbk64/numerical-methods/tree/master/control_variate/asian/arith_asian_call>Arithmetic Asian call option: </a> computes the (control variates) Monte Carlo price estimate of a fixed-strike arithmetic Asian call option, with discrete monitoring of the underlying S at times <i>{t1,t2,...,tn}</i>. Done by exploiting information about the errors in estimates of a <b>known and correlated</b> quantity (the <b>geometric</b> Asian option price) to reduce the error of an estimate of an unknown quantity (the <b>arithmetic</b> Asian option price).</li>
  <li><a href=https://github.com/alexbk64/numerical-methods/tree/master/control_variate/asian/arith_asian_put>Arithmetic Asian put option: </a>approaches the pricing of a fixed-strike arithmetic Asian put option, in the same way as above.</li>
</ul>
<h5>Pricing via antithetic variates Monte Carlo Simulations</h5>
<ul><li>COMING SOON.</li></ul>

<h3>Pricing derivatives via Multinomial Lattices</h3>
<ul>
  <li><a href=https://github.com/alexbk64/numerical-methods/blob/master/multinomial_lattices/plain_vanilla.m>Plain Vanilla European call option:</a> computes the exact price estimate of a plain vanilla call option using a multinomial lattice.
  </li>
  <li><a href=https://github.com/alexbk64/numerical-methods/blob/master/multinomial_lattices/>Bermudan call option:</a> computes the exact price estimate of a Bermudan call option using a multinomial lattice. COMING SOON.
  </li>
</ul>



<!--------------------------------------------- RISK ANALYSIS --------------------------------------------------------->
<h3>Risk analysis</h3>
<h4>Value at Risk of an option</h4>
<ul>
  <li><a href=https://github.com/alexbk64/numerical-methods/tree/master/risk_analysis/VaR/plain_vanilla_call>Plain Vanilla European call option:</a> </br>
    <i>Note: Option prices are calculated via Black-Scholes model. Run <a href=https://github.com/alexbk64/numerical-methods/blob/master/risk_analysis/VaR/plain_vanilla_call/main.m><code>main.m</code></a> to initialise all variables and compute all of the below. Sets the confidence parameter to 99% by default. </i></br>
    <b>Closed-form solutions:</b>
    <ul>
      <li><a href=https://github.com/alexbk64/numerical-methods/blob/master/risk_analysis/VaR/plain_vanilla_call/getExactVar.m>Exact:</a> uses a closed-form solution to compute the exact VaR of a plain vanilla call option at a given confidence level for varying time-horizons.
      </li>
      <li><a href=https://github.com/alexbk64/numerical-methods/blob/master/risk_analysis/VaR/plain_vanilla_call/getExactDelta.m>Delta approximation:</a> uses a closed-form solution to compute the VaR of a plain vanilla call option at a given confidence level for varying time-horizons, via delta approximation. Uses a first-order Taylor series approximation, with the inclusion of an additional theta term to capture the effect of time on the value of the option.
      </li>
      <li><a href=https://github.com/alexbk64/numerical-methods/blob/master/risk_analysis/VaR/plain_vanilla_call/getExactDeltaGamma.m>Delta-gamma approximation:</a> uses a closed-form solution to compute the VaR of a plain vanilla call option at a given confidence level for varying time-horizons, via delta-gamma approximation. Uses a second-order Taylor series approximation, with the inclusion of an additional theta term to capture the effect of time on the value of the option. 
      </li>
    </ul>
    <b>Monte Carlo estimations:</b>
    <ul>
      <li>
        <a href=https://github.com/alexbk64/numerical-methods/blob/master/risk_analysis/VaR/plain_vanilla_call/getMCDelta.m>Delta approximation:</a> uses (crude) Monte Carlo simulations to build the P&L distribution of a plain vanilla call option, via delta approximation. VaR at a given confidence level is computed by finding the appropriate quantile of the simulated distribution. 
      </li>
      <li>
        <a href=https://github.com/alexbk64/numerical-methods/blob/master/risk_analysis/VaR/plain_vanilla_call/getMCDeltaGamma.m>Delta-gamma approximation:</a> uses (crude) Monte Carlo simulations to build the P&L distribution of a plain vanilla call option, via delta-gamma approximation. VaR at a given confidence level is computed by finding the appropriate quantile of the simulated distribution. 
      </li>
      <li><a href=https://github.com/alexbk64/numerical-methods/blob/master/risk_analysis/VaR/plain_vanilla_call/getMCReval.m>Full revaluation:</a> uses (crude) Monte Carlo simulations to build the P&L distribution of a plain vanilla call option, via full-revaluation. That is, the option is revaluated via the BS model for each simulated scenario. VaR at a given confidence level is computed by finding the appropriate quantile of the simulated distribution. 
      </li>
    </ul>
  </li>
  <li> More to come...</li>
</ul>

<p>
  <i>
    Disclaimer: The information and calculations provided by these scripts do not constitute financial, investment or tax advice. The aim of this repository is to provide general information only and is not an attempt to provide advice that relates to an indivudal's particular circumstances. It is strongly recommended to seek professional financial advice before making any financial decisions.
  </i>
</p>

