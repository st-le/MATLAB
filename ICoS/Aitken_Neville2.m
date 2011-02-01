function [z] = Aitken_Neville2(x,y)
%Extrapolation von Pi mit Aitken Neville
%Mit Darstellung von U/2 durch n*sin(pi/n)
n = length(x);
T = zeros(n,n);
T(:,1) = y';
h = 1./x;
for i=1:n
    for j = 1:i-1
        T(i,j+1) = ((h(i).^2)*T(i-1,j)-(h(i-j).^2)*T(i,j))/((h(i).^2)-(h(i-j).^2));
    end
end
z = T(n,n);