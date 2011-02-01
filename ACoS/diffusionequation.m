function [T_res, D_res, M] = diffusionequation(D,a,b,tau,zmax,tmax,N,times,depths)

% Input     - f is the function 
%           - a and b are the left and right endpoints
%
% Output    - R stützstellen
%           - Q Funktionswerte 
%
% Info:      Calculates


Tz0 = @(t) a + b*sin(2*pi*t/tau);

%step sizes
dz = zmax /(N-1);
dzdz = dz*dz;
dtmax = dz^2/(2*D); %upper bound of dt
dt = dtmax * 0.75; %how much smaller should we set dt?

M = ceil(tmax / dt); % m number of intervals
dt = tmax / (M - 1); %recalculate dt with choosen m


T_res = ones(N,length(times)); %values at all depths at fixed times
D_res = ones(M, length(depths)); %values at all times at fixed depths
D_i = 1;
T_i = 1;
%Boundary Conditions
Temp_old = a*ones(N,1); %Vector with values at all depths at previous time

t = 0;
Temp = ones(N,1);
Temp(1) = Tz0(t);

% Propagation in time
t = t + dt;
while (t <= tmax)
    Temp(1) = Tz0(t);
    for i = 2 : N-1
        old_i = Temp_old(i);
        f = D * (Temp_old(i+1) - 2*old_i + Temp_old(i-1)) / dzdz; %space discretization with finite Differences
        Temp(i) = old_i + dt * f; %explicit Euler
    end
    Temp(N) = Temp(N-1);

    %zwischen speichern
    %fixdepths
    ds = ceil(1/dz*depths)+1;
    for k=1:length(depths)
        d = ds(k);
        D_res(D_i,k) = Temp(d);
    end
    D_i = D_i + 1;
    
    %fixtime right now?
    if T_i <= length(times) && abs(times(T_i)-t) < dt
        T_res(:,T_i) = Temp;
        T_i = T_i + 1;
    end
    Temp_old = Temp;
    t = t + dt;
end
    