function  [z] = Aitken_Neville1(x,y)
%Extrapolation von Pi mit Aitken Neville
%Wir lassen n gegen inf, d.h. den Diskretisierungsparameter h=1/n gegen 0 laufen.
n = length(x);
T = zeros(n,n);
T(:,1) = y';
h = 1./x;
for i=1:n
    for j = 1:i-1
        T(i,j+1) = (h(i)*T(i-1,j)-h(i-j)*T(i,j))/(h(i)-h(i-j));
    end
end
z = T(n,n);