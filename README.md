# numerical-methods
A collection of MATLAB scripts implementating various numerical methods for derivative pricing

<h5> Pricing via crude Monte Carlo Simulations</h5>
<ul>
  <li><a href=https://github.com/alexbk64/numerical-methods/blob/master/crude_MC/plain_vanilla_options/european_options/plain_vanilla_euro_callANDput.m>Plain Vanilla European call and put options:</a> computes the exact (crude) Monte Carlo price estimate of plain vanilla call and put options based on exact simulation of the geometric Brownian motion assumed for the underlying stock price.</li>
  <li><a href=https://github.com/alexbk64/numerical-methods/blob/master/crude_MC/exotic_options/asian_options/arith_asian_fixed_strike_callANDput.m>Arithmetic Asian call and put options, with fixed strike:</a> computes the exact (crude) Monte Carlo price estimate of a fixed strike arithmetic Asian call and put options, with discrete monitoring of the underlying S at times {t1,t2, ..., tn}. We implement exact simulation of the geometric Brownian motion assumed for the underlying stock price.</li>
  <li><a href=https://github.com/alexbk64/numerical-methods/blob/master/crude_MC/exotic_options/barrier_options/barrier_callANDput.m>Knock-in and Knock-out barrier options</a> computes the exact (crude) Monte Carlo price estimate of:
    <ul>
      <li>Down and Out</li>
      <li>Down and In</li>
      <li>Up and Out</li>
      <li>Up and In</li>
    </ul>
  call and put options, with discrete monitoring of the underlying S at times {t1,t2, ..., tn}. We implement exact simulation of the geometric Brownian motion assumed for the underlying stock price.</li>
</ul>
