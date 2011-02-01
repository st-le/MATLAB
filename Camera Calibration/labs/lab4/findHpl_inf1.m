function [Hp_linf, G] = findHpl_inf1(Iloc)
% algorithm no.1 to find Hp(l_inf) 

% predefined points
P1 = [163 274 1
      435 71  1 
      257 355 1
      513 105 1];
  
P2 = [349 270 1
      25 48 1
      416 201 1
      93 20 1
        ];

% first intersection with l_inf    
l1 = cross(P1(1,:), P1(2,:));
l2 = cross(P1(3,:), P1(4,:));
    
x1 = cross(l1,l2);
    
% second intersection with l_inf
l3 = cross(P2(1,:), P2(2,:));
l4 = cross(P2(3,:), P2(4,:));
    
x2 = cross(l3,l4);
    
% a line is made up by two points -> Hp(l_inf) = x1 >< x2
Hp_linf = cross(x1,x2);
Hp_linf = Hp_linf/Hp_linf(3);
l1 = Hp_linf(1); l2 = Hp_linf(2); l3 = Hp_linf(3);
    
Hi = [   1      0     0
         0      1     0
      -l1/l3 -l2/l3  1/l3];
 
G = rectification(Hi,Iloc);
 
 