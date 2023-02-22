function [Iout] = egalisation(path)
% EGALISATION égalise l'histogramme sur la plage [0;255]
% Possible d'affecter la nouvelle image à une variable
% en appelant par exemple I = egalisation(chemin)

% Lecture de l'image
I = im2gray(imread(path));

% Identification des niveaux de gris maximum et minimum
% Imax = max(max(I));
% Imin = min(min(I));
IHCN = histcounts(I,256,'Normalization','cdf');

% Calcul de l'égalisation dans la matrice sortie Iout 
[height,width] = size(I);

Iout = uint8(zeros([height,width]));
for y = 1:height
    for x = 1:width
        Iout(y,x) = uint8(floor(255*IHCN(I(y,x)+1)));
    end
end

% Phase d'affichage
figure;

% Affichage de l'image originale et de l'image égalisée
subplot(3,2,1);
imshow(I);
title('Image entrée');
subplot(3,2,2);
imshow(Iout);
title('Image sortie');

% Affichage de l'histograme de l'image originale et de l'image égalisée
subplot(3,2,3);
histogram(I,255,'BinLimits',[0 255]);
title('Histogramme image entrée');
subplot(3,2,4);
histogram(Iout,255);
title('Histogramme image sortie');

% Affichage de l'histogramme cumulé de l'image originale et de l'image
% égalisée
subplot(3,2,5);
histogram(I,255,'Normalization','cumcount','BinLimits',[0 255])
title('HCN image entrée');
subplot(3,2,6);
histogram(Iout,255,'Normalization','cumcount')
title('HCN image sortie');

end