%% fromt galvo_settings to galvo_input
function [voltage_galvo] = galvo_setting_input(galvo_path)
    % load setting
    load(strcat(galvo_path, '/galvo_setting.mat'), 'num_galvo_0', 'num_galvo_1', 'voltage_x_min', 'voltage_x_max', 'voltage_y_min', 'voltage_y_max', 'exposure');
    % meshgrid voltage
    [voltage_x_galvo, voltage_y_galvo] = meshgrid(linspace(voltage_x_min, voltage_x_max, num_galvo_0), linspace(voltage_y_min, voltage_y_max, num_galvo_1));
    % reshape the voltage as row vector
    voltage_x_galvo = reshape(voltage_x_galvo, [1, num_galvo_0*num_galvo_1]);
    voltage_y_galvo = reshape(voltage_y_galvo, [1, num_galvo_0*num_galvo_1]);
    % package voltages
    voltage_galvo = [voltage_x_galvo; voltage_y_galvo];
    % save input
    save(strcat(galvo_path, '/galvo_input.mat'), 'voltage_galvo');
    % save to input path
    %voltage_x = voltage_galvo(1,:);
    %voltage_y = voltage_galvo(2,:);
    %save(strcat(input_path, '/input_params.mat'), 'voltage_x', 'voltage_y', 'exposure');
    %running_flag = fopen(strcat(input_path,'/running_flag.txt'),'wt');
    %fprintf(running_flag, '1');
    %fclose('all');
end