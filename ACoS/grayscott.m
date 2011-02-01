function [U V] = grayscott(Du,Dv,omega,omega_in,x_points,y_points,t_f,F,k)
%solving the Gray-Scott Differential Equation using Explicit Euler and
%second order Finite Differences in space
%omega is the domain, omega_in is the domain for the second boundary
%condition 

%TO DO: EXTEND THE PROGRAM SO THAT t_f MIGHT BE A VECTOR (IN GENERAL)
xstart = omega(1);
xend = omega(2);
ystart = omega(3);
yend = omega(4);
dx = abs(xend - xstart)/(x_points-1);
dy = abs(yend - ystart)/(y_points-1);
dt = ((5/6)*(dx^2))/(4*Du);
%number of time points
lim = t_f/dt;


%initialize U and V (matrices)
U = ones(256);
V = zeros(256);
%assign the initial conditions in omega_in using random noise
for i=117:138
    for j=117:138
        if rand > 0.5
            R = rand;
        else
            R = -rand;
        end                    
            U(i,j) = 0.5 + R/200;       
    end
end
for i=117:138
    for j=117:138
        if rand > 0.5
            R = rand;
        else
            R = -rand;
        end                    
            V(i,j) = 0.25 + R/400;      
    end
end

%start iterating
for t=1:lim
    
    u = U;
    v = V;
    for i=1:256
         
        for j=1:256
            %approximate the Laplacian of x with periodic boundary conditions
            if i == 1
                lux = (U(i+1,j) + U(256,j) - 2*U(i,j))/(2*(dx^2));
                lvx = (V(i+1,j) + V(256,j) - 2*V(i,j))/(2*(dx^2));
            elseif i == 256    
                lux = (U(1,j) + U(i-1,j) - 2*U(i,j))/(2*(dx^2));
                lvx = (V(1,j) + V(i-1,j) - 2*V(i,j))/(2*(dx^2));
            else
                lux = (U(i+1,j) + U(i-1,j) - 2*U(i,j))/(2*(dx^2));
                lvx = (V(i+1,j) + V(i-1,j) - 2*V(i,j))/(2*(dx^2));
            end
            %approximate the Laplacian of y with periodic boundary conditions
            if j == 1
                luy = (U(i,j+1) + U(i,256) - 2*U(i,j))/(2*(dy^2));
                lvy = (V(i,j+1) + V(i,256) - 2*V(i,j))/(2*(dy^2));
            elseif j == 256
                luy = (U(i,1) + U(i,j-1) - 2*U(i,j))/(2*(dy^2));
                lvy = (V(i,1) + V(i,j-1) - 2*V(i,j))/(2*(dy^2));
            else
                luy = (U(i,j+1) + U(i,j-1) - 2*U(i,j))/(2*(dy^2));
                lvy = (V(i,j+1) + V(i,j-1) - 2*V(i,j))/(2*(dy^2));
            end
            lu = lux + luy;
            lv = lvx + lvy;
            
            U(i,j) = u(i,j) + dt*(Du*lu - u(i,j)*(v(i,j)^2) + F*(1-u(i,j)));
            V(i,j) = v(i,j) + dt*(Dv*lv + u(i,j)*(v(i,j)^2) - (F+k)*v(i,j));

        end
        
    end
    
end



