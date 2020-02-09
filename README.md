# numerical-methods
A collection of MATLAB scripts implementating various numerical methods for derivative pricing

<h5> Pricing via crude Monte Carlo Simulations</h5>
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
<h4>Variance reduction techniques</h4>
<h5>Pricing via control variates Monte Carlo Simulations</h5>
<ul>
  <li><a href=https://github.com/alexbk64/numerical-methods/tree/master/control_variate/asian/arith_asian_call>Arithmetic Asian call option: </a> computes the (control variates) Monte Carlo price estimate of a fixed-strike arithmetic Asian call option, with discrete monitoring of the underlying S at times <i>{t1,t2,...,tn}</i>. Done by exploiting information about the errors in estimates of a <b>known and correlated</b> quantity (the <b>geometric</b> Asian option price) to reduce the error of an estimate of an unknown quantity (the <b>arithmetic</b> Asian option price).</li>
  <li><a href=https://github.com/alexbk64/numerical-methods/tree/master/control_variate/asian/arith_asian_put>Arithmetic Asian put option: </a>approaches the pricing of a fixed-strike arithmetic Asian put option, in the same way as above.</li>
</ul>
<h5>Pricing via antithetic variates Monte Carlo Simulations</h5>


<p>
  <i>
    Disclaimer: The information and calculations provided by these scripts do not constitute financial, investment or tax advice. The aim of this repository is to provide general information only and is not an attempt to provide advice that relates to an indivudal's particular circumstances. It is strongly recommended to seek professional financial advice before making any financial decisions.
  </i>
</p>

