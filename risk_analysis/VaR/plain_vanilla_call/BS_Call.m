%% BS_Call(S) Black Scholes call option price
%   S: stock price, K: strike point,
%   var: volatility, r: interet rate,
%   T: price of maturity
function price = BS_Call(S, K, vol, r, T)
    d1 = d1Getter(S, K, vol, r, T);
    d2 = d2Getter(S, K, vol, r, T);
    price = S.*normcdf(d1)-K*exp(-r.*T).*normcdf(d2);
end

