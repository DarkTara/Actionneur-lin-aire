% Affichage des courbes

% figure Fs(Vr)
figure(1);
subplot(2,2,1); %*******************************************
plot(vel_rot,Force,'green');
xlabel('Rotor Velocity, V_{r} (m/s)');
ylabel('Thrust, F_{s} (N)');
hold on;
hold on;
plot([Vcrated Vcrated],[0,Fs]);
hold on;
plot([0 Vcrated],[Fs Fs]);
hold on;
grid on;
% figure eta(Vr)
% figure(2);
subplot(2,2,2); %*******************************************
plot(vel_rot,eff*100,'green');
xlabel('Rotor Velocity, V_{r} (m/s)');
ylabel('Efficiency, \eta (%)');
hold on;
plot([Vcrated Vcrated],[0 eta*100]);
hold on;
plot([0 Vcrated],[eta*100,eta*100]);
hold on;
grid on;
% figure Fs(slip)
% figure(3);
subplot(2,2,3); %*******************************************
plot(slipM,Force);
xlabel('Slip, G');
ylabel('Thrust, F_{s} (N)');
hold on;
hold on;
% plot([Vcrated Vcrated],[0,Fs]);
hold on;
% plot([0 Vcrated],[Fs Fs]);
hold on;
grid on;

ind = find(vel_rot >= Vcrated, 1, 'last');
Tlw = m*para_wires(jj)*2*(Ws+Lce)*N1;
hy = height_yoke(jj);
hs = height_slot(jj);
wt = tooth_width(jj);
wtmin = min_toothwidth(jj);
Wcopper = pi*(A(jj,2)/2/1000)^2*Tlw*8920; % Masse volumique du cuivre : 8920 kg/m^3
Viron = Ws*(Ls*hy+(m*p*q1)*hs*wt);
Wiron = Viron*7860;
Wstator = Wiron+Wcopper;
As = Area_slot(jj);
Awt = Area_wire(jj)*Nc;
ws = slot_width(jj);
Pout = output(jj);
Pin = input(jj);
Fs = final_thrust(jj);
eta = efficiency(jj);
I1 = Sta_I(jj);
Dw = A(jj,2);
Np = para_wires(jj);
J1p = current_den(jj);
Finit = Force(end);


% figure;
subplot(2,2,4); %*******************************************
hold on;
couleur_encoches = [0.58 0.58 0.58];
rectangle('Position', [0 0 wt/2 hs+hy], 'FaceColor', couleur_encoches, 'EdgeColor', couleur_encoches);
rectangle('Position', [wt/2 0 ws hy], 'FaceColor', couleur_encoches, 'EdgeColor', couleur_encoches);
rectangle('Position', [ws+wt/2 0 wt hs+hy], 'FaceColor', couleur_encoches, 'EdgeColor', couleur_encoches);
rectangle('Position', [ws+3*wt/2 0 ws hy], 'FaceColor', couleur_encoches, 'EdgeColor', couleur_encoches);
rectangle('Position', [2*ws+3*wt/2 0 wt hs+hy], 'FaceColor', couleur_encoches, 'EdgeColor', couleur_encoches);
rectangle('Position', [2*ws+5*wt/2 0 ws hy], 'FaceColor', couleur_encoches, 'EdgeColor', couleur_encoches);
rectangle('Position', [3*ws+5*wt/2 0 wt/2 hs+hy], 'FaceColor', couleur_encoches, 'EdgeColor', couleur_encoches);
rectangle('Position', [0 hs+hy+gm 3*ws+3*wt d], 'FaceColor', couleur_encoches, 'EdgeColor', couleur_encoches);
grid on;
set(gca,'layer','top');
hold off;
