% verify that findHpl_inf1(Image) and findHpl_inf2(Image) find the same Hpl_inf 

% sample points from fig1.6c.gif
P1 = [228 554
      443 343
      656 130]';

P1t = [163 274 
       329 153 
       435 71 ]';
  
P2 = [445 555
      227 340
      122 235]'; 
   
P2t = [349 270 
       180 154
       119 113]';
   
[l1, R1] = findHpl_inf1( 'fig1.6c.gif');
   
[l2, R2] = findHpl_inf2( 'fig1.6c.gif', P1, P1t, P2, P2t );


