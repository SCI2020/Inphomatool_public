%% compute the galvanometer voltage from theta, based on voltage = beta^(-1) * (theta - epsilon)
function [voltage] = theta2voltage(theta, epsilon, beta)
    %theta = [theta_x; theta_y];
    voltage = beta^(-1) * (theta - epsilon); 
    %voltage_x = voltage(1, :);
    %voltage_y = voltage(2, :);
end