%% VAR OF AN OPTION - 99 percentile VAR of an option
clear;clc; close all; %erase all variables, clear command window, close all figures
%% declare and initialise variables
S0=100; %initial spot price of underlying
K=100; %strike
T=1; %time to maturity (years)
vol=0.3; %volatility (per anum)
days = [1 (10:10:90)]; %number of days in horizon
horizon = days./250; %time horizon
r = 0; %cont. compounded rf rate
M = 1E5; %number of simulations
alpha = 0.99;

%% pre-allocate memory
res = zeros(6, length(days));
%% get results, repeat for each horizon
initialOptionPrice = BS_Call(S0,K,vol,r,T);
for j=1:length(days)
    exact = getExactVar(S0,K,T,r,vol,horizon(j), alpha);
    exactDeltaApprox = getExactDelta(S0,K,T,r,vol,horizon(j), alpha);
    exactDeltaGammaApprox = getExactDeltaGamma(S0,K,T,r,vol,horizon(j), alpha);
    MCDeltaApprox = getMCDelta(S0,K,T,r,vol,horizon(j), M);
    MCDeltaGammaApprox = getMCDeltaGamma(S0,K,T,r,vol,horizon(j), M);
    MCReval = getMCReval(S0,K,T,r,vol,horizon(j), M);
    %store matrix of results    
    res(1,j) = exact;
    res(2,j) = exactDeltaApprox;
    res(3,j) = exactDeltaGammaApprox;
    res(4,j) = -prctile(MCDeltaApprox,1);
    res(5,j) = -prctile(MCDeltaGammaApprox,1);
    res(6,j) = -prctile(MCReval,1);
    %% print results
    fprintf('<strong> HORIZON: %2.0f</strong> \n', days(j))
    fprintf('Initial ATM call option price: $%5.2f \n',initialOptionPrice)
    fprintf('Exact VaR: %18.15f \n', exact)
    fprintf('Exact VaR via delta approximation: %18.15f \n', exactDeltaApprox)
    fprintf('Exact VaR via delta-gamma approximation: %18.15f \n', exactDeltaGammaApprox)
    fprintf('MC VAR via delta approximation: %18.15f \n', -prctile(MCDeltaApprox,(1-alpha)*100))
    fprintf('MC VaR via delta-gamma approximation: %18.15f \n', -prctile(MCDeltaGammaApprox,(1-alpha)*100))
    fprintf('MC VaR via full revaluation: %18.15f \n', -prctile(MCReval,(1-alpha)*100))

    %% plot
    
    ax = figure;
    % ksdensity(MCReval) % kernel density plot
    subplot(2,1,1)
    histogram(MCReval,'Normalization','pdf') % hist
    grid on
    title(['Simulated P&L via Full Revaluation - ',num2str(days(j)),' Day Horizon'])
    xlabel('P&L of Call Option')
    ylabel('PDF')
    subplot(2,1,2)
    ksdensity(MCReval) % kernel density plot
    grid on
    title(['Simulated P&L via Full Revaluation - ',num2str(days(j)),' Day Horizon'])
    xlabel('P&L of Call Option')
    ylabel('PDF') 
end

%% results table
for i = 1:6 % for each method (rows)
    for j = 1:length(days) %for each horizon (columns)
        fprintf('%18.15f |', res(i,j))
    end
    fprintf('\n')
end