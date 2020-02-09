% The following function computes the true price of the geometric Asian
% call option with underlying S monitored at discrete times {t1, t2, ..., tn}
% via BS model.

function [trueCallPrice, truePutPrice] = asianGeo(S0,K,T,r,sig,n)
dt = T/n;
Tbar = mean((1:n)*dt);
sigmabar = sqrt(sig^2/(n^2*Tbar)*sum((2*(1:n)-1).*(n:-1:1)*dt));
q = (sig^2-sigmabar^2)/2;
num = log(S0/K)+(r-q+sigmabar^2/2)*Tbar;
denom = sqrt(sigmabar^2*Tbar);
d1 = num/denom;
d2 = d1-denom;
trueCallPrice = exp(-r*T)*(S0*exp((r-q)*Tbar)*normcdf(d1)-K*normcdf(d2));
truePutPrice = exp(-r*T)*(K*normcdf(-d2)-S0*exp((r-q)*Tbar)*normcdf(-d1));

end %end function

