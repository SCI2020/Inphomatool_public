%% fromt galvo_settings to galvo_input
function galvo_ui_setting(galvo_path)
    % parameters
    num_galvo_0 = 8;
    num_galvo_1 = 8;
    voltage_x_min = -5;
    voltage_x_max = 5;
    voltage_y_min = -5;
    voltage_y_max = 5;
    % load setting
    save(strcat(galvo_path, '/galvo_setting.mat'), 'num_galvo_0', 'num_galvo_1', 'voltage_x_min', 'voltage_x_max', 'voltage_y_min', 'voltage_y_max');
end