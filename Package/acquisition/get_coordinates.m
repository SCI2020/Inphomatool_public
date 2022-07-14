%% calculate the X, Y, Z from theta_X, theta_Y and distances
function [X, Y, Z] = get_coordinates(distances, theta_X, theta_Y)
    Z = distances ./ sqrt(1 + tan(theta_X).^2 + tan(theta_Y).^2);
    X = Z .* tan(theta_X);
    Y = Z .* tan(theta_Y);
end