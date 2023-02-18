function [Iout] = egalisation_octave(path)
% ETIREMENT étire l'histogramme sur la plage [0;255]
% Possible d'affecter la nouvelle image à une variable
% en appelant par exemple I = etirement(chemin)

% Lecture de l'image
I = (imread(path));

% Si l'image est en couleur, on la convertit en niveaux de gris
if ndims(I) == 3
    I = rgb2gray(I);
end


% Histogramme cumulé normalisé de l'image originale
[counts, edges]=histc(I(:), 0:255);
IHCN = cumsum(counts) / sum(counts);

% Calcul de l'égalisation dans la matrice sortie Iout 

[height,width] = size(I);
Iout = uint8(zeros([height,width]));
for y = 1:height
    for x = 1:width
        Iout(y,x) = uint8(floor(255*IHCN(I(y,x)+1)));
    end
end

% Histogramme cumulé normalisé de l'image de sortie
[countsOut, edgesOut]=histc(Iout(:), 0:255);
IHCNout = cumsum(countsOut) / sum(countsOut);

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
[countsIn, edgesIn] = hist(I(:), 0:255);
bar(edgesIn, countsIn, "hist");
title('Histogramme image entrée');
subplot(3,2,4);
[countsOut, edgesOut] = hist(Iout(:), 0:255);
bar(edgesOut, countsOut, "hist");
title('Histogramme image sortie');

% Affichage de l'histogramme cumulé de l'image originale et de l'image
% égalisée
subplot(3,2,5);
bar(0:255, IHCN);
title('HCN image entrée');
subplot(3,2,6);
bar(0:255, IHCNout);
title('HCN image sortie');

end