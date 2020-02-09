clc;clear;
S0 = 100; K = 100; T=1; r=0.04; sig=0.3;
M = 1E6; %no. of sims
Mb = 1E4; %no. of sims for estimation of b
n = 12; %no. of discrete observations
dt = T/n; %no. of time steps for trajectory simulation
alpha = 0.95; %confidence interval parameter

% First function: returns the estimated correlation coefficient between samples
% of discounted payoffs of the arithmetic and geometric Asian options. It also
% returns the estimated control variate optimal coefficient b* using a separate set of
% % Monte Carlo simulations...
[correlCoef, bStarHat] = controlVariateEstimatorb(S0, K, T, r, sig, n, Mb)

tic %start computation timer
% ...Second function: takes as input b* and performs CV Monte Carlo for the arithmetic Asian option.
% It returns the standard error of the CV Monte Carlo estimate, the Monte
% Carlo CV price estimate itself and the lower/upper bounds of the CI.
[MCstd, MCAsianArithPrice, MCConfInt] = arithAsianCallCV(S0, K, T, r, sig, n, M, bStarHat, alpha)
clockTime = toc % returns the execution time of the arithmetic Asian via control variate monte carlo