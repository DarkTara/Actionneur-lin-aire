function [vel_rot, Force, eff] = forceBhamidi_v2(INPUT)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VERSION DU 20 AVRIL 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Paramètres :
% m = Nombre de phases
% Vline = Tension maximale [V]
% f = Fréquence [Hz]
% p = Nombre de pôles
% q1 = Nombre d'encoches par phase
% Srated = Glissement estimé
% Ws = Largeur du stator [m]
% d = epaisseur du conducteur rotor [m]
% J1 = densité de courant[A/m²], ATTENTIOn au 10^6 (a rentrer : 6.10^6 A/m²)
% Fsprime = Effort cible [N]
% Vcrated = Vitesse du rotor estimée [m/s]
% gm = Entrefer mécanique [m]  
% ex:  [vel_rot, Force, eff] = forceBhamidi_v2([3, 480, 60, 4, 1, 0.1, 3.14, 0.003, 6, 8611, 10, 0.01]);

%% Déclaration des variables d'entrée

%Pour être optimisable, forceBhamidi_v2 nécessite un vecteur en entrée
m = INPUT(1,1);
Vline = INPUT(1,2);
f = INPUT(1,3);
p = INPUT(1,4);
q1 = INPUT(1,5);
Srated = INPUT(1,6);
Ws = INPUT(1,7);
d = INPUT(1,8);
J1 = INPUT(1,9);
Fsprime = INPUT(1,10);
Vcrated = INPUT(1,11);
gm = INPUT(1,12);

%% PARAMETERS
param;

%	Standard wire gauges	
A = dlmread('standard_wire_gauges.txt');

%% CALCULATION

for i = 1:30
    N1 = p*q1*i;                                            % Nombre de spires par phase
    ncos0 = 0.99;
    ncos1(i) = 1;
    while abs(ncos0 - ncos1(i))>0.0001
        I1prime = (Fsprime*Vcrated)/(m*V1*ncos0);           % Courant selon la RMS d'entrée [A] (3.15/p.18)
        Aw = I1prime/J1;                                    % Surface balayée par le fil pour un tour [m²] (3.32/p.21)
        As = (10*i*Aw)/7;                                   % Surface d'une encoche [m²] (3.30/p.21)
        hs = As/ws;                                         % Hauteur de l'encoche [m] (3.29/p.21)
        gamma = (4/pi)*(((ws/(2*go))*atan(ws/(2*go))) -log(sqrt(1 + ((ws/(2*go))^2)))); % Gamma [?] (3.26/p.20)
        kc = lambda/(lambda - gamma*go);                    % Coefficient de carter [?] (3.24/p.20)
        ge = kc*go;                                         % Entrefer équivalent [m] (3.22/p.19)
        kw = sin(pi/(2*m))/(q1*sin(pi/(2*m*q1)));           % Coefficient de spire [?] (3.7/p.16-déduit) 
        G = 2*mu0*f*tau^2/(pi*(rhor/d)*ge);                 % Facteur de goodness [?] (3.46/p.27)
        a=Ws/2;                                             % Demi-largeur du stator [m]
        ae=a+ge/2;                                          
        Lce=tau;                                            % Longueur de fin de connexion du fil [m]                                   
        lamda_s= (hs*(1+3*beta1))/(12*ws);
        lamda_e= (0.3*(3*beta1-1));
        lamda_d= 5*(ge/ws)/(5+4*(go/ws));
        %Equivalent Circuit Components
        R1(i)= rhow*(4*a+2*Lce)*J1*N1/I1prime;               % Résistance du stator par phase [Ohm] (3.71/p.32)
        a1(i)= lamda_s*(1+3/p)+lamda_d;                      
        b1(i)= lamda_e*Lce;
        X1(i)= 8*mu0*pi*f*((a1(i)*2*a/q1)+b1(i))*N1^2/p;     % Réactance de fuite par phase aux encoches du stator [Ohm] (3.72/p.32)
        Xm(i)= (48*mu0*pi*f*ae*kw*N1^2*tau)/(pi^2*p*ge);    % Réactance de magnétisation par phase [Ohm] (3.69/p.32)
        R2(i) = Xm(i)/G;                                    % Résistance du rotor par phase [Ohm] (3.70/p.32)
        Z(i)=R1(i)+j*X1(i)+((j*R2(i)*Xm(i))/Srated)/((R2(i)/Srated) + j*Xm(i)); % Impédance [Ohm] (4.14/p.47)
        I1(i) = V1/abs(Z(i));                               % RMS courant au stator [A] (4.16/p.47)
        I2(i) = j*I1(i)*Xm(i)/(R2(i)/Srated+j*Xm(i));       % Courant au rotor [A] (3.47/p.28-en module)
        Im(i) = I1(i) - I2(i);                              % Courant de magnétisation [A] (4.14/p.47-en module)
        %Actual TLIM Thrust
        Fs(i) = (m*abs(I1(i))^2*R2(i))/(((1/(Srated*G)^2)+1)*Vs*Srated);    % Effort de poussée total (3.75/p.33)
        diff(i) = Fs(i) - Fsprime;
        dmin = min(abs(diff));
        Pout = Fs*Vcrated;
        Pin=Pout+m*abs(I2(i))^2*R2(i)+m*abs(I1(i))^2*R1(i); % Puissance d'entrée [W] (3.52/p.29)
        eta = Pout/Pin;                                     % Rendement (3.54/p.29)
        PF = cos(angle(Z(i)));                              
        ncos1(i)=eta*PF;
        ncos0=(ncos0+ncos1(i))/2;
    end;
