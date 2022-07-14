%% Use Wiener Filter to denoise the SPAD data
function [transients] = enhance_deconvolution(data, T, mu, sigma, kappa_0, kappa_1, gamma, t_0, b, SNR)
    % generate jitter
    %T = 1:4096;
    jitter = time_jitter(T, mu, sigma, kappa_0, kappa_1, gamma, t_0, b);
    [~, shift_idx] = max(jitter);
    jitter = circshift(jitter,-shift_idx);
    % fft jitter
    jitter_fft = fft(jitter);
    G = (1./jitter_fft)./(1+(SNR*(jitter_fft).^2).^(-1));
    % legalization
    idx_nan = find(isnan(G));
    for k = 1:numel(idx_nan)
        idx = idx_nan(k);
        G(idx) = (G(idx-1) + G(idx+1)) / 2;
    end
    G(isnan(G)) = 0;
    % initialize transients
    transients = zeros(size(data));
    for n = 1:size(data, 1)
        % Use Wiener Filter to denoise
        data_n = data(n, :);
        data_n_fft = fft(data_n);
        transients_n_fft = data_n_fft.*G;
        transients_n = abs(ifft(transients_n_fft));
        transients(n, :) = transients_n;
    end
end
