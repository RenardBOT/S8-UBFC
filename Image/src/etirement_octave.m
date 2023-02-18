function [Iout] = etirement_octave(path)
  % ETIREMENT étire l'histogramme sur la plage [0;255]
  % Possible d'affecter la nouvelle image à une variable
  % en appelant par exemple I = etirement(chemin)

  % Lecture de l'image
  I = imread(path);

  if ndims(I) == 3
      I = rgb2gray(I);
  end

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
  x = linspace(0, 255, 2551);

  % Definition de la LUT par morceaux
  morceau1 = (x>=0 & x<Imin);
  morceau2 = (x>=Imin & x < Imax);
  morceau3 = (x>=Imax);
  y(morceau1) = 0;
  y(morceau2) = beta*x(morceau2)+alpha;
  y(morceau3) = 255;

  % Calcul de l'histogramme cumulé normalisé de l'image de sortie
  [countsOut, edgesOut]=histc(Iout(:), 0:255);
  IHCNout = cumsum(countsOut) / sum(countsOut);


  % Phase d'affichage
  f = figure;

  % Changement de la taille de la fenêtre en 1000*900
  pos = get(f, 'Position');
  pos(3) = 1000;
  pos(4) = 900; 
  set(f, 'Position', pos);

  % Affichage de l'image originale et de l'image étirée
  subplot(3,2,1);
  imshow(I);
  title('Image entrée');
  subplot(3,2,2);
  imshow(Iout);
  title('Image sortie');

  % Affichage de l'histograme de l'image originale et de l'image étirée
  subplot(3,2,3);
  [countsIn, edgesIn] = hist(I(:), 0:255);
  bar(edgesIn, countsIn, "hist");
  title('Histogramme image entrée');
  subplot(3,2,4);
  [countsOut, edgesOut] = hist(Iout(:), 0:255);
  bar(edgesOut, countsOut, "hist");
  title('Histogramme image sortie');

  % Affichage de l'histogramme cumulé de l'image originale et de l'image
  % étirée
  subplot(3,2,5);
  plot(x,y,'LineWidth', 2);
  xlim([0,255]);
  ylim([0,255]);
  ##hold on
  title(strcat('LUT(ax+b) b : ',num2str(alpha),' - a : ',num2str(beta)));
  subplot(3,2,6);
  bar(0:255, IHCNout);
  title('HCN image sortie');



end