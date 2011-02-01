function y= lorenz(x)
n=length(x);z=0;
for i=1:n
    z=z+x(i);
    y(i)=z;
end