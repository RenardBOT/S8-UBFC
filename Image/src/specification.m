function [Iout] = specification(path1,path2)
% ETIREMENT étire l'histogramme sur la plage [0;255]
% Possible d'affecter la nouvelle image à une variable
% en appelant par exemple I = etirement(chemin)

% Lecture de l'image
Iori = im2gray(imread(path1));
Iref = im2gray(imread(path2));

% Identification des niveaux de gris maximum et minimum
% Imax = max(max(I));
% Imin = min(min(I));
IHCori = histcounts(Iori,256,'Normalization','cumcount');
IHCref = histcounts(Iref,256,'Normalization','cumcount');


% Phase d'affichage
figure;

% Affichage de l'image originale et de l'image étirée
subplot(3,2,1);
imshow(Iori);
title('Image entrée');
subplot(3,2,2);
imshow(Iref);
title('Image sortie');

% Affichage de l'histograme de l'image originale et de l'image étirée
subplot(3,2,3);
histogram(Iori,255,'BinLimits',[0 255]);
title('Histogramme image entrée');
subplot(3,2,4);
histogram(Iref,255);
title('Histogramme image sortie');

% Affichage de l'histogramme cumulé de l'image originale et de l'image
% étirée
subplot(3,2,5);
histogram(Iori,255,'Normalization','cumcount','BinLimits',[0 255])
title('HCN image entrée');
subplot(3,2,6);
histogram(Iref,255,'Normalization','cumcount','BinLimits',[0 255])
title('HCN image sortie');

end