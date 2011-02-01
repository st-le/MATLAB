function [d5 d7] = exercise1_2
%N=5
x = zeros(1,5);
y = zeros(1,5);
%creating the x_k for N=5
for k=1:5
    x(k) = -1 + (2*(k-1))./(5-1);
end
x5 = x;
%creating the y_k for N=5
for i = 1:5
    y(i) = exp(x(i));
end
z = linspace(x(1),x(5),100);
[d5 v5] = divdiff(x,y,z);

%N=7
x = zeros(1,7);
y = zeros(1,7);
%creating the x_k for N=7
for k=1:7
    x(k) = -1 + (2*(k-1))./(7-1);
end
%creating the y_k for N=7
for i = 1:7
    y(i) = exp(x(i));
end
[d7 v7] = divdiff(x,y,z);

plot(z,exp(z),'g',z,v5,'r+',z,v7,'b.');


%Interpolation error
plot(z,abs(v5-exp(z)),'r+',z,abs(v7-exp(z)),'go');
