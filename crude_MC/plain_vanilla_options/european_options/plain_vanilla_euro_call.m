%this algorithm computes the exact (crude) Monte Carlo price of a plain vanilla European
%call option, based on exact simulation of the Geometric Brownian Motion
%assumed for the underlying stock price

clc;clear;
tic; %start tracking computation time
%define variables
S0 = 100; %initial stock price
K = 100; %strike
r = 0.04; %continuously compounded risk-free interest rate
T = 1; %time to maturity
sig = 0.3; %volatility
M = 1E6; %number of simulations
Z = randn(1,M); %generate M standard normals (Z = [z1,z2,..,zM])
ST = S0*exp((r-sig^2/2)*T + sig*sqrt(T)*Z); %generate stock price at time T for each element of Z
%above is vectorised simulation, but can achieve same via forloop as below
%(vectorised version is faster)
% for i=1:M
%     ST(i) = S0*exp((r-sig^2/2)*T + sig*sqrt(T)*Z(i)); %exact simulation
% end %END forloop

CT = exp(-r*T)*max(ST-K,0); %generate discounted payoff sample at time T
%option price estimate given by sample mean:
MCCallPrice = mean(CT) %MC estimate of plain vanilla european call option price
[trueBSCallPrice, trueBSPutPrice] = blsprice(S0,K,r,T,sig) %true price of option given by BS model

%sampling uncertainty: estimating variance using sample counterpart,
%standard error of MC
MCstd = std(CT)/sqrt(M)

%confidence interval
alpha = 0.95; %define confidence interval parameter, alpha
CI = MCCallPrice + norminv(0.5+alpha/2)*MCstd*[-1 1] %[-1 1] because need +- for range

CPU_time = toc %display computation time