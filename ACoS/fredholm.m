function phi = fredholm(n)
K = inline('3*(0.5*sin(3*x)-(t*((x)^2)))')
f = inline('pi*(x^2)')
%discretisize [0,pi] with n points
h = pi/(n-1);
x = zeros(1,n);
for i = 1:n
    x(i) = 0+(i-1)*h;
end
%fill the W matrix
for i=1:n
    for j=1:n
        W(i,j) = K(x(j),x(i));
    end
end
W = h*W;
for i=1:n
    fs(i) = f(x(i));
end
phi = (eye(n)-W)\(fs');
hold all;
plot(x,phi);
xs = [0:0.1:pi];
plot(xs,sin(3*xs));
