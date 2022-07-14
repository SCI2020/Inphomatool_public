function demo(codepath, data_path, method)
saveimg = 0 ; 
%mapcolor = 'gray';
mapcolor = 'hot';
%% Run this demo script to step through the included reconstruction procedures
% Assumes MATLAB R2016b or higher (lower versions may work but have not
% been tested).
% addpath(codepath);
% addpath()
% addpath('../../D-LCT/nlos-dlct/matlab');
% First, run FBP, LCT, and f-k migration reconstructions for one of the
% captured datasets

% Optionally replace the below filenames with files from other scenes:
% bike, discoball, dragon, outdoor, resolution, statue, teaser
% load('bike/tof.mat');
% load('bike/meas_180min.mat');

% measlr = permute(data, [2 ,3 ,1]);
% data = permute(data,[2,3,1]);
% measlr = permute(data, [2, 3, 1]);
% measlr = data(:,:,1:2048);
% measlr = data;
% measlr(:,:,2048:end) = 0;
% size(measlr)
% wall_size = 2;
% measlr = data;
%%
%load data.mat
load(strcat(data_path, "/enhance_data.mat"));
% resize to low resolution to reduce memory requirements
data = permute(data,[2,1,3]);
data = data(:,:,1:min(size(data,3),4096));
%wall_size = width*2;
%for i = 1:1:64
%   for j = 1:1:i
%       %for k = 1:1:4096
%       %    data(i,j,k)=0;
%       %end
%       data(i,j,:)=zeros(1,1,4096);
%   end
%end

%data = reshape(data,32,32,4096);
measlr = imresize3(data, [64, 64, min(size(data,3),4096)], 'method','linear'); % y, x, t
%！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
% tofgridlr = imresize(tofgrid, [32, 32]); 
% wall_size = 2; % scanned area is 2 m x 2 m
% 
% %%
% bin_resolution = 32e-12; % Native bin resolution for SPAD is 4 ps
% % % c              = 3e8;    % Speed of light (meters per second)
% % % width = wall_size / 2;
% for ii = 1:size(measlr, 1)
%     for jj = 1:size(measlr,2 )
%         measlr(ii, jj, :) = circshift(measlr(ii, jj, :), [0, 0, -floor(tofgridlr(ii, jj) / (bin_resolution*1e12))]);
%     end
% end  
% 
% % meas = meas(:, :, 1:crop);
%%
% cameraGridPositions = zeros(3,256, 256);
% 
% for ii = 1:256
%     for jj = 1:256
%         cameraGridPositions(1, ii, jj) = -1 + (ii - 1) * 2 / 255;
%         cameraGridPositions(3, ii, jj) = -1 + (jj - 1) * 2 / 255;
%     end
% end
% 

%%
% cameraGridPositions = reshape(cameraGridPositions, [3, 65536]);
% deltaT = 32e-12 * 3e8;
% data = permute(measlr, [3, 1, 2]);
%%
tofgridlr = zeros(size(data,1));
%wall_size = 1;
for i = 1:1:2
     measlr = measlr(:,:,1:2:end) + measlr(:,:,2:2:end);
     time_bin = time_bin * 2;
 end
% run FBP
% fprintf('\nRunning FBP\n');
% algorithm = 0;
% fbp = cnlos_reconstruction(measlr, tofgridlr, wall_size, algorithm);

% % run LCT
if(method == "lct")
    fprintf('\nRunning LCT\n');
    algorithm = 1;
    lct = cnlos_reconstruction(measlr, tofgridlr, wall_size, algorithm);
elseif(method == "fk")
% run f-k migration
    fprintf('\nRunning f-k migration\n');
    algorithm = 2;
    fk = cnlos_reconstruction(measlr, tofgridlr, wall_size, algorithm);
