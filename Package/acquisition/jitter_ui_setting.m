%% fromt jitter_settings to jitter_input
function jitter_ui_setting(jitter_path)
    num_jitter_0 = 8;
    num_jitter_1 = 8;
    voltage_x_min = -5;
    voltage_x_max = 5;
    voltage_y_min = -5;
    voltage_y_max = 5;
    exposure = 0.1 * 1e3;
    % save setting
    save(strcat(jitter_path, '/jitter_setting.mat'), 'num_jitter_0', 'num_jitter_1', 'voltage_x_min', 'voltage_x_max', 'voltage_y_min', 'voltage_y_max', 'exposure');
end