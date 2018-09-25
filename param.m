% Assign necessary constants and parameters
mu0 = 4*pi*10^-7;
rhow = 19.27*10^-9;                                 % R�sistivit� du cuivre [Ohm*m]
rhor = 28.85*10^-9;                                 % R�sistivit� de l'aluminium [Ohm*m]
btmax = 1.6;                                        % Densit� maximale de flux par encoche [T]
bymax = 1.3;                                        % Densit� maximale de flux dans le bo�tier [T]
% Assign desired values for certain variables
V1 = Vline/sqrt(3);                                 % Tension d'entr�e ligne (RMS) [V]
Vs = Vcrated/(1 - Srated);                          % Vitesse de synchronisme [m/s] (3.5/p.15-d�duit)
tau = Vs/(2*f);                                     % Pas polaire [m] (3.2/p.14-d�duit)
lambda = tau/(m*q1);                                % Pas d'encoche [m] (3.25/p.20)
Ls = p*tau;                                         % Longueur de la partie active du stator [m]
ws = lambda/2;                                      % Largeur d'une encoche [m] (Step (f)/p.41)
beta1 = 1;
go = gm + d;                                        % Entrefer magn�tique [m] (3.23/p.20)
% Data from the PCP design procedure