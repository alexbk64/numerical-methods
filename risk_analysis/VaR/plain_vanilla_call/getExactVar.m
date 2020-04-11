function exact = getExactVar(S0,K,T,r,vol,horizon,alpha)
callInitial = BS_Call(S0,K,vol,r,T);
worstCaseSpot = S0 * exp(norminv(1-alpha)*vol*sqrt(horizon)); %quantile * annualised vol
worstCaseCall = BS_Call(worstCaseSpot,K,vol,r,T-horizon);
exact = callInitial-worstCaseCall;
end %% end function