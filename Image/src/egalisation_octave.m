function [Iout] = egalisation_octave(path)
  % EGALISATION répartit les intensités de gris
  % le plus uniformément possible sur la plage [0;255]
  % L'objectif est que l'histogramme cumulé normalisé résultant
  % ressemble à la courbe de la fonction linéaire y = x
  % Possible d'affecter la nouvelle image à une variable
  % en appelant par exemple I = egalisation(chemin)

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
  f = figure;

  % Changement de la taille de la fenêtre en 1000*900
  pos = get(f, 'Position');
  pos(3) = 1000;
  pos(4) = 900; 
  set(f, 'Position', pos);

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