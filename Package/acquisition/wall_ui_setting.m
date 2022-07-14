%% generate uniformly distributed angles for wall calibration
function wall_ui_setting(wall_path)
    % save setting
    num_wall_0 = 8;
    num_wall_1 = 8;
    exposure = 0.1 * 1e-3;
    distance_threshold_0 = 0.5;
    distance_threshold_1 = 2;
    luminance_threshold_0 = 500;
    luminance_threshold_1 = 1500;
    save(strcat(wall_path, '/wall_setting.mat'), 'num_wall_0', 'num_wall_1', 'exposure', 'distance_threshold_0', 'distance_threshold_1', 'luminance_threshold_0', 'luminance_threshold_1');
end