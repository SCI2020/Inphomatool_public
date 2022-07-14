%% from meas_setting to meas_input
function [voltage_meas, delay_meas] = meas_setting_input(root, meas_path, galvo_path, wall_path, input_path)
    % load parameters
    load(strcat(root, '/global_parameters.mat'), 'speed_light', 'time_bin', 'delay_offset');
    load(strcat(galvo_path, '/galvo_parameters.mat'), 'epsilon', 'beta');
    load(strcat(meas_path, '/meas_setting.mat'), 'mode', 'voltage_x_origin', 'voltage_y_origin', 'num_pix_0', 'num_pix_1', 'scale', 'exposure', 'channel', 'if_nlos');
    load(strcat(wall_path, '/wall_parameters.mat'), 'w', 'x_basis', 'y_basis', 'z_basis');
    % compute the origin coordinates
    [theta_origin] = voltage2theta([voltage_x_origin; voltage_y_origin], epsilon, beta);
    [coordinate_origin] = get_intersection(theta_origin, w, z_basis);
    % generate scanning points
    [X_meas, Y_meas, Z_meas, x_meas, y_meas] = meas_scanning(mode, coordinate_origin, num_pix_0, num_pix_1, scale, x_basis, y_basis);
    [distance_meas, theta_X_meas, theta_Y_meas] = get_theta_distance(X_meas, Y_meas, Z_meas);
    % compute voltages and delay
    [voltage_meas] = theta2voltage([theta_X_meas; theta_Y_meas], epsilon, beta);
    num_bin_meas = distance_meas * 2 / speed_light / time_bin;
    delay_meas = num_bin_meas*(time_bin/1e-12) + delay_offset;
    % save input
    save(strcat(meas_path,'/meas_input.mat'), 'voltage_meas', 'delay_meas');
    % save coordinates and positions into parameters
    coordinates = [X_meas; Y_meas; Z_meas];
    positions = [x_meas; y_meas];
    save(strcat(meas_path, '/meas_parameters.mat'), 'coordinates', 'positions');
    % save to input path
    voltage_x = voltage_meas(1,:);
    voltage_y = voltage_meas(2,:);
    if max(voltage_x,[],'all') > 9.9 || max(voltage_y,[],'all') > 9.9 || min(voltage_x,[],'all') < -9.9 || min(voltage_y,[],'all') < -9.9
        plot(voltage_x);
        hold on
        plot(voltage_y);
        voltage_x = 0;
        voltage_y = 0;
        disp('warnning: voltage is too high!');
        return
    end
    delay = round(delay_meas);
    save(strcat(input_path, '/input_params.mat'), 'voltage_x', 'voltage_y', 'delay', 'exposure', 'channel');
    running_flag = fopen(strcat(input_path,'/running_flag.txt'),'wt');
    if if_nlos
        fprintf(running_flag, '2');
    else
        fprintf(running_flag, '1');
    end
    fclose('all');
end