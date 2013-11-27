clc
clear
% close all
%% extract img
% impath = './pic/';
% imlist = dir([impath,'*.jpg']);
% for i = 1
%     f = imread([impath imlist(i).name]);
%     f = rgb2gray(f);
%     
%     imshow (f)
%     roi=f(1580:1620,1980:2020);
%     imwrite(roi,'test.bmp')
% end

%% Gaussian matching
im = imread('test.bmp');
figure,imshow(im)
mtx = (im(:,:,1) ==255);
[X,Y] = mtx_coordination(find(mtx == 1),size(mtx));
u = [ mean(X), mean(Y) ] ;

R_s = (X-u(1)).*(X-u(1)) + (Y-u(2)).*(Y-u(2));


% mtx_2 = (im(:,:,1) ~=255);
% [X2,Y2] = mtx_coordination(find(mtx_2 == 1),size(mtx));
% L = [X2 Y2] - repmat(u,[length(X2),1]);

mtx_2 = repmat([1:41],[41,1]);
Y2 = mtx_2(:);
X2=mtx_2';
X2=X2(:);
L = [X2 Y2] - repmat(u,[length(X2),1]);

sigma = L'*L/(length(X2)-1);


[~,index] = max(R_s);
X_l = [X(index) Y(index)];
A = 255*2*pi*det(sigma)^0.5*( exp(0.5*(X_l-u)*inv(sigma)*(X_l-u)') );

%%  simulation

[m,n] = size(mtx);
IM = zeros(m,n);

xxx = [1:n];
IM_x = repmat(xxx,[m,1]);
yyy = [1:m];
IM_y = repmat(yyy,[m,1])';

for i = 1:m
    for j = 1:n 
          IM(i,j) =Gaussian_2D(IM_x(i,j),IM_y(i,j),u,sigma,A);
    end
end


figure,imshow(uint8(IM))



 %% 3D plot
p=1:41;
q=1:41;
[P,Q]=meshgrid(p,q);
figure,mesh(P,Q,IM)

figure,mesh(P,Q,double(im))


figure,mesh(P,Q,double(im))
hold on 
mesh(P,Q,IM)
