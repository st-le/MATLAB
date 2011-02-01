function s2_exercise_3_2
h = [1/16 1/32 1/64 1/128 1/256];
%functions
f1 = inline('exp(T+(theta/(pi/2)))');
f2 = inline('sqrt(1 - (T.^2) - (theta./(pi/2)).^2 + (T.^2)*((theta./(pi/2)).^2))');
%exact integrals
Iexf1 = pi/2 - pi*exp(1) + (pi/2)*exp(2);
Iexf2 = (pi^3)/32;
%errors
ef1trap = [abs(newtoncotes2D(1,17,0,1,0,(pi/2),f1)- Iexf1) abs(newtoncotes2D(1,33,0,1,0,(pi/2),f1)- Iexf1) abs(newtoncotes2D(1,65,0,1,0,(pi/2),f1)- Iexf1) abs(newtoncotes2D(1,129,0,1,0,(pi/2),f1)- Iexf1) abs(newtoncotes2D(1,257,0,1,0,(pi/2),f1)- Iexf1)]; 
%ef1simp = [abs(newtoncotes2D(2,17,0,1,0,(pi/2),f1)- Iexf1) abs(newtoncotes2D(2,33,0,1,0,(pi/2),f1)- Iexf1) abs(newtoncotes2D(2,65,0,1,0,(pi/2),f1)- Iexf1) abs(newtoncotes2D(2,129,0,1,0,(pi/2),f1)- Iexf1) abs(newtoncotes2D(2,257,0,1,0,(pi/2),f1)- Iexf1)];
%ef2trap = [abs(newtoncotes2D(1,17,0,1,0,(pi/2),f2)- Iexf2) abs(newtoncotes2D(1,33,0,1,0,(pi/2),f2)- Iexf2) abs(newtoncotes2D(1,65,0,1,0,(pi/2),f2)- Iexf2) abs(newtoncotes2D(1,129,0,1,0,(pi/2),f2)- Iexf2) abs(newtoncotes2D(1,257,0,1,0,(pi/2),f2)- Iexf2)];
%ef2simp = [abs(newtoncotes2D(1,17,0,1,0,(pi/2),f2)- Iexf2) abs(newtoncotes2D(1,33,0,1,0,(pi/2),f2)- Iexf2) abs(newtoncotes2D(1,65,0,1,0,(pi/2),f2)- Iexf2) abs(newtoncotes2D(1,129,0,1,0,(pi/2),f2)- Iexf2) abs(newtoncotes2D(1,257,0,1,0,(pi/2),f2)- Iexf2)];
%plot log(e) against log(h)
plot(log(h),log(ef1trap));
%plot(log(h),log(ef1simp));
%plot(log(h),log(ef2trap));
%plot(log(h),log(ef2simp));