% The following algorithm computes the exact Monte Carlo (MC) price estimate of an arithmetic Asian
% PUT option with discrete monitoring of the underlying S at times {t1,t2, ..., tn}. 
% We implement exact simulation of the geometric Brownian motion assumed for the underlying S.
clear;tic;
%% define variables
S0=100;T=1;r=0.04;sig=0.3;
M=1E6; %no. of simulations
n=12; %no. of monitoring dates
dt = T/n; %no. of steps
P = zeros(1,M); %pre allocate array P for speed purposes

%% simulate trajectories
for i=1:M
    S = [S0 zeros(1,n)]; %preallocate S to dimension n+1, with fixed S0>0 (for recursion in next step)
    for j=1:n
        %generate stock price at each time step
        S(j+1) = S(j)*exp((r-sig^2/2)*dt+sig*sqrt(dt)*randn);
    end %END nested forloop
    %generate sample of discounted payoffs of (fixed strike) asian PUT options
    K = mean(S(2:n+1)); %strike is average of realised S over period from time 0 to T
    %average over S(2) to S(n+1) as matlab indexes from 1
    P(i) = exp(-r*T)*max(K-S(n+1),0);
    %in reality this is sum from 1 to n if indexing from 0, hence why
    %dimension of S is fixed to n+1
end %END outer forloop

%% prices
MCPutPrice = mean(P) %option price given by mean of sample
%no built-in model to compute true option price for comparison

%% sampling uncertainty
%estimating volatility using sample counterpart
MCstd = std(P)/sqrt(M)

%% confidence interval
alpha = 0.95; %confidence interval parameter
CI = MCPutPrice + norminv(0.5 + alpha/2)*MCstd*[-1 1]

%% computation time
CPUtime = toc

