function [T t z] = diffusioneq(n,zmax,t_f,D)
%Solution of the Diffusion equation of the Wine Cellar Problem (HW09) using explicit Euler
%where n is the number of gridpoints over z
%note that t is in years and z in meters
%THERES SOME SMALL BUG IN HERE, BETTER USE NEW VERSION!!!
tic;
a = 12; b=10;
dz = zmax/n;
%take dt from the stability condition 
dt = (dz^2)/(2*D);
m = ceil(t_f/dt);
T=zeros(n,m);

%set the initial conditions
T(:,1)=a;
T(zmax,:)=a;
c=dt;
for i=2:m
    T(1,i) = a + b*sin(2*pi*c);
    c=c+dt;
end

%fill the matrix
for i=2:m
    for j=2:(n-1)
        T(j,i)=T(j,i-1) + dt*D*((T(j+1,i-1)+T(j-1,i-1)-2*T(j,i-1))./(dz^2));
    end
end
t=(1:m)/(m/t_f);
z=(1:n)/(n/zmax);
toc