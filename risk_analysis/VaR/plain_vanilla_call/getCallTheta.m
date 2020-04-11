function theta = getCallTheta(S,K,vol,r,T)
d1 = d1Getter(S, K, vol, r, T);
d2 = d2Getter(S, K, vol, r, T);
%split calculation in 2 for readability
t1 = -(S*normpdf(d1)*vol)/(2*sqrt(T));
t2 = -(r*K*exp(-r*T)*normcdf(d2));
theta = t1+t2;
end
