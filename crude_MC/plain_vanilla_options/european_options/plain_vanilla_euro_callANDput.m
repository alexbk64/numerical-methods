%this algorithm computes the exact (crude) Monte Carlo price of plain vanilla European
%call AND put options, based on exact simulation of the Geometric Brownian Motion
%assumed for the underlying stock price
clc;clear;
tic; %start recording computation time
%% define variables
S0 =100;K=100;T=1;r=0.04;sig=0.3; %spot; strike; time to maturity; continuously comp risk free rate; volatility;
M=1E6; % no. of simulations
Z=randn(1,M); %generate M standard normals (Z = [z1,z2,..,zM])
%% simulations
%generate terminal stock price sample (for each element of Z)
% - path independent options so no need to sim trajectories
ST = S0*exp((r-sig^2/2)*T+sig*sqrt(T)*Z); %vectorised computation, alternatively can perform using forloop
%generate discounted payoff sample for CALL at time T
CT = exp(-r*T)*max(ST-K,0);
%generate discounted payoff sample for PUT at time T
PT = exp(-r*T)*max(K-ST,0);
%% prices
%MC option price estimate given by mean of sample
MCCallPrice = mean(CT)
MCPutPrice = mean(PT)
%compute true option prices via BS model for comparison
[trueBSCallPrice, trueBSPutPrice] = blsprice(S0,K,r,T,sig)
%% sampling uncertainty
%estimating variance using sample counterpart
MCCallstd = std(CT)/sqrt(M)
MCPutstd = std(PT)/sqrt(M)
%% confidence interval
alpha = 0.95; %define confidence interval parameter
callCI = MCCallPrice + norminv(0.5 + alpha/2)*MCCallstd*[-1 1]
putCI = MCPutPrice + norminv(0.5 + alpha/2)*MCPutstd*[-1 1]
%% computation time
CPUtime = toc %output computation time