function d = gander(x,y)
%computing divided differences
n=length(x)-1;

for i=1:n+1
    D(i,1)=y(i);
    for j = 1:(i-1)
        D(i,j+1)=(D(i,j)-D(i-1,j))/(x(i)-x(i-j));
    end
end
d=diag(D);