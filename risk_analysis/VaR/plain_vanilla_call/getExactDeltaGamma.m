function exactDeltaGammaApprox = getExactDeltaGamma(S0,K,T,r,vol,horizon,alpha)
worstCaseSpot = S0 * exp(norminv(1-alpha)*vol*sqrt(horizon));
logRt = log(worstCaseSpot/S0); %worst-case log returns, note that log returns are iid
arithRt = exp(logRt)-1; %arithmetic return -> exp(logRt)-1 = (P1-P0)/P0
deltaEffect = getCallDelta(S0,K,vol,r,T)*S0*arithRt;
thetaEffect = getCallTheta(S0,K,vol,r,T)*horizon;
gammaEffect = 0.5*getCallGamma(S0,K,vol,r,T)*S0^2*arithRt^2;
dV = deltaEffect+gammaEffect+thetaEffect;
exactDeltaGammaApprox = -dV;
end