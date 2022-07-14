%% compute theta from the galvanometer voltage, based on theta = epsilon + beta * voltage;
function [theta] = voltage2theta(voltage, epsilon, beta)
    %voltage = [voltage_x; voltage_y];
    theta = epsilon + beta * voltage;
    %theta_x = theta(1, :);
    %theta_y = theta(2, :);
end