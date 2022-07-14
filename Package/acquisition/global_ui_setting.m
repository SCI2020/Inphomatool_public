%% fromt galvo_settings to galvo_input
function global_ui_setting()
    root = 'C:\Users\xxy\Desktop\Inphormatool\resources';
    % parameters
    speed_light = 3e8; % speed of light (in m/s)
    time_bin = 4e-12; % the time bin of picoharp (in s)
    r_freq = 39e6; % the laser repetition frequency (in Hz)
    num_bin = ceil(1/r_freq/time_bin); % the number of bin
    galvanometer_peak = 5000; % the peak in transients corresponding to galvanometer
    delay_offset = 2600+4000; % the peak of galvanometer
    %delay_offset = -5000;
    % load setting
    save(strcat(root, '/global_parameters.mat'), 'speed_light', 'time_bin', 'r_freq', 'num_bin', 'galvanometer_peak', 'delay_offset');
end