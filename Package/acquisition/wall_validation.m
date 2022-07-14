%% wall validation
function wall_validation(galvo_path, wall_path, proj_path, input_path)
    exposure = 500;
    channel = 4;
    load(strcat(galvo_path, '/galvo_parameters.mat'), 'epsilon', 'beta');
    load(strcat(wall_path, '/wall_parameters'), 'w', 'z_basis', 'coordinates')
    [coordinates_proj] = get_projection(coordinates, z_basis, w);
    X_proj = coordinates_proj(1, :);
    Y_proj = coordinates_proj(2, :);
    Z_proj = coordinates_proj(3, :);
    [distance_proj, theta_X_proj, theta_Y_proj] = get_theta_distance(X_proj, Y_proj, Z_proj);
    % compute voltages and delay
    [voltage_proj] = theta2voltage([theta_X_proj; theta_Y_proj], epsilon, beta);
    num_bin_proj = distance_proj * 2 / speed_light / time_bin;
    delay_proj = num_bin_proj*(time_bin/1e-12) + delay_offset;
    % save input
    save(strcat(proj_path,'/proj_input.mat'), 'voltage_proj', 'delay_proj');
    % save coordinates , coordinates_proj and error into parameters
    X = coordinates(1, :);
    Y = coordinates(2, :);
    Z = coordinates(3, :);
    displacement = sqrt((X_proj - X).^2 + (Y_proj - Y).^2 + (Z_proj - Z).^2);
    error = rms(displacement);
    save(strcat(proj_path, '/proj_parameters.mat'), 'coordinates', 'coordinates_proj', 'error');
    % save to input path
    voltage_x = voltage_proj(1,:);
    voltage_y = voltage_proj(2,:);
    if max(voltage_x,[],'all') > 9 || max(voltage_y,[],'all') > 9 || min(voltage_x,[],'all') < -9 || min(voltage_y,[],'all') < -9
        voltage_x = 0;
        voltage_y = 0;
        disp('warnning: voltage is too high!');
        return
    end
    delay = round(delay_proj);
    save(strcat(input_path, '/input_params.mat'), 'voltage_x', 'voltage_y', 'delay', 'exposure', 'channel');
    running_flag = fopen(strcat(input_path,'/running_flag.txt'),'wt');
    if if_nlos
        fprintf(running_flag, '2');
    else
        fprintf(running_flag, '1');
    end
    fclose('all');
end