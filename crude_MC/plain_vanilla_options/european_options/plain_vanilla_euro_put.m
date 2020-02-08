%this algorithm computes the exact (crude) Monte Carlo price of a plain vanilla European
%put option, based on exact simulation of the Geometric Brownian Motion
%assumed for the underlying stock price
clear;clc;
tic; % start computation timer
%declare variables
S0 = 100; K = 100; T = 1; r = 0.04; sig = 0.3;
M = 1E6; %no of simulations
Z = randn(1,M); % vector of M standard normals
%generate M sims of terminal stock price (one for every standard normal z)
ST = S0*exp((r-sig^2/2)*T + sig*sqrt(T)*Z);
%generate discounted payoff sample for put
PT = exp(-r*T)*max(K-ST,0); 
%put price given sample mean
MCPutPrice = mean(PT)
%true Put price via built in BS model
[trueBSCallPrice, trueBSPutPrice] = blsprice(S0, K, r, T, sig); 
trueBSPutPrice %display

%sampling uncertainty
MCstd = std(PT)/sqrt(M)

%confidence interval
alpha = 0.95; %define CI parameter alpha
% (1-alpha)/2 + alpha -> (2alpha + 1 - alpha)/2 -> alpha/2 + 1/2 -> (95%
% area of pdf)
CI = MCPutPrice + norminv(0.5+alpha/2)*MCstd*[-1 1] %[-1 1] for +-


CPU_time = toc %stop timer and output CPU_time