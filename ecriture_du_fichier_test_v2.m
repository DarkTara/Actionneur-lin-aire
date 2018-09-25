%% création du fichier text

% récupération du format de date et horaire de l'execution
time = datestr(now,'yyyy.mm.dd.T.HH.MM.SS.FFF');

% récupération de l'adressage du dossier courant
rep = pwd;

% concatenation avec le nom courant de stockage des fichiers tests
% la variable time_dossier est déclarée dans optim_bhamidi (main)
reptxt = strcat(rep,'\Archive des tests\Test',time_dossier,'\');

% création et ouverture du fichier text dans le répertoire de stockage
fId = fopen(strcat(reptxt,'test_',time,'.txt'), 'w');

%% création du tableau des données

fprintf(fId, '%s\n', repmat('*',1,40));
fprintf(fId, '%sINPUTS%s\n', repmat(' ',1,15), repmat(' ', 1, 20));
fprintf(fId, '%s\n', repmat('*',1,40));
fprintf(fId, '%40s\t%5s\t%16s\t%6s\n', 'Description', 'Symbol', 'Value', 'Unit');
fprintf(fId, '%40s\t%5s\t%16f\t%6s\n', 'Number of phases', 'm', m, '-');
fprintf(fId, '%40s\t%5s\t%16f\t%6s\n', 'RMS line-to-line voltage', 'Vline', Vline, 'V');
fprintf(fId, '%40s\t%5s\t%16f\t%6s\n', 'Electrical frequency', 'f', f, 'Hz');
fprintf(fId, '%40s\t%5s\t%16f\t%6s\n', 'Number of poles', 'p', p, '-');
fprintf(fId, '%40s\t%5s\t%16f\t%6s\n', 'Number of slots per pole per phase', 'q1', q1, '-');
fprintf(fId, '%40s\t%5s\t%16f\t%6s\n', 'Operational slip', 'S', Srated*100, '%');
fprintf(fId, '%40s\t%5s\t%16f\t%6s\n', 'Stator width', 'Ws', Ws, 'm');
fprintf(fId, '%40s\t%5s\t%16f\t%6s\n', 'Thickness of aluminium sheet', 'd', d, 'm');
fprintf(fId, '%40s\t%5s\t%16f\t%6s\n', 'Stator current density', 'J1', J1/1e6, 'A/mm²');
fprintf(fId, '%40s\t%5s\t%16f\t%6s\n', 'Target thrust', 'Fsprime', Fsprime, 'N');
fprintf(fId, '%40s\t%5s\t%16f\t%6s\n', 'Rated rotor velocity', 'Vr', Vcrated, 'm/s');
fprintf(fId, '%40s\t%5s\t%16f\t%6s\n', 'Physical air-gap', 'gm', gm, 'm');


fprintf(fId, '\n\n%s\n', repmat('*',1,40));
fprintf(fId, '%sOUTPUTS%s\n', repmat(' ',1,15), repmat(' ', 1, 20));
fprintf(fId, '%s\n', repmat('*',1,40));

fprintf(fId, '%s\t%40s\t%5s\t%16s\t%6s\n', 'No.', 'Description', 'Symbol', 'Value', 'Unit');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 1, 'Slots per pole per phase', 'q1', q1, '-');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 2, 'Yoke flux density ', 'bymax', bymax, 'Tesla');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 3, 'Tooth flux density', 'btmax', btmax, 'Tesla');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 4, 'Core width', 'Ws', Ws, 'm');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 5, 'SLIM Synchronous velocity', 'Vs', Vs, 'm/s');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 6, 'Rotor velocity', 'Vr', Vcrated, 'm/s');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 7, 'No of poles', 'p', p, '-');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 8, 'Pole pitch', 'tau', tau, 'm');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 9, 'Slot pitch', 'lambda', lambda, 'm');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 10, 'Stator length', 'Ls', Ls, 'm');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 11, 'Target thrust', 'Fs', Fsprime, 'N');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 12, 'Number of turns per slot', 'Nc', Nc, '-');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 13, 'Number of turns per phase', 'N1', N1, '-');
fprintf(fId, '%2d\t%40s\t%5s\t%16s\t%6s\n', 15, 'Copper wire size in winding', '-', sprintf('#%d', A(jj,1)), '-');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 16, 'Diameter without insulation', 'Dw', Dw, 'mm');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 17, 'Slot width', 'ws', ws, 'm');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 18, 'Tooth width', 'wt', wt, 'm');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 19, 'Minimum tooth width', 'wtmin', wtmin, 'm');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 20, 'Slot depth', 'hs', hs, 'm');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 21, 'Stator core yoke height', 'hy', hy, 'm');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 22, 'Actual thrust at specified Vr', 'Fs', Fs, 'N');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 23, 'Output power at specified Vr', 'Pout', Pout/1000, 'kW');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 24, 'Input power at specified Vr', 'Pin', Pin/1000, 'kW');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 25, 'Stator efficiency at specified Vr', 'eta', eta*100, '%');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 26, 'Actual rated stator RMS current', 'I1', I1, 'A');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 27, 'Parralel wires in one turn of winding', 'Np', Np, '-');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 28, 'Actual stator current density', 'J1', J1p/10^6, 'A/mm²');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 29, 'Area of slot', 'As', As*100^2, 'cm²');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 30, 'Total area of wire', 'Awt', Awt, 'cm²');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 31, 'Total length of copper wire', 'Tlw', Tlw, 'm');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 32, 'Total weight of copper wire', 'Wcopper', Wcopper, 'kg');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 33, 'Weight of iron core', 'Wiron', Wiron, 'kg');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 34, 'Total weight of one SLIM stator', 'Wstator', Wstator, 'kg');
fprintf(fId, '%2d\t%40s\t%5s\t%16f\t%6s\n', 35, 'Initial calculated thrust', 'Finit', Finit, 'N');

%% cloture du fichier text

fclose(fId);