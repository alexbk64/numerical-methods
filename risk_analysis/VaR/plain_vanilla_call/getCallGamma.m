function gamma = getCallGamma(S,K,vol,r,T)
d1 = d1Getter(S, K, vol, r, T);
gamma = normpdf(d1)/(S*vol*sqrt(T));
end
