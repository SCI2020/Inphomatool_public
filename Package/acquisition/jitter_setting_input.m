%% fromt jitter_settings to jitter_input
function [voltage_jitter] = jitter_setting_input(jitter_path, input_path)
    % load setting
    load(strcat(jitter_path, '/jitter_setting.mat'), 'num_jitter_0', 'num_jitter_1', 'voltage_x_min', 'voltage_x_max', 'voltage_y_min', 'voltage_y_max', 'exposure');
    % meshgrid voltage
    [voltage_x_jitter, voltage_y_jitter] = meshgrid(linspace(voltage_x_min, voltage_x_max, num_jitter_0), linspace(voltage_y_min, voltage_y_max, num_jitter_1));
    % reshape the voltage as row vector
    voltage_x_jitter = reshape(voltage_x_jitter', [1, num_jitter_0*num_jitter_1]);
    voltage_y_jitter = reshape(voltage_y_jitter', [1, num_jitter_0*num_jitter_1]);
    % package voltages
    voltage_jitter = [voltage_x_jitter; voltage_y_jitter];
    % save input
    save(strcat(jitter_path, '/jitter_input.mat'), 'voltage_jitter');
    % save to input path
    voltage_x = voltage_jitter(1,:);
    voltage_y = voltage_jitter(2,:);
    save(strcat(input_path, '/input_params.mat'), 'voltage_x', 'voltage_y', 'exposure');
    running_flag = fopen(strcat(input_path,'/running_flag.txt'),'wt');
    fprintf(running_flag, '1');
    fclose('all');
end