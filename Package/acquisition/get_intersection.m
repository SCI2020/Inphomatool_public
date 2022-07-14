%% compute the coordinates of selected direction to the point on the relay wall, based on finding the intersection of line and plane
function [coordinates] = get_intersection(theta, w, z_basis)
    theta_X = theta(1,:);
    theta_Y = theta(2,:);
    A = [z_basis; 1, 0, -tan(theta_X); 0, 1, -tan(theta_Y)];
    b = [-w; 0; 0];
    coordinates = A\b;
end