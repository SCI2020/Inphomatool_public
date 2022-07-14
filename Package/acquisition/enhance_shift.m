
%% % shift the data_1 (per pixel) so that its first bin matches with the peak in data_0
function [data, Gamma] = enhance_shift(data_1, data_0, if_los, galvanometer_peak, num_bin, threshold_0, threshold_1)
% for los measurements, set if_los = true. data_1 should be the wall data, and
% data_0 should be galvanometer data
% for nlos measurements, set if_los = false. data_1 should be the measured data,
% and data_0 should be wall data
    if size(data_1) ~= size(data_0)
        disp('the shape of data_1 and data_0 should be matched');
    else
        % initialize outputs
        data = zeros(size(data_1)); % output data
        Gamma = zeros(size(data_0)); % normalization coefficients
        for n = 1:size(data_1, 1)
            % process per pixel
            hist_0 = data_0(n, :);
            hist_1 = data_1(n, :);
            % process data_0
            if if_los
                % shield the peak of galvanometer
                threshold_tmp = galvanometer_peak - 1000;
                threshold_0_tmp = galvanometer_peak - 200;
                threshold_1_tmp = galvanometer_peak + 1000;
                if (threshold_tmp < 0) && (threshold_1_tmp > num_bin)
                    disp('warning: threshold_tmp is not valid, maybe the num_bin is too small');
                elseif (threshold_tmp < 0) && (threshold_0_tmp < 0) && (threshold_1_tmp <= num_bin)
                    threshold_tmp = threshold_tmp + num_bin;
                    threshold_0_tmp = threshold_0_tmp + num_bin;
                    hist_0(threshold_tmp:threshold_0_tmp) = 0;
                    hist_1(threshold_tmp:end) = 0;
                    hist_1(1:threshold_1_tmp) = 0;
                elseif (threshold_tmp < 0) && (threshold_0_tmp >= 0) && (threshold_1_tmp <= num_bin)
                    threshold_tmp = threshold_tmp + num_bin;
                    hist_0(threshold_tmp:end) = 0;
                    hist_0(1:threshold_0_tmp) = 0;
                    hist_1(threshold_tmp:end) = 0;
                    hist_1(1:threshold_1_tmp) = 0;
                elseif (threshold_tmp >= 0) && (threshold_0_tmp >= 0) && (threshold_1_tmp <= num_bin)
                    hist_0(threshold_tmp:threshold_0_tmp) = 0;
                    hist_1(threshold_tmp:threshold_1_tmp) = 0;
                elseif (threshold_tmp >= 0) && (threshold_0_tmp >= 0) && (threshold_1_tmp > num_bin)
                    threshold_1_tmp = threshold_1_tmp - num_bin;
                    hist_0(threshold_tmp:threshold_0_tmp) = 0;
                    hist_1(threshold_tmp:end) = 0;
                    hist_1(1:threshold_1_tmp) = 0;
                else
                    disp([threshold_tmp, threshold_0_tmp, threshold_1_tmp]);
                end
            else
                % shield the peak of galvanometer
                threshold_0_tmp = galvanometer_peak - 1000;
                threshold_1_tmp = galvanometer_peak + 1000;
                if (threshold_0_tmp < 0) && (threshold_1_tmp > num_bin)
                    disp('warning: threshold_tmp is not valid, maybe the num_bin is too small');
                elseif (threshold_0_tmp < 0) && (threshold_1_tmp <= num_bin)
                    threshold_0_tmp = threshold_0_tmp + num_bin;
                    hist_0(threshold_0_tmp:end) = 0;
                    hist_0(1:threshold_1_tmp) = 0;
                elseif (threshold_0_tmp >= 0) && (threshold_1_tmp <= num_bin)
                    hist_0(threshold_0_tmp:threshold_1_tmp) = 0;
                elseif (threshold_0_tmp >= 0) && (threshold_1_tmp > num_bin)
                    threshold_1_tmp = threshold_1_tmp - num_bin;
                    hist_0(threshold_0_tmp:end) = 0;
                    hist_0(1:threshold_1_tmp) = 0;
                else
                    disp([threshold_tmp, threshold_0_tmp, threshold_1_tmp]);
                end
                Gamma(n, :) = sum(hist_0);
            end
            % idx is the index of maximum in data_0_ij
            [~, idx] = max(hist_0);
            % shift array circularly so that the maximum in data_0_ij should be at the first bin
            hist = circshift(hist_1, -idx);
            % shield the peak of wall
            hist(1:threshold_0) = 0;
            hist(threshold_1:end) = 0;
            % assemble hist into data
            data(n, :) = hist;
        end
    end
end

