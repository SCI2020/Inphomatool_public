%% compute the origin coordinates, based on finding the intersection of line and plane
function [data] = enhance_setting_data(root, enhance_path, jitter_path)
    load(strcat(root, '/global_parameters.mat'), 'speed_light', 'time_bin', 'num_bin', 'galvanometer_peak');
    load(strcat(enhance_path, '/enhance_setting.mat'), 'los_path', 'nlos_path', 'threshold_0', 'threshold_1', 'if_denoise', 'SNR', 'if_traditional');
    load(strcat(los_path, '/meas_output.mat'), 'data');
    data_0 = data;
    load(strcat(nlos_path, '/meas_output.mat'), 'data');
    data_1 = data;
    [data, Gamma] = enhance_shift(data_1, data_0, false, galvanometer_peak, num_bin, threshold_0, threshold_1);
    if 1%if_deGamma
        % eliminate the Gamma effect
        Gamma = Gamma / geomean(Gamma, 'all');
        %Gamma_threshold = 0.5; % 0.5 is an empirical parameters
        %Gamma(Gamma < Gamma_threshold) = 1;
        data = data ./ Gamma;
    end
    if if_denoise
        % Wiener filter
        load(strcat(jitter_path, '/jitter_parameters.mat'), 'mu', 'sigma', 'kappa_0', 'kappa_1', 'gamma', 't_0', 'b');
        T = 1:4096;
        data = data(:, T);
        data = enhance_deconvolution(data, T, mu, sigma, kappa_0, kappa_1, gamma, t_0, b, SNR);
    end
    if if_traditional
         % 3D data
        T = 1:4096;
        data = data(:, T);
        num_pix = sqrt(size(data, 1));
        data = reshape(data, [num_pix, num_pix, 4096]);
        load(strcat(los_path, '/meas_setting.mat'), 'scale');
        wall_size = scale;
        save(strcat(enhance_path, '/enhance_data.mat'), 'data', 'speed_light', 'time_bin', 'wall_size');
    else
        % 2D data
        load(strcat(los_path, '/meas_parameters.mat'), 'coordinates', 'positions');
        save(strcat(enhance_path, '/enhance_data.mat'), 'data', 'speed_light', 'time_bin', 'coordinates', 'positions');
    end
end