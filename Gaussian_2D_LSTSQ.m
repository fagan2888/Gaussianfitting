clc
clear

im = imread('test.bmp');
% figure,imshow(im)
mtx = (im(:,:,1) ==255);
[X,Y] = mtx_coordination(find(mtx == 1),size(mtx));
u = [ mean(X), mean(Y) ] ;


mtx_2 = (im(:,:,1) ~=255);
[X2,Y2] = mtx_coordination(find(mtx_2 == 1),size(mtx));
L = [X2 Y2] - repmat(u,[length(X2),1]);

r_s =sum(L.*L,2);

A = [r_s';ones(1,length(r_s))]';
% 
im_L = log(double(im));

im_L =im_L(:);
D_L = im_L(find(mtx_2 == 1));
% 
% 
x = inv(A'*A)*A'*D_L
sigma = sqrt(-x(1)*2)
amp = exp(x(2))*sqrt(2*pi*sigma^2)

% M = [ones(1,length(X2));-0.5*L(:,1)'.^2;-L(:,1)'.*L(:,2)';-0.5*L(:,2)'.^2 ]';
% 
% x = inv(M'*M)*M'*D_L;
% 
%  
%  
%  sigma = inv([x(2) x(3);x(3) x(4)]);
% 
% amp = exp(x(1))*2*pi*sqrt(det(sigma));
% 
% 
% 
% %%  simulation

% [m,n] = size(mtx);
% IM = zeros(m,n);
% 
% xxx = [1:n];
% IM_x = repmat(xxx,[m,1]);
% yyy = [1:m];
% IM_y = repmat(yyy,[m,1])';
% 
% for i = 1:m
%     for j = 1:n 
%           IM(i,j) =Gaussian_2D(IM_x(i,j),IM_y(i,j),u,sigma,amp*2);
%     end
% end
% 
% 
% figure,imshow(uint8(IM))
% 
%  %% 3D plot
% p=1:41;
% q=1:41;
% [P,Q]=meshgrid(p,q);
% figure,mesh(P,Q,IM)
% 
% figure,mesh(P,Q,double(im))
% 
% 
% figure,mesh(P,Q,IM)
% hold on 
% mesh(P,Q,double(im))
