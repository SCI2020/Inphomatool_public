%% compute the orthonormal basis for relay wall coordinates system
function [x_basis, y_basis] = wall_basis(z_basis)
    w_X = z_basis(1);
    w_Z = z_basis(3);
    x_basis = -sign(w_X) * [1/w_X, 0, -1/w_Z];
    x_basis = x_basis / norm(x_basis);
    tilt = deg2rad(-0);
    x_basis = x_basis + (1-cos(tilt)) * cross(z_basis, cross(z_basis,x_basis)) + sin(tilt) * cross(z_basis,x_basis);
    y_basis = cross(z_basis, x_basis);
end