% Assign necessary constants and parameters
mu0 = 4*pi*10^-7;
rhow = 19.27*10^-9;                                 % Résistivité du cuivre [Ohm*m]
rhor = 28.85*10^-9;                                 % Résistivité de l'aluminium [Ohm*m]
btmax = 1.6;                                        % Densité maximale de flux par encoche [T]
bymax = 1.3;                                        % Densité maximale de flux dans le boîtier [T]
% Assign desired values for certain variables
V1 = Vline/sqrt(3);                                 % Tension d'entrée ligne (RMS) [V]
Vs = Vcrated/(1 - Srated);                          % Vitesse de synchronisme [m/s] (3.5/p.15-déduit)
tau = Vs/(2*f);                                     % Pas polaire [m] (3.2/p.14-déduit)
lambda = tau/(m*q1);                                % Pas d'encoche [m] (3.25/p.20)
Ls = p*tau;                                         % Longueur de la partie active du stator [m]
ws = lambda/2;                                      % Largeur d'une encoche [m] (Step (f)/p.41)
beta1 = 1;
go = gm + d;                                        % Entrefer magnétique [m] (3.23/p.20)
% Data from the PCP design procedure