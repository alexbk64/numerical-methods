%% must define below variables (through assumptions or calibration)

r=0.1; % store risk free rate of interest (continuously compounded)
sig=0.25; % store one-period log-return volatility (vol)
T=1;% store time to maturity.
dt=T/4; % store time step size.
alpha=8; % for h
h=0.1*2^-alpha; % store one-period log-return step size.
ksi=10; % store number of standard deviations for one-period log-return.
S0=100; % store initial value of the underlying.
% K=100; % store strike price.
K = 110;

%% set up grid of values of one-period log return:
kup = ceil(ksi*sig*sqrt(dt)/h); %ceiling function
z = (kup:-1:-kup)*h; %values of one-period log return
k = 2*kup + 1; %k-nomial lattice

%% set up risk-neutral probabilities of one-period log returns w/ trapezoid weights
phi = normpdf(z,(r-0.5*sig^2)*dt,sig*sqrt(dt));
q = h*phi;
q(1) = q(1)/2; %first term of trap function halved
q(k) = q(k)/2; %final term of trap function halved

%% set up multinomial lattice
n = T/dt;
MaxDim = 1+(k-1)*n; %total no. of nodes at nth period

%% compute terminal (i.e. at nth period) stock price across all nodes and then terminal option payoff
S = S0*exp(n*z(1)-(0:MaxDim-1)*h); %size of terminal vector S is equal to MaxDim
C = max([(S-K);zeros(1,MaxDim)]);

%% Loop over all time steps (outside loop) & nodes per time step (inside loop) to compute option prices step-by-step backwards starting from terminal one:
for j = n:-1:1
    Cnext = C;
    for l = 1:1+(k-1)*(j-1) % 1+(k-1)*(j-1) is the number of nodes as at the (j-1)-th period.
        C(l) = exp(-r*dt)*(q*Cnext(l:l+k-1)'); % ' denotes the transpose.
    end
end
price = C(1) % option price at present time.