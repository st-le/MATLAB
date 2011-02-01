% verify that findHpl_inf1(Image) and findHpl_inf2(Image) find the same Hpl_inf 

% sample points from fig1.6c.gif
P = [228 554 1
      443 343 1
      656 130 1
      445 555 1
      227 340 1
      122 235 1]';

  % transformed pts
Pp = [163 274 1
       329 153 1 
       435 71 1
       349 270 1 
       180 154 1
       119 113 1]';
   
Hndlt = nDLT(P,Pp)
   
%Hdlt = DLT(P,Pp)
% compare with simpler method:

%Hnaive = getH(P(1:2,1:4),Pp(1:2,1:4))

Hright = dlt2(P,Pp)

x = P(:,1);

myx1 = Hndlt * x ;
myx1 = myx1/myx1(3);
x1 = Hright * x;
x1 = x1/x1(3);

error = abs(x1-myx1)
