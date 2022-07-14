%% generate uniformly distributed angles for wall calibration
function [voltage_wall] = wall_setting_input(jitter_path,galvo_path, wall_path, input_path)
    % load setting and requied parameters
    load(strcat(jitter_path, '/jitter_setting.mat'), 'voltage_x_min', 'voltage_x_max', 'voltage_y_min', 'voltage_y_max', 'exposure');
    load(strcat(galvo_path, '/galvo_parameters.mat'), 'beta', 'epsilon');
    load(strcat(wall_path, '/wall_setting.mat'), 'num_wall_0', 'num_wall_1');
    % meshgrid voltage
    %[voltage_x_wall, voltage_y_wall] = meshgrid(linspace(voltage_x_min, voltage_x_max, num_wall_0), linspace(voltage_y_min, voltage_y_max, num_wall_1));
    n_v=5;
    n_s=8;
    voltage_x_min = -n_v;
    voltage_x_max = n_v;
    voltage_y_min = -n_v;
    voltage_y_max = n_v;
    num_wall_0 = n_s;
    num_wall_1 = n_s;
    %[voltage_x_wall, voltage_y_wall] = random(n_v, n_s);
    [voltage_x_wall, voltage_y_wall] = meshgrid(linspace(voltage_x_min, voltage_x_max, num_wall_0), linspace(voltage_y_min, voltage_y_max, num_wall_1));
    % reshape voltages as row vectors
    voltage_x_wall = reshape(voltage_x_wall', [1, num_wall_0*num_wall_1]);
    voltage_y_wall = reshape(voltage_y_wall', [1, num_wall_0*num_wall_1]);
    % package voltages
    voltage_wall = [voltage_x_wall; voltage_y_wall];
    % save input
    save(strcat(wall_path, '/wall_input.mat'), 'voltage_wall');
    % save theta to setting
    theta_wall = voltage2theta(voltage_wall, epsilon, beta);
    save(strcat(wall_path, '/wall_setting.mat'), 'theta_wall', '-append');
    % save to input path
    voltage_x = voltage_wall(1,:);
    voltage_y = voltage_wall(2,:);
    save(strcat(input_path, '/input_params.mat'), 'voltage_x', 'voltage_y', 'exposure');
    running_flag = fopen(strcat(input_path,'/running_flag.txt'),'wt');
    fprintf(running_flag, '1');
    fclose('all');
end