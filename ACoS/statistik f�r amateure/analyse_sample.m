function [am gm d var sv] = analyse_sample(x)
%calculate the arithmetic and geometric mean, the variance, standard
%deviation and the mean of the absolute deviation of xm of a sample x
n=length(x);
am = sum(x)/n;
gm = prod(x)^(1/n);
d=sum(abs(x-am))/n;
var = sum((x-am).^2)/n;
sv = sqrt(var);