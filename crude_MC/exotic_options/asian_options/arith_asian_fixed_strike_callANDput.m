%this algorithm computes the exact (crude) Monte Carlo price estimate of fixed strike arithmetic
%Asian call AND put options, with discrete monitoring of the underlying S at times {t1,t2,...,tn}
%Exact simulation of the Geometric Brownian Motion assumed for the underlying stock price

clear;clc;tic;
%% define variables
S0=100;K=100;T=1;r=0.04;sig=0.3;%spot;strike;maturity;rf rate;volatility;
M = 1E6; %no. of simulations
n = 12; %option is path dependent - n gives no. of monitoring observations
dt = T/n; %no. of time steps
%% Simulate all trajectories
C = zeros(1,M); %predefine size of array C for efficiency
P = zeros(1,M); %predefine size of array P, same reason
for j = 1:M
    S = [S0 zeros(1,n)]; %preallocate S to dimension n+1, with fixed S0>0 (for recursion in next step)
    for i = 1:n
        % recursively generate stock price sample at each time step t(i)
        S(i+1) = S(i)*exp((r-sig^2/2)*dt+sig*sqrt(dt)*randn); %initialised by fixed S0 > 0
    end %END inner forloop
    %for given trajectory, generate discounted option payoff of sample at time T
    %(discounted)fixed strike arithmetic average discretely monitored Asian call payoff
    C(j) = exp(-r*T)*max(mean(S(2:n+1))-K,0); %call
    P(j) = exp(-r*T)*max(K-mean(S(2:n+1)),0); %put
    %average from S(2) to S(n+1) as matlab indexes from 1. In reality this is sum from 1 to n 
    %if indexing from 0, hence why dimension of S is fixed to n+1.
end %END outer forloop

%% prices
%MC estimate of option price given by mean of sample
arithAsianCallPrice = mean(C)
arithAsianPutPrice = mean(P)
% no built-in model (such as BS) to compute true option price, as sum of lognormals S(i) is NOT
% lognormal. Therefore can't make direct comparison with "true" price as in the case of plain vanillas

%% sampling uncertainty
%estimating volatility using sample counterpart
arithAsianCallstd = std(C)/sqrt(M)%MC standard error
arithAsianPutstd = std(P)/sqrt(M)

%% confidence interval
alpha = 0.95; %confidence interval parameter
arithAsianCallCI = arithAsianCallPrice + norminv(0.5+alpha/2)*arithAsianCallstd*[-1 1] %100*alpha% confidence interval
arithAsianPutCI = arithAsianPutPrice + norminv(0.5+alpha/2)*arithAsianPutstd*[-1 1]
%% Computation time
CPUtime=toc