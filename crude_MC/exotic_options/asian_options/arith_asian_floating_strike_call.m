this algorithm computes the exact (crude) Monte Carlo price estimate of a fixed strike arithmetic
Asian call option with discrete monitoring of the underlying S at times {t1,t2,...,tn}
Exact simulation of the Geometric Brownian Motion assumed for the
underlying stock price


clear;clc;tic;
% define variables
S0=100;T=1;r=0.04;sig=0.3;%spot;maturity;rf rate;volatility;
NOTE: strike not defined as it is an average of underlying S over the
period preceeding maturity
M = 1E6; %no. of simulations
n = 12; %option is path dependent - n gives no. of monitoring observations
dt = T/n; %no. of time steps
% Simulate all trajectories
C = zeros(1,M); %predefine size of vector C
for j = 1:M
    S = [S0 zeros(1,n)]; %pre-allocate dimensions of S to n+1
    for i = 1:n
        recursively generate stock price sample at each time t
        S(i+1) = S(i)*exp((r-sig^2/2)*dt+sig*sqrt(dt)*randn); %initialised by fixed S0 > 0
    end %END inner forloop
    for given trajectory, generate discounted option payoff of sample at time T
    (discounted)fixed strike arithmetic average discretely monitored Asian call payoff
    K = mean(S(2:n+1)); %average from S(2) to S(n+1) as matlab indexes from 1
    C(j) = exp(-r*T)*max(S(n+1)-K,0); %payoff is terminal S minus average of S over period from time 0 to T
end %END outer forloop

% prices
MCCallPrice = mean(C) %MC estimate of option price given by mean of sample
no given model (such as BS) to compute price, as sum of lognormals S(i) is NOT
lognormal. Therefore can't make direct comparison with "true" price as in the case of plain vanillas

% sampling uncertainty: estimating volatility using sample counterpart
MCstd = std(C)/sqrt(M)%MC standard error

% confidence interval
alpha = 0.95; %confidence interval parameter
CI = MCCallPrice + norminv(0.5+alpha/2)*MCstd*[-1 1] %100*alpha% confidence interval

% Computation time
CPUtime=toc
