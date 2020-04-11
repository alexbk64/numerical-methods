function d2 = d2Getter(S, K, vol, r, T)
d2 = (log(S./K) + (r-vol.^2/2).*T)./(vol.*sqrt(T));
end