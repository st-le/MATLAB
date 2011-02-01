%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assignment 9
% 
% Wine cellar Problem - Diffusion Equation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
format long

tic;
%given values and functions
D   = 1.43 * 10^(-6) * 365*24*60*60; %[m^2/year]
a   = 12;             %[°C]
b   = 10;             %[°C]
tau = 1;              %[s] 1 year
zmax = 20;            %[m] 
tmax = 10;            %[year] 10 years

%n = 501;
N = 51;
times = [3 3.25 3.5 3.75 4];
depths = [2 3 4 5];

[T_res, D_res, M] = diffusionequation(D,a,b,tau,zmax,tmax,N,times,depths);
toc;


% Plot Temperature at fix time
figure(1)
for i=1:length(times)
    zs = linspace(0,zmax,N);
    Ts = T_res(:,i);
    plot(zs,Ts);
    hold all
end
XLABEL('depth [m]');
YLABEL('temperature [°C]');
TITLE('Temperature at fix time');
LEGEND('3y','3.25y','3.5y', '3.75y', '4y');

% Plot Temperature at fix depths
figure(2)
for i=1:length(depths)
    Ts = D_res(:,i);
    tt = linspace(0,tmax,M);
    plot(tt,Ts);
    hold all
end
XLABEL('time [year]');
YLABEL('temperature [°C]');
TITLE('Temperature at fix depths');
LEGEND('2m','3m','4m', '5m');
