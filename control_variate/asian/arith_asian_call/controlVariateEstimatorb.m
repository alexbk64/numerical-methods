% First function: returns the estimated correlation coefficient between samples
% of discounted payoffs of the arithmetic and geometric Asian options. It also
% returns the estimated control variate optimal coefficient b* using a separate set of
% % Monte Carlo simulations...

function [correlCoef, bStarHat] = controlVariateEstimatorb(S0, K, T, r, sig, n, Mb)
%% define variables
dt = T/n;
%preallocate disc payoff sample arrays
arithC = zeros(1,Mb);
geoC=zeros(1,Mb);

%% Monte Carlo simulations
for i=1:Mb
    S=[S0 zeros(1,n)]; %preallocate S to dimension n+1, with fixed S0
    for j=1:n 
        S(j+1) = S(j)*exp((r-sig^2/2)*dt+sig*sqrt(dt)*randn); 
    end %END inner forloop
    %discounted arithmetic asian call payoff sample
    arithC(i) = exp(-r*T)*max(mean(S(2:n+1))-K,0); %average over S(2) to S(n+1) because matlab indexes from 1
    %discounted geometric asian call payoff sample
    geoC(i) = exp(-r*T)*max(geomean(S(2:n+1))-K,0); %same 
end %END outer forloop

%% prices
%option price given by sample mean
arithCPrice = mean(arithC);
geoCPrice = mean(geoC);

%% minimum variance estimator and correlation coefficient
%bstar = cov(C,P)/sig(p)^2 = sum((C-mew(C))*(P-mew(P))/sum((P-mew(P))^2)
bStarHat = sum((arithC-arithCPrice).*(geoC-geoCPrice))./sum((geoC-geoCPrice).^2);
%bstar = (rho*sig(c)*sig(p))/sig(p)^2 -> 
%rho = (bstar*sig(p))/sig(c)
correlCoef = bStarHat.*std(geoC)/std(arithC); % computes the correlation coef
% between samples of discounted payoffs of the arithmetic and geometric Asian options

end %END function
