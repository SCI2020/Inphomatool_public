%% from meas_setting to meas_input
function meas_ui_setting(meas_path)
    mode = 'u'; %'mc'
    voltage_x_origin = -3;
    voltage_y_origin = 0.5;
    num_pix_0 = 64;
    num_pix_1 = 64;
    scale = 0.8;
    exposure = 10 * 1e-3;
    channel = 4;
    if_nlos = true;
    % save parameters
    save(strcat(meas_path, '/meas_setting.mat'), 'mode', 'voltage_x_origin', 'voltage_y_origin', 'num_pix_0', 'num_pix_1', 'scale', 'exposure', 'channel', 'if_nlos');
end