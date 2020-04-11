%% Computation of VaR at 99% confidence level using Monte Carlo with full revaluation
function var = getMCReval(S0,K,T,r,vol,horizon, M)
var = zeros(M, 1); %pre-allocate dimension for speed
initial = BS_Call(S0,K,vol,r,T);
for i=1:M
    logRt = vol*sqrt(horizon)*randn; %generate random change in prices using iid standard normals, multiplied by annualised vol
%     arithRt = exp(logRt)-1; %arithmetic return
%     reval = BS_Call(S0*(1+arithRt),K,vol,r,T-horizon);
    reval = BS_Call(S0*exp(logRt),K,vol,r,T-horizon);

    dV = reval-initial;
%     var(i) = -dV;
    var(i) = dV;
end % END forloop
end
