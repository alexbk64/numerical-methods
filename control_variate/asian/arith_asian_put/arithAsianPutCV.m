% Second function: takes as input b* and confidence interval parameter and performs CV Monte Carlo
% for the arithmetic Asian option.
% It returns the standard error of the CV Monte Carlo estimate, the Monte
% Carlo CV price estimate itself and the lower/upper bounds of the CI.

function [stdMC,putPriceMCCV, confIntMC] = arithAsianPutCV(S0,K,T,r,sig,n, M, bStarHat, alpha)
    dt = T/n;
    arithP = zeros(1,M); %preallocate discounted payoff of arith Asian PUT
    geoP = zeros(1,M); %preallocate discounted payoff of geo Asian PUT
    [~,trueGeoP] = asianGeo(S0,K,T,r,sig,n); %compute true (known) value of geo Asian PUT
    
    %% Control Variate Monte Carlo
    for i=1:M
        S = [S0 zeros(1,n)]; %preallocate dimensions of S to n+1, with fixed S0
        for j=1:n
            S(j+1)=S(j)*exp((r-sig^2/2)*dt+sig*sqrt(dt)*randn);
        end
%         Cb(i) = arithC(i)-bStarHat*(geoC(i)-trueGeoC);
        arithP(i) = exp(-r*T)*max(K-mean(S(2:n+1)),0);
        geoP(i) = exp(-r*T)*max(K-geomean(S(2:n+1)),0);
    end
    Pb = arithP-bStarHat*(geoP-trueGeoP);
    %Monte carlo estimate of option price given by sample mean
    putPriceMCCV = mean(Pb);
    
    %% sampling uncertainty 
    stdMC = std(Pb)/sqrt(M);
    
    %% confidence interval
    confIntMC = putPriceMCCV + norminv(0.5+alpha/2)*stdMC*[-1 1];
