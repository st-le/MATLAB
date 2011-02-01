function s4ex1_2
K = inline('10*exp(-500*(x^2)) - 0.01/(((x+0.5)^2) + 0.001) + 5*cos(5*x)');
%scatter plot
[I x] = simpadapt(K,-1,1,10e-9,[]);
x = [x 1];
x1 = -1:0.01:1;
plot(-1:0.01:1,10*exp(-500*(x1.^2))-0.01./(((x1+0.5).^2)+0.001)+5*cos(5.*x1));
hold;
plot(x,10*exp(-500*(x.^2))-0.01./(((x+0.5).^2)+0.001)+5*cos(5.*x),'+r');
%generate the error
%simpson for eps = 10e-2, 10e-2.5 ... 10e-9
s = zeros(1,15);
Iex = -2.092002839958010; %calculated with maple
epsilon = zeros(1,15);
for i = 1:15
    epsilon(i) = 10^(-(2+0.5*(i-1)));
end
%ca(i): function evaluations for epsilon(i)
for i=1:15
    [v l ca(i)] = simpadapt(K,-1,1,epsilon(i),[]);
    s(i) = abs((v-Iex)/Iex);
end
plot(epsilon,s)
plot(log(ca),log(s),'r');
hold;
%composite simpson needs ca(i)/2 data points for ca(i) computations, if their number is uneven,
%make it even
for i=1:15
    y(i) = abs((simpson1D(-1,1,K,(ca(i)+mod(ca(i),2)-1)/2)-Iex)/Iex);
end
plot(log(ca),log(y));
 