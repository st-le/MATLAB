function [d7 d11] = exercise1_3
%N=7
x = zeros(1,7);
y = zeros(1,7);
%creating the x_k for N=7
for k=1:7
    x(k) = -1 + (2*(k-1))./(7-1);
end
x7 = x;
%creating the y_k for N=7
for i = 1:7
    y(i) = 1./(1+25.*((x(i)).^2));
end
z = linspace(x(1),x(7),100);
[d7 v7] = divdiff(x,y,z);

%N=11
x = zeros(1,11);
y = zeros(1,11);
%creating the x_k for N=11
for k=1:11
    x(k) = -1 + (2*(k-1))./(11-1);
end
%creating the y_k for N=11
for i = 1:11
    y(i) = 1./(1+25.*((x(i)).^2));
end
[d11 v11] = divdiff(x,y,z);

plot(z,1./(1+25.*((z).^2)),'g',z,v7,'r+',z,v11,'b.');


%Interpolation error
plot(z,abs(v7-1./(1+25.*((z).^2))),'r+',z,abs(v11-1./(1+25.*((z).^2))),'go');
