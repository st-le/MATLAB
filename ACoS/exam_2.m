function exam_2
f1 = inline('1/(1+(x^2)/((0.1)^2))');
f2 = inline('1/(1+(x^2))');
[I2 T2] = romberg(0,1,f2,16,16);
[I1 T1] = romberg(0,1,f1,16,16);
n = length(I1);
Iex2 = pi/4;
Iex1 = 0.1471127674;
plot(1:n,log(abs((Iex1-I1)/Iex1)),1:n,log(abs((Iex2-I2)/Iex2)))