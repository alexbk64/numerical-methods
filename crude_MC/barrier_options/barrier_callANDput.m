% The following algorithm computes the exact Monte Carlo (MC) price
% estimate of barrier call and put options. 
% We implement exact simulation of the geometric Brownian motion assumed for the underlying S.
clear;clc;
tic; %start CPU timer
%KNOCK IN options acquire plain vanilla structure (come alive) when underlying S hits predefined 
%barrier, KNOCK OUT options are knocked out when underlying crosses barrier

%% define variables
S0=100;K=100;T=1;r=0.04;sig=0.3;
B=120;
M = 1E6; %no. of simulations
n = 252;
dt = T/n;
callDI=zeros(1,M);
callUI=zeros(1,M);
putDI=zeros(1,M);
putUI=zeros(1,M);
callDO=zeros(1,M);
callUO=zeros(1,M);
putDO=zeros(1,M);
putUO=zeros(1,M);
for i=1:M
    S = [S0 zeros(1,n)]; %preallocate dimension of S to n+1, with fixed S0 > 0
    for j=1:n
        S(j+1) = S(j)*exp((r-sig^2/2)*dt+sig*sqrt(dt)*randn); %recursively compute stock price at each time step
    end % end nested forloop
    %% KNOCK IN
    %DOWN AND IN 
    if min(S) <= B %comes alive if S falls below barrier at any point between 0 and T
        callDI(i) = exp(-r*T)*max(S(n+1)-K,0);
        putDI(i) = exp(-r*T)*max(K-S(n+1),0);
    else %if S does not cross barrier, option never comes alive (payoff is 0)
        callDI(i) = 0;
        putDI(i) = 0;
    end
    %UP AND IN CALLS
    if max(S) >= B %comes alive if S passes (above) the barrier at any point between 0 and T
        callUI(i) = exp(-r*T)*max(S(n+1)-K,0);
        putUI(i) = exp(-r*T)*max(K-S(n+1),0);

    else %if S does not cross barrier, option never comes alive (payoff is 0)
        callUI(i) = 0;
        putUI(i) = 0;
    end
    %% KNOCK OUT
    %DOWN AND OUT
    if min(S) > B %option is alive and behaves like plain vanilla
        callDO(i) = exp(-r*T)*max(S(n+1)-K,0);
        putDO(i) = exp(-r*T)*max(K-S(n+1),0);

    else %otherwise option is knocked out
        callDO(i) = 0;
        putDO(i) = 0;
    end
    %UP AND OUT
    if max(S) < B %option is alive
        callUO(i) = exp(-r*T)*max(S(n+1)-K,0);
        putUO(i) = exp(-r*T)*max(K-S(n+1),0);
    else %option is knocked out
        callUO(i) = 0;
        putUO(i) = 0;
    end
    
end %end outer for loop

%% prices
%option price given by sample mean
callDIPrice = mean(callDI);
callUIPrice = mean(callUI);
putDIPrice = mean(putDI);
putUIPrice = mean(putUI);
callDOPrice = mean(callDO);
callUOPrice = mean(callUO);
putDOPrice = mean(putDO);
putUOPrice = mean(putUO);

%% sampling uncertainty
%estimating volatility using sample counterpart
callDIstd = std(callDI)/sqrt(M);
callUIstd = std(callUI)/sqrt(M);
putDIstd = std(putDI)/sqrt(M);
putUIstd = std(putUI)/sqrt(M);
callDOstd = std(callDI)/sqrt(M);
callUOstd = std(callUI)/sqrt(M);
putDOstd = std(putDI)/sqrt(M);
putUOstd = std(putUI)/sqrt(M);

%% confidence interval
alpha = 0.95;
callDIConfInt = callDIPrice + norminv(0.5+alpha/2)*callDIstd*[-1 1];
callUIConfInt = callUIPrice + norminv(0.5+alpha/2)*callUIstd*[-1 1];
putDIConfInt = putDIPrice + norminv(0.5+alpha/2)*putDIstd*[-1 1];
putUIConfInt = putUIPrice + norminv(0.5+alpha/2)*putUIstd*[-1 1];
callDOConfInt = callDOPrice + norminv(0.5+alpha/2)*callDOstd*[-1 1];
callUOConfInt = callUOPrice + norminv(0.5+alpha/2)*callUOstd*[-1 1];
putDOConfInt = putDOPrice + norminv(0.5+alpha/2)*putDOstd*[-1 1];
putUOConfInt = putUOPrice + norminv(0.5+alpha/2)*putUOstd*[-1 1];


%% printing results
fprintf('       Down and Out    Down and In     Up and Out     Up and In\n')     
fprintf('Call     ')
fprintf('%7.4f        ', callDOPrice, callDIPrice, callUOPrice, callUIPrice)
fprintf('\nPut      ')
fprintf('%7.4f        ', putDOPrice, putDIPrice, putUOPrice, putUIPrice)

