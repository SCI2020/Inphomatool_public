%% the probility density function for time jitter
function [P] = time_jitter(T, mu, sigma, kappa_0, kappa_1, gamma, t_0, b)
    % avoid negative parameters
    kappa_0 = abs(kappa_0);
    kappa_1 = abs(kappa_1);
    b = abs(b);
    % shift and ReLU T
    T = T - t_0;
    T = (T < 1) .* 1 + (T >= 1) .* T;
    % the Gaussian peak
    GaussPeak = exp(-(T-mu).^2./(2*sigma)^2);
    % the Expotential tail
    ExpTail = (1./sqrt(pi*kappa_0*T) .* exp(-(T-mu).^2./(kappa_0*T))) .* (1+(T-mu)./(kappa_1*T));
    P = abs(GaussPeak + gamma * ExpTail);
    P = (P) / sum(P, 'all');
    P = P + b; %P = (P+b) / sum(P+b, 'all');
end
