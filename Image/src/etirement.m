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

% LOOKUP TABLE
% Ordonee a l'origine
alpha = -255*double(Imin)/double(Imax-Imin);
% Coefficient directeur 
beta = double(255/double(Imax - Imin));
% Definition de la LUT par morceaux
LUT = @(x) 0.*(x>=0 & x<Imin) + (beta*x+alpha).*(x>=Imin & x<Imax) + 255.*(x>=Imax);

% Phase d'affichage
f = figure;
f.Position = [100 100 800 1000];

% Affichage de l'image originale et de l'image étirée
subplot(3,2,1);
imshow(I);
title('Image entrée');
subplot(3,2,2);
imshow(Iout);
title('Image sortie');

% Affichage de l'histograme de l'image originale et de l'image étirée
subplot(3,2,3);
histogram(I,255,'BinLimits',[0 255]);
title('Histogramme image entrée');
subplot(3,2,4);
histogram(Iout,255);
title('Histogramme image sortie');

% Affichage de l'histogramme cumulé de l'image originale et de l'image
% étirée
subplot(3,2,5);
fplot(LUT, [0 255],'LineWidth',2.5);
hold on
title(strcat('LUT(ax+b) b : ',num2str(alpha),' - a : ',num2str(beta)));
subplot(3,2,6);
histogram(Iout,255,'Normalization','cdf');
title('HCN image sortie');



end