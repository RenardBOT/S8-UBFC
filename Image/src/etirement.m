function [Iout] = etirement(path)
% ETIREMENT étire l'histogramme sur la plage [0;255]
% Possible d'affecter la nouvelle image à une variable
% en appelant par exemple I = etirement(chemin)

% Lecture de l'image
I = imread(path);

% Identification des niveaux de gris maximum et minimum
Imax = max(max(I));
Imin = min(min(I));

% Calcul de l'étirement dans la matrice sortie Iout 
Iout = uint8(floor(255*double((I-Imin))/double(Imax-Imin)));

% Phase d'affichage
figure;

% Affichage de l'image originale et de l'image étirée
subplot(3,2,1);
imshow(I)
subplot(3,2,2);
imshow(Iout);

% Affichage de l'histograme de l'image originale et de l'image étirée
subplot(3,2,3);
histogram(I,255,'BinLimits',[0 255])
subplot(3,2,4);
histogram(Iout,255)

% Affichage de l'histogramme cumulé de l'image originale et de l'image
% étirée
subplot(3,2,5);
histogram(I,255,'Normalization','cumcount','BinLimits',[0 255])
subplot(3,2,6);
histogram(Iout,255,'Normalization','cumcount')

end