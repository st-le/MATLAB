function I = simpadapt(f,a,b,epsilon)
%adaptive quadrature with simpson's rule
h = (b-a);
Q = simpson1D(a,b,f,h);
delta = abs((((16*(simpson1D(a,b,f,h/2) - Q)/15)-Q)))
if (delta > epsilon)
    h = (b-a)/2;
    I1 = simpadapt(f,a,a+h,epsilon);
    I2 = simpadapt(f,a+h,b,epsilon);
    I = I1+I2;
else
    I = Q;
end
