clc
clear
close all
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
x_avg = mean(X);
y_avg = mean(Y);

R_s = (X-x_avg).*(X-x_avg) + (Y-y_avg).*(Y-y_avg);

mtx_2 = (im(:,:,1) ~=255);
[X2,Y2] = mtx_coordination(find(mtx_2 == 1),size(mtx));

r_square = (X2-x_avg).*(X2-x_avg) + (Y2-y_avg).*(Y2-y_avg);
sigma_square = sum(r_square)/length(r_square);


%% draw gaussian


A = 255*sqrt(2*pi*sigma_square)*exp(max(R_s)/(2*sigma_square));

x=linspace(-100,100,10000);
y=Gaussian(x.^2,sigma_square,A);
figure,plot(x,y)

%% simulation

[m,n] = size(mtx);
IM = zeros(m,n);

xxx = [1:n];
IM_x = repmat(xxx,[m,1]);
yyy = [1:m];
IM_y = repmat(yyy,[m,1])';

for i = 1:m
    for j = 1:n 
         r =  (IM_x(i,j)-x_avg).*(IM_x(i,j)-x_avg) + (IM_y(i,j)-y_avg).*(IM_y(i,j)-y_avg);
        IM(i,j) = Gaussian(r,sigma_square,A);
    end
end

figure,imshow(uint8(IM))