end;

k = 1;

while dmin~=abs(diff(k))
    k = k + 1;
end;

Nc = k;
N1 = p*q1*Nc;
Fs = Fs(k);
I1 = I1(k);
%A=[3    5.826;4   5.189;5 4.62;6  4.1148;7    3.665;8 3.2639;9    2.9057;10   2.588 ]; % Diamètres standards des fils [mm]
guage=0;

while (guage<8)
    guage=guage+1;
    pw = 0;
    r=0;
    wt = 1;
    wtmin= 0;
    g = 0 ; r = 0;
    while (wt-wtmin)>0.008
        r = r+1;                                                  % Compteur
        g = g+1;                                                  % Compteur
        wire_d = A(guage,2);                                      % Diamètre du fil [m]
        pw = pw + 1;                                            % Compteur
        ws = (wire_d*10^-3*pw) + 2.2*10^-3;                     % Largeur d'une encoche [m] (Step (f)/p.41)
        wt = lambda - ws;                                       % Surface balayée par le fil pour 
        Aw = pw*pi/4*wire_d^2*1e-6;                             % Surface balayée par le fil pour un tour [m²] (3.32/p.21)
        As = (10*Nc*Aw)/7;
        hs = As/ws;
        gm = 0.01;
        go = gm + d;
        gamma = (4/pi)*(((ws/(2*go))*atan(ws/(2*go)))-log(sqrt(1 + ((ws/(2*go))^2))));
        kc = lambda/(lambda - gamma*go);
        ge = kc*go;
        G = 2*mu0*f*tau^2/(pi*(rhor/d)*ge);
        kw = sin(pi/(2*m))/(q1*sin(pi/(2*m*q1)));
        a = Ws/2;
        ae = a+ge/2;
        Lce = tau;
        beta1 = 1;
        lamda_s = (hs*(1+3*beta1))/(12*ws);
        lamda_e = (0.3*(3*beta1-1));
        lamda_d = 5*(ge/ws)/(5+4*(go/ws));
        %Equivalent Circuit Components
        R1 = rhow*(4*a+2*Lce)*J1*N1/I1prime;
        a1 = lamda_s*(1+3/p)+lamda_d;
        b1 = lamda_e*Lce;
        X1 = 8*mu0*pi*f*((a1*2*a/q1)+b1)*N1^2/p;
        Xm = (48*mu0*pi*f*ae*kw*N1^2*tau)/(pi^2*p*ge);
        R2 = Xm/G;
        Z = R1+j*X1+(R2/Srated*j*Xm)/(R2/Srated+j*Xm);
        I1 = V1/abs(Z);
        I2 = j*I1*Xm/(R2/Srated+j*Xm);
        Im = I1-I2;
        wtmin = 2*sqrt(2)*m*kw*N1*abs(Im)*mu0*lambda/(pi*p*ge*btmax);
        delta = wt-wtmin;
    end;
    para_wires(guage) = pw;
    slot_width(guage) = ws;
    tooth_width(guage) = wt;
    min_toothwidth(guage) = wtmin;
    height_slot(guage) = hs;
    Area_wire(guage) = Aw;
    Area_slot(guage) = As;
    Sta_I(guage) = I1;
    current_den(guage) = abs(I1)/Aw;
    height_yoke(guage) = 4*sqrt(2)*m*kw*N1*abs(Im)*mu0*Ls/(pi*pi*p*p*ge*bymax);
    final_thrust(guage) = (m*abs(I1)^2*R2)/(((1/(Srated*G)^2)+1)*Vs*Srated);
    output(guage) = final_thrust(guage)*Vcrated;
    input(guage) = output(guage)+m*abs(I2)^2*R2+m*abs(I1)^2*R1;
    efficiency(guage) = output(guage)/input(guage);
    difference(guage) = final_thrust(guage)-Fsprime;
    diffmin(guage) = min(abs(difference));
end;
kk = min(diffmin);
jj = 1;
while kk~=abs(diffmin(jj))
    jj = jj + 1;
end;

%$$$ To Generate the Characteristic curves $$$
vel_sta = Vs;

e=1;
for slip=0.000001:0.01:1
    slipM(e) = slip;
    vel_rot(e) = vel_sta*(1-slip);
    impz(e) = R1+j*X1+(R2/slip*j*Xm)/(R2/slip+j*Xm);
    i1(e) = V1/abs(impz(e));
    i2(e) = j*i1(e)*Xm/(R2/slip+j*Xm);
    Force(e) = (m*(abs(i1(e)))^2*R2)/(((1/(slip*G)^2)+1)*vel_sta*slip);
    out_pow(e) = Force(e)*vel_rot(e);
    in_pow(e) = out_pow(e)+m*abs(i2(e))^2*R2+m*abs(i1(e))^2*R1;
    eff(e) = out_pow(e)/in_pow(e);
    e=e+1;
end;


%Force_max = max(Force) ;
%% Edition et affichage des documents caractérisant la machine

% Tracé des courbes caractéristiques de la machine
courbes_v2;

% Edition du fichier texte des caractéristiques techniques de la machine
ecriture_du_fichier_test_v2;

end