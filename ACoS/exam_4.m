function x = exam_4
dt = [pi/5, pi/10, pi/20];
u0s = [1 0 -1 0];
%Explicit Euler:
g1=1;g2=2;
n = (20*pi)./dt;
x(:,1) = u0s';
hold all;
for i=1:3
    for t=2:n(i)
        div1 = (x(1,t-1) - x(2,t-1)).^2 + (x(3,t-1) - x(4,t-1)).^2;    
        div2 = (x(2,t-1) - x(1,t-1)).^2 + (x(4,t-1) - x(3,t-1)).^2;
        x(1,t) = x(1,t-1) + dt(i) * (-g2)*(x(3,t-1) - x(4,t-1))/div1;
        x(2,t) = x(2,t-1) + dt(i) * (-g1)*(x(3,t-1) - x(4,t-1))/div2;
        x(3,t) = x(3,t-1) + dt(i) * (-g2)*(x(3,t-1) - x(4,t-1))/div1;
        x(4,t) = x(4,t-1) + dt(i) * (-g1)*(x(3,t-1) - x(4,t-1))/div2;
    end
    plot(1:n(i),x(1,:),1:n(i),x(2,:),1:n(i),x(3,:),1:n(i),x(4,:));
end
