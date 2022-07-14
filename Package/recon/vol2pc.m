function [success] = vol2pc(vol, name)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    bin_resolution = 32e-12; % Native bin resolution for SPAD is 4 ps
    c              = 3e8;    % Speed of light (meters per second)
    M = 2048;        % Temporal resolution of data
    range = M.*c.*bin_resolution; % Maximum range for histogram
    wall_size = 2;
    width = wall_size / 2;
    range_test = range./2;
%     tic_z = linspace(0,range./2,size(vol,1));
%     tic_y = linspace(width,-width,size(vol,2));
%     tic_x = linspace(width,-width,size(vol,3));

%     x = find(vol < 0.1);
%     vol(x) = 0;
    [test, test_index ] = max(vol,[],1);

    [k, m, n] = size(test_index);
    pc = [];
    pc_counter = 1;
    if strcmp(name, 'd-lct.ply')
        [m, n, k] = size(vol);
        
        for i = 1:m
            for j = 1:n
                    pc(pc_counter, 3) = vol(i,j,1);
                    pc(pc_counter, 2) = vol(i,j,2);
                    pc(pc_counter, 1) = vol(i,j,3);
                    pc_counter = pc_counter + 1;
            end
        end
    else
        for i = 1:m
            for j = 1:n
                if test(1,i,j) > 0
                    pc(pc_counter, 3) = i*wall_size/m+(-wall_size/2);
                    pc(pc_counter, 2) = j*wall_size/n+(-wall_size/2);
                    pc(pc_counter, 1) = test_index(1, i, j)/512*(range_test/4);
                    pc_counter = pc_counter + 1;
                end
            end
        end
    end

    plyWrite(name,pc);
    success = 1;
%     ptCloud = pcread('fk.ply');
%     figure;
%     pcshow(ptCloud);
end

