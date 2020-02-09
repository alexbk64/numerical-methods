% First function: returns the estimated correlation coefficient between samples
% of discounted payoffs of the arithmetic and geometric Asian options. It also
% returns the estimated control variate optimal coefficient b* using a separate set of
% % Monte Carlo simulations...
function [correlCoef, bStarHat] = controlVariateEstimatorb(S0, K, T, r, sig, n, Mb)
dt = T/n;
arithP = zeros(1,Mb);
geoP = zeros(1,Mb);
for i=1:Mb
    S=[S0 zeros(1,n)]; %preallocate S to dimension n+1 with fixed S0
    for j=1:n
        S(j+1) = S(j)*exp((r-sig^2/2)*dt+sig*sqrt(dt)*randn); %simulate trajectory
    end
    %discounted payoff sample for arith and geo puts
    arithP(i)=exp(-r*T)*max(K-mean(S(2:n+1)),0);
    geoP(i)=exp(-r*T)*max(K-geomean(S(2:n+1)),0);
end

%% control variate estimator bstar
% bStarHat = cov(arithP,geoP)./var(geoP);
bStarHat = sum((arithP-mean(arithP)).*(geoP-mean(geoP)))/sum((geoP-mean(geoP)).^2);

%% correlation coefficient
correlCoef = (bStarHat.*std(geoP))/std(arithP);
end
