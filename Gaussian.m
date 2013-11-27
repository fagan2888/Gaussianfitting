function G=Gaussian(r,sigma_square,A)

G=A*(1/(sqrt(2*pi)*sqrt(sigma_square)))*exp(-r/(2*sigma_square));
