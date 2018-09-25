%% Script principal de l'execution en optimisation

% nettoyage du Workspace
clear all; close all; clc;

%% Création du dossier contenant les fichiers text des resultats 

% récupération du format de date et horaire de l'execution
time_dossier = datestr(now,'yyyy.mm.dd.T.HH.MM.SS.FFF');

% récupération de l'adressage du dossier courant
rep_dossier = pwd;

% création du répertoire de stockage des fichiers text
mkdir(strcat(rep_dossier,'\Archive des tests\Test',time_dossier));

%% Déclaration des paramètres discrets
phase = [3];
poles = [5];
encoches = [1];

%% Optimisation

%Création de la matrice des résultats
res = sparse(length(phase)*length(poles)*length(encoches),13);

compt = 1;
for k = 1:length(phase)
    for i = 1:length(poles)
        for j = 1:length(encoches)
            [x,fval] = simulannealbnd(@forceBhamidi_v2,[3 480 150 5 1 0.5 0.3 0.01 20e6 3000 10 0.01],[phase(k) 300 50 poles(i) encoches(j) 0.3 0 0.001 6.10^6 3000 0 3],[phase(k) 600 300 poles(i) encoches(j) 0.99 1 0.1 20.10^6 6000 100 10]);
            res(compt,:) = [x,fval];
            compt = compt+1
        end
    end
end
full(res)            