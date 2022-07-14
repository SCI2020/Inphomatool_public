%% calculate the 2D positions (on the relay wall) from 3D coordinates with wall basis and origin
function [positions] = get_positions(coordinates, coordinates_origin, x_basis, y_basis)
    num = size(coordinates,2);
    coordinates_diff = coordinates - repmat(coordinates_origin, 1, num);
    rep_x_basis = repmat(x_basis', 1, num);
    rep_y_basis = repmat(y_basis', 1, num);
    positions = [dot(coordinates_diff, rep_x_basis); dot(coordinates_diff, rep_y_basis)];
end