%% Computation of VaR at 99% confidence level using Monte Carlo with delta approximation
function var = getMCDelta(S0,K,T,r,vol,horizon, M)
var = zeros(M, 1); %pre-allocate dimension for speed
thetaEffect = getCallTheta(S0,K,vol,r,T)*horizon; % remains the same for each sim
for i=1:M
    logRt = vol*sqrt(horizon)*randn; %generate random change in prices using iid standard normals
    arithRt = exp(logRt)-1; %arithmetic return
    deltaEffect = getCallDelta(S0,K,vol,r,T)*S0*arithRt;
    dV = deltaEffect + thetaEffect;
%     var(i) = -dV;
    var(i) = dV;
end % END forloop
end
