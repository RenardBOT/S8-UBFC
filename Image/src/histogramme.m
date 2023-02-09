function[]= histogramme(path,n)
%HISTOGRAMME affiche l'histogramme d'une image
%   Prend en paramètres le chemin d'une image & le nombre de subdivisions
%   de l'axe des abscisses (optionnel)

if nargin < 1
    disp("Il faut passer le chemin d'une image en paramètres")
    return;
end
if nargin < 2
    n = 256; % pour 255 intervalles
end

% Lecture, passage en NG, normalisation 
I1 = imread(path);
I1 = rgb2gray(I1);
I1 = rescale(I1,0,1);

% Comptage du nb d'occurences de chaque valeur en fonction du nb de
% subdivisions
H = histcounts(I1,n);

% Affichage et comparaison à l'histogramme
subplot(1,2,1);
bar(H);
title('Fonction histogramme')  
subplot(1,2,2);
imhist(I1);
title('Fonction imhist')  
end