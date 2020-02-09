% Second function: takes as input b* and confidence interval parameter and performs CV Monte Carlo
% for the arithmetic Asian option.
% It returns the standard error of the CV Monte Carlo estimate, the Monte
% Carlo CV price estimate itself and the lower/upper bounds of the CI.

function [stdMC,callPriceMCCV, confIntMC] = arithAsianCallCV(S0,K,T,r,sig,n, M, bStarHat, alpha)
    dt = T/n;
    arithC = zeros(1,M); %preallocate discounted payoff of arith Asian CALL
    geoC = zeros(1,M); %preallocate discounted payoff of geo Asian CALL
    trueGeoC = asianGeo(S0,K,T,r,sig,n); %compute true (known) value of geo Asian CALL
    
    %% Control Variate Monte Carlo
    for i=1:M
        S = [S0 zeros(1,n)]; %preallocate dimensions of S to n+1, with fixed S0
        for j=1:n
            S(j+1)=S(j)*exp((r-sig^2/2)*dt+sig*sqrt(dt)*randn);
        end
%         Cb(i) = arithC(i)-bStarHat*(geoC(i)-trueGeoC);
        arithC(i) = exp(-r*T)*max(mean(S(2:n+1))-K,0);
        geoC(i) = exp(-r*T)*max(geomean(S(2:n+1))-K,0);
    end
    Cb = arithC-bStarHat*(geoC-trueGeoC);
    %Monte carlo estimate of option price given by sample mean
    callPriceMCCV = mean(Cb);
    
    %% sampling uncertainty 
    stdMC = std(Cb)/sqrt(M);
    
    %% confidence interval
    confIntMC = callPriceMCCV + norminv(0.5+alpha/2)*stdMC*[-1 1];
    
end