elseif(method == "pf")
    % run phasor fields reconstruction by Liu et al.
    % (https://www.nature.com/articles/s41586-019-1461-3)
    fprintf('\nRunning phasor fields\n');
    algorithm = 3;
    pf = cnlos_reconstruction(measlr, tofgridlr, wall_size, algorithm);
else
    disp('method should be "lct", "fk" or "pf"');
end

% %% Reconstruct a frame from the interactive results
% % perform reconstruction and visualization for 32 x 32 resolution scene
% % captured at 4 Hz
% fprintf('\nReconstructing interactive results\n');
% 
% % this processes the frame, but it could also be directly loaded from the
% % preprocessed version in 'interactive/fk_32.mat'
% load('interactive/meas_32.mat');
% load('interactive/tof_32.mat');
% v = VideoReader('interactive/video_32.mov');
% 
% video_idx = 1400;
% frame_idx = 73;
% frame = squeeze(meas(frame_idx, :, :, :));
% crop = 1024; % crop measurements to 1024 bins
% cnlos_reconstruction(frame, tofgrid, wall_size, algorithm, crop);
% figure; imshow(read(v, video_idx),'InitialMagnification', 20); 
% title('Photo of interactive capture');
% clear v;

%% Run non-planar reconstruction
% reconstruction of a scene from a scanned non-planar surface
% fprintf('\nRunning non-planar reconstructions\n');
% nonplanar_reconstruction;

%% Run phase retrieval
% run the phase retrieval algorithm on one of the captured datasets
% fprintf('\nRunning phase-retrieval reconstruction\n');
% hio_reconstruction;

%% Run D-LCT
% fprintf('\nRunning D-LCT\n');
% scene = 'dragon'; % choose from 'rabbit', 'serapis', 'statue',' dragon'
% lambda = 2; % trade-off between fidelity and smoothness terms.
%                   % the paper uses lambda = 1.
% gamma  = 4.00000; % radiometric fall-off.
% sigmas = [2,2,2]; % downsample the transients by factors [sx,sy,st].
%                   % the paper uses sigmas = [1,1,1].
% 
% nlos = loaddata(scene);
% [pos, dir, vol] = dlct(nlos,lambda, gamma, sigmas);
% dims = size(dir);
% 
% if ~isnan(nlos.Depth) % use groundtruth mask
%     ind = imresize(~isinf(flipud(nlos.Depth)'),dims(1:2));
% else % create our own mask by e.g. thresholding
%     ind = dir(:,:,3) > 0.20*max(reshape(dir(:,:,3),[],1));
% end
% 
% % render directional-albedo
% figure;
% dlctplot(dir);
% 
% % render surface reconstruction
% figure;
% dlctsurf(pos,dir,ind,4,6);

%% show result
% bin_resolution = 4e-12; % Native bin resolution for SPAD is 4 ps
% c              = 3e8;    % Speed of light (meters per second)
% M = size(measlr,3);        % Temporal resolution of data
% range = M.*c.*bin_resolution; % Maximum range for histogram
% width = wall_size / 2;
% range_test = range./2;
% tic_z = linspace(0,range./2,size(lct,1));
% tic_y = linspace(width,-width,size(lct,2));
% tic_x = linspace(width,-width,size(lct,3));
% 
% figure
% subplot(1,5,1);
% imagesc(tic_x,tic_y,squeeze(max(fbp,[],1)));
% title('FBP');
% set(gca,'XTick',linspace(min(tic_x),max(tic_x),3));
% set(gca,'YTick',linspace(min(tic_y),max(tic_y),3));
% xlabel('x (m)');
% ylabel('y (m)');
% colormap('gray');
% axis square;
% 
% subplot(1,5,2);
% imagesc(tic_x,tic_y,squeeze(max(lct,[],1)));
% title('LCT');
% set(gca,'XTick',linspace(min(tic_x),max(tic_x),3));
% set(gca,'YTick',linspace(min(tic_y),max(tic_y),3));
% xlabel('x (m)');
% ylabel('y (m)');
% colormap('gray');
% axis square;
% 
% subplot(1,5,3);
% imagesc(tic_x,tic_y,squeeze(max(fk,[],1)));
% title('f-k');
% set(gca,'XTick',linspace(min(tic_x),max(tic_x),3));
% set(gca,'YTick',linspace(min(tic_y),max(tic_y),3));
% xlabel('x (m)');
% ylabel('y (m)');
% colormap('gray');
% axis square;
% 
% subplot(1,5,4);
% imagesc(tic_x,tic_y,squeeze(max(pf,[],1)));
% title('phasor');
% set(gca,'XTick',linspace(min(tic_x),max(tic_x),3));
% set(gca,'YTick',linspace(min(tic_y),max(tic_y),3));
% xlabel('x (m)');
% ylabel('y (m)');
% colormap('gray');
% axis square;
% 
% dims = size(dir);
% subplot(1,5,5);
% imagesc(dir(:,:,3));
% colormap(gray);
% title('D-LCT');
% set(gca,'XTick',linspace(min(tic_x),max(tic_x),3));
% set(gca,'YTick',linspace(min(tic_y),max(tic_y),3));
% xlabel('x (m)');
% ylabel('y (m)');
% axis square;
% pbaspect([dims(1:2),1]);

%%
% View result
bin_resolution = 4e-12; % Native bin resolution for SPAD is 4 ps
c              = 3e8;    % Speed of light (meters per second)
if(method == "lct")
    vol = lct;
elseif(method == "fk")
    vol = fk;
elseif(method == "pf")
    vol = pf;
else
    disp('method should be "lct", "fk" or "pf"');
end
%！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
M = size(vol,1);        % Temporal resolution of data
range = M.*c.*bin_resolution; % Maximum range for histogram
width = wall_size / 2;
range_test = range./2;
%tic_z = linspace(0,range./2,size(vol,1));
sum_vol = sum(sum(vol,3),2);
[sum_vol_max, sum_vol_argmax] = max(sum_vol);
[~, idx] = max(sum_vol(sum_vol_argmax:end) < sum_vol_max/10);
idx = idx + sum_vol_argmax - 1;
tic_z = (0:idx).*c.*bin_resolution;
tic_y = linspace(width,-width,size(vol,2));
tic_x = linspace(width,-width,size(vol,3));

if saveimg == -1
    figure('pos',[10 10 300 300]);
    ax_1 = subplot(1,1,1);
    imagesc(tic_x,tic_y,squeeze(max(vol,[],1)));
    set(gca,'visible','off')
    colormap(mapcolor);
    axis square;
    myAxes_1 = findobj(ax_1, 'Type', 'Axes');
    saveas(myAxes_1, strcat(data_path, '/', method, "_front_noboundary.jpg"))

    ax_2 = subplot(1,1,1);
    imagesc(tic_x,tic_z,squeeze(max(vol(1:idx,:,:),[],2)));
    set(gca,'visible','off')
    colormap(mapcolor);
    axis square;
    myAxes_2 = findobj(ax_2, 'Type', 'Axes');
    saveas(myAxes_2, strcat(data_path, '/', method, "_top_noboundary.jpg"))

    ax_3 = subplot(1,1,1);
    imagesc(tic_z,tic_y,squeeze(max(vol(1:idx,:,:),[],3))')
    set(gca,'visible','off')
    colormap(mapcolor);
    axis square;
    myAxes_3 = findobj(ax_3, 'Type', 'Axes');
    saveas(myAxes_3, strcat(data_path, '/', method, "_side_noboundary.jpg"))
elseif saveimg == 0
    figure('pos',[10 10 900 300]);
    subplot(1,3,1);
    imagesc(tic_x,tic_y,squeeze(max(vol,[],1)));
    title('Front view');
    set(gca,'XTick',linspace(min(tic_x),max(tic_x),3));
    set(gca,'YTick',linspace(min(tic_y),max(tic_y),3));
    xlabel('x (m)');
    ylabel('y (m)');
    colormap(mapcolor);
    axis square;

    subplot(1,3,2);
    imagesc(tic_x,tic_z,squeeze(max(vol(1:idx,:,:),[],2)));
    title('Top view');
    set(gca,'XTick',linspace(min(tic_x),max(tic_x),3));
    set(gca,'YTick',linspace(min(tic_z),max(tic_z),3));
    xlabel('x (m)');
    ylabel('z (m)');
    colormap(mapcolor);
    axis square;

    ax = subplot(1,3,3);
    imagesc(tic_z,tic_y,squeeze(max(vol(1:idx,:,:),[],3))')
    title('Side view');
    set(gca,'XTick',linspace(min(tic_z),max(tic_z),3));
    set(gca,'YTick',linspace(min(tic_y),max(tic_y),3));
    xlabel('z (m)');
    ylabel('y (m)');
    colormap(mapcolor);
    axis square;
    myAxes = findobj(ax, 'Type', 'Axes');
    saveas(myAxes, strcat(data_path, '/', method, ".jpg"))
elseif saveimg == 1
    ax_1 = subplot(1,1,1);
    imagesc(tic_x,tic_y,squeeze(max(vol,[],1)));
    title('Front view');
    set(gca,'XTick',linspace(min(tic_x),max(tic_x),3));
    set(gca,'YTick',linspace(min(tic_y),max(tic_y),3));
    xlabel('x (m)');
    ylabel('y (m)');
    colormap(mapcolor);
    axis square;
    myAxes_1 = findobj(ax_1, 'Type', 'Axes');
    saveas(myAxes_1, strcat(data_path, '/', method, "_front.jpg"))

    ax_2 = subplot(1,1,1);
    imagesc(tic_x,tic_z,squeeze(max(vol(1:idx,:,:),[],2)));
    title('Top view');
    set(gca,'XTick',linspace(min(tic_x),max(tic_x),3));
    set(gca,'YTick',linspace(min(tic_z),max(tic_z),3));
    xlabel('x (m)');
    ylabel('z (m)');
    colormap(mapcolor);
    axis square;
    myAxes_2 = findobj(ax_2, 'Type', 'Axes');
    saveas(myAxes_2, strcat(data_path, '/', method, "_top.jpg"))

    ax_3 = subplot(1,1,1);
    imagesc(tic_z,tic_y,squeeze(max(vol(1:idx,:,:),[],3))')
    title('Side view');
    set(gca,'XTick',linspace(min(tic_z),max(tic_z),3));
    set(gca,'YTick',linspace(min(tic_y),max(tic_y),3));
    xlabel('z (m)');
    ylabel('y (m)');
    colormap(mapcolor);
    axis square;
    myAxes_3 = findobj(ax_3, 'Type', 'Axes');
    saveas(myAxes_3, strcat(data_path, '/', method, "_side.jpg"))
else
    disp('saveimg should be 1 or 0 or -1');
end
%% show model
% x = find(fk < 0.1);
% fk(x) = 0;
% [test, test_index ] = max(fk,[],1);
% 
% [k, m, n] = size(test_index);
% fk_pc = [];
% fk_pc_counter = 1;
% for i = 1:m
%     for j = 1:n
%         if test(1,i,j) > 0
%             fk_pc(fk_pc_counter, 3) = i*wall_size/m+(-wall_size/2);
%             fk_pc(fk_pc_counter, 2) = j*wall_size/n+(-wall_size/2);
%             fk_pc(fk_pc_counter, 1) = test_index(1, i, j)/512*(range_test/4);
%             fk_pc_counter = fk_pc_counter + 1;
%         end
%     end
% end
% 
% plyWrite('fk.ply',fk_pc);
% 
% fk_success = vol2pc(fk,'fk.ply');
% fk_pt = pcread('fk.ply');
% 
% lct_success = vol2pc(lct,'lct.ply');
% lct_pt = pcread('lct.ply');
% 
% d_lct_success = vol2pc(dir,'d-lct.ply');
% dlct_pt = pcread('d-lct.ply');

% figure;
% subplot(1,3,1);
% title('f-k')s;
% pcshow(fk_pt);
% 
% subplot(1,3,2);
% title('lct');
% pcshow(lct_pt);
% 
% subplot(1,3,3);
% title('d-lct');
% pcshow(dlct_pt);

% fk1 = squeeze(fk(1,:,:));
% fk1 = fk(256,:,:);

%%
% lct = permute(data, [2, 1, 3]);
% lct = lct / max(max(max(lct)));
% index = lct > 0.2;
% lct(index) = 1;
% index2 = lct < 1;
% lct(index2) = 0;
end