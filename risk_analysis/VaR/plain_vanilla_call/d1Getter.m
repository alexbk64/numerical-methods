function d1 = d1Getter(S, K, vol, r, T)
d1 = (log(S./K) + (r+vol.^2/2).*T)./(vol.*sqrt(T));
end