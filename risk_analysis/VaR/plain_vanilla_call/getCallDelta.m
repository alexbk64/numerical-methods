function delta = getCallDelta(S,K,vol,r,T)
d1 = d1Getter(S, K, vol, r, T);
delta = normcdf(d1);
end
