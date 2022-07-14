%% the loss for using w_X*X + w_Y*Y + w_Z*Z + 1 = 0 to model the relay wall
function [loss] = wall_loss(wall_parameters, X, Y, Z)
%     w_X = wall_parameters(1);
%     w_Y = wall_parameters(2);
%     w_Z = wall_parameters(3);
    w = wall_parameters(1);
    theta = wall_parameters(2);
    phi = wall_parameters(3);
    w_X = sin(theta)*cos(phi);
    w_Y = sin(theta)*sin(phi);
    w_Z = cos(theta);
    diff = (w_X*X + w_Y*Y + w_Z*Z + w);
    loss = sqrt(mean(diff.^2,'all'));
end