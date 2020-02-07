% The following algorithm computes the exact Monte Carlo (MC) price estimate of an arithmetic Asian
% call option with discrete monitoring of the underlying S at times {t1,
% t2, ..., tn}. We implement exact simulation of the geometric Brownian motion assumed for the underlying S.

clc;clear;
tic % clock starts ticking
%Initial stock price 
S0 = 100; 
%Strike price 
K = 100;
%Time to maturity 
T = 1;
%Price volatility  
sig = 0.3;
%Continuously compounded risk free interest rate 
r = 0.04;
n = 12; % option is path-dependent: n gives the no. of monitoring dates
dt = T/n; %number of time steps
M = 1E6; % number of simulations
C = zeros(1,M); % define vector C
for j=1:M
    S = [S0 zeros(1,n)]; % pre allocate array todimension n+1 by filling with zeros
    for i=1:n
        S(i+1) = S(i)*exp((r-sig^2/2)*dt+sig*sqrt(dt)*randn);
    end
    C(j) = exp(-r*T)*max(mean(S(2:n+1))-K,0); % S(2:n+1) must start from 2 until n+1 as matlab indexes from 1
    % can also use this method (after estimating all trajectories) to price
    % plain vanilla option, by replacing with S(2:n+1) by the terminal value
    % for S, S(n+1)
    %C(j) = exp(-r*T)*max(mean(S(n+1))-K,0); % S(n+1)
end
%vectorised alternative (faster)
%ST = S0*exp((r-sig.^2/2)*T+sig*sqrt(T)*randn(1,M)); 

format long g;
%CT = exp(-r*T)*max(ST-K,0); % computes option terminal payoff
MCBSCallPrice = mean(C); % MC estimate of plain vanilla option price
trueBSCallPrice = blsprice(S0,K,r,T,sig, 0); % built in BS model

%%sampling uncertainty
MCstd = std(C)/sqrt(M); % standard error of MC
disp([MCBSCallPrice MCstd])

%define a confidence interval parameter, alpha
alpha = 0.95;
CI = MCBSCallPrice + norminv(0.5 + alpha/2)*(MCstd)*[-1 1]

CPUtime = toc; % returns computation time