% find the corresponding x,y coordinate
function [X,Y] = mtx_coordination(a, mtx_size)

Y = floor(a/mtx_size(1))+1;
X = mod(a,mtx_size(1));

Y(X==0) = Y(X==0)-1;
X(X==0) =mtx_size(2) ;