
function G=Gaussian_2D(x,y,u,sigma,A)
k=[x,y];
G=A/((2*pi)*sqrt(det(sigma)))*exp(-0.5*(k-u)*inv(sigma)*(k-u)');
