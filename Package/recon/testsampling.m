% M = 4; 
% % mtx = sparse([],[],[],M.^2,M,M.^2);
% mtx = zeros(M.^2,M);
%  x = 1:M.^2;
%  mtx(sub2ind(size(mtx),x,ceil(sqrt(x)))) = 1;
%  mtx  = spdiags(1./sqrt(x)',0,M.^2,M.^2)*mtx;
%  mtxi = mtx';
% 
%  K = log(M)./log(2);
%  for k = 1:round(K)
%      mtx  = 0.5.*(mtx(1:2:end,:)  + mtx(2:2:end,:));
%      mtxi = 0.5.*(mtxi(:,1:2:end) + mtxi(:,2:2:end));
%  end
 
U = 4;
V = 1;
slope = 0.2;
x = linspace(-1,1,2.*U);
y = linspace(-1,1,2.*U);
z = linspace(0,2,2.*V);
[grid_z,grid_y,grid_x] = ndgrid(z,y,x);

% Define PSF
psf = abs(((4.*slope).^2).*(grid_x.^2 + grid_y.^2) - grid_z);
psf = double(psf == repmat(min(psf,[],1),[2.*V 1 1]));
psf = psf./sum(psf(:,U,U));
psf = psf./norm(psf(:));
psf = circshift(psf,[0 U U]);