% % tic_z = linspace(0,range./2,size(vol,1));
% width = 0.5;
% tic_y = linspace(width,-width,size(vol,2));
% tic_x = linspace(width,-width,size(vol,3));
% 
% % clip artifacts at boundary, rearrange for visualization
% % vol(end-10:end, :, :) = 0;
% vol = permute(vol, [1, 3, 2]);
vol = permute(vol, [2, 1, 3]);
% %     result = permute(vol, [2, 3, 1]);
% vol = flip(vol, 2);
% vol = flip(vol, 3);
% % result = vol;

% vol = vol * 1.2;
    % View result
    figure
    imagesc(tic_x,tic_y,squeeze(max(vol,[],1)));
%     title('Front view');
%     set(gca,'XTick',linspace(min(tic_x),max(tic_x),3));
%     set(gca,'YTick',linspace(min(tic_y),max(tic_y),3));
%     xlabel('x (m)');
%     ylabel('y (m)');
set(gcf,'color','black');
set(gcf, 'InvertHardCopy', 'off');
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
    colormap('gray');
%     axis square;