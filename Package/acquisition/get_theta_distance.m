%% calculate the theta_X, theta_Y and distances from coordinates
function [distances, theta_X, theta_Y] = get_theta_distance(X, Y, Z)
    theta_X = atan(X ./ Z);
    theta_Y = atan(Y ./ Z);
    distances = sqrt(X.^2 + Y.^2 + Z.^2);
end