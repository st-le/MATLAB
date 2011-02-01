function s7ex1dexplicit(dt)
%Applying implicit Euler to the sailing boat problem
A=[10 0; -0.3 0.2];
w = [10 3]';
n=ceil(15/dt);
y = [0 0]';
for t = 2:(n+1)
    y(:,t) = y(:,t-1) + dt*A*(w-y(:,t-1));
end
t=1:(n+1);
plot(t,y(1,:),t,y(2,:));