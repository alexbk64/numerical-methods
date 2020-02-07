% The following algorithm computes the exact Monte Carlo (MC) price estimate of a plain vanilla
% call option based on exact simulation of the geometric Brownian motion
% assumed for the underlying S.

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
M = 1E6; % number of simulations
ST = zeros(1,M); % define vector ST
for j=1:M
    ST(j) = S0*exp((r-sig^2/2)*T + sig*sqrt(T).*randn); % exact simulation
end
%vectorised alternative (faster)
%ST = S0*exp((r-sig.^2/2)*T+sig*sqrt(T)*randn(1,M)); 

format long g;
CT = exp(-r*T)*max(ST-K,0); % computes option terminal payoff
MCBSCallPrice = mean(CT); % MC estimate of plain vanilla option price
trueBSCallPrice = blsprice(S0,K,r,T,sig, 0); % built in BS model

%%sampling uncertainty
MCstd = std(CT)/sqrt(M); % standard error of MC
disp([MCBSCallPrice MCstd])

%define a confidence interval parameter, alpha
alpha = 0.95;
CI = MCBSCallPrice + norminv(0.5 + alpha/2)*(MCstd)*[-1 1]

CPUtime = toc; % returns computation time