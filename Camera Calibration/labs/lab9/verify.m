% verify that findHpl_inf1(Image) and findHpl_inf2(Image) find the same Hpl_inf 
clc

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

HMLE = find_MLE_H(P,Pp,0.001)

x = P(:,1);

x1ndlt = Hndlt * x;
x1ndlt = x1ndlt/x1ndlt(3)
myx1 = HMLE * x;
myx1 = myx1/myx1(3)


