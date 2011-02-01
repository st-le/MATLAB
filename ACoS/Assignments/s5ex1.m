function s5ex1
f = inline('exp(-100*(x^2))');
Iex = 0.0886226925452760; %calculated with maple
c = [1 2 3 4];
%the arguments of romberg are [1 2 3 4], because romberg produces 2^(n-1)
%intervals when the last two arguments are n and n.
for i = 2:2:8
    r(i/2) = romberg(0,1,f,c(i/2),c(i/2));
    g(i/2) = gaussquadrature(0,1,f,i);
end
r
g
%generate the absolute errors
for i=1:4
    gerror(i) = abs((Iex-g(i))/Iex);
    rerror(i) = abs((Iex-r(i))/Iex); 
end
x = [2 4 6 8];
c = [2 3 5 9];
%plot
plot(x,log(gerror(x/2)));
hold;
plot(c,log(rerror(x/2)),'r');