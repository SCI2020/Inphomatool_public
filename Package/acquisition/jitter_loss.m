%% the loss function for time jitter fitting (cross entropy)
function [loss] = jitter_loss(jitter_parameters, T, hist)
    % unpackage parameters
    mu = jitter_parameters(1);
    sigma = jitter_parameters(2);
    kappa_0 = jitter_parameters(3);
    kappa_1 = jitter_parameters(4);
    gamma = jitter_parameters(5);
    t_0 = jitter_parameters(6);
    b = jitter_parameters(7);
    % the time jitter
    jitter = time_jitter(T, mu, sigma, kappa_0, kappa_1, gamma, t_0, b);
    % normalization
    jitter = jitter / sum(jitter, 'all');
    % cross entropy loss
    loss = -sum(hist .* log(jitter));
end

