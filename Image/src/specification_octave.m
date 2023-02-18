function [Iout] = specification_octave(path1, path2)
  % Lecture de l'image source et l'image référence
  I = imread(path1);
  Iref = imread(path2);
  
  % Si les images sont en couleur, on les convertit en niveaux de gris
  if ndims(I) == 3
      I = rgb2gray(I);
  end

  if ndims(Iref) == 3
      Iref = rgb2gray(Iref);
  end
  
  % Calcul des histogrammes
  histI = hist(I(:), 0:255);
  histIref = hist(Iref(:), 0:255);
  
  % Calcul des histogrammes cumulés normalisés
  HCNI = cumsum(histI) / numel(I);
  HCNIref = cumsum(histIref) / numel(Iref);
  
  % Initialisation d'une matrice effectuant la correspondance entre les intensitsités source et référence
  % T[intensité] = nouvelle_intensité
  T = zeros(256, 1, 'uint8');
  
  % Parcours des intensités de l'image source 
  % (non faisable en notation matricielle)
  for i = 1:256
    % Recherche de l'intensité correspondante dans l'image de référence
    [~, j] = min(abs(HCNI(i) - HCNIref)); % on a juste besoin d'un l'indice 
    % Assignation de la nouvelle intensité dans le tableau de correspondance
    T(i) = j-1;
  end
  
  % Application de la table de correspondance pour la spécification
  Iout = T(double(I)+1);
  
  % Affichage des images et de leurs histogrammes après la spécification
##  figure;
##  subplot(2,2,1); imshow(I); title('Image source');
##  subplot(2,2,2); bar(h_I); title('Histogramme source');
##  subplot(2,2,3); imshow(Iout); title('Image spécifiée');
##  subplot(2,2,4); bar(hist(Iout(:), 0:255)); title('Histogramme spécifié');
  
  % Calcul des histogrammes de l'image de sortie (pour affichage)
  histIout = hist(Iout(:), 0:255);
  HCNIout = cumsum(histIout) / numel(Iout);
  
  % Phase d'affichage
  f = figure;

  % Changement de la taille de la fenêtre en 1000*900
  pos = get(f, 'Position');
  pos(3) = 1400;
  pos(4) = 900; 
  set(f, 'Position', pos);

  % Affichage de l'image originale, image référence, et image spécifiée
  subplot(3,3,1);
  imshow(I);
  title('Image source');
  subplot(3,3,2);
  imshow(Iref);
  title('Image référence');
  subplot(3,3,3);
  imshow(Iout);
  title('Image sortie');

  % Affichage de l'histograme de l'image originale et de l'image égalisée
  subplot(3,3,4);
  bar(histI);
  title('Histogramme image source');
  subplot(3,3,5);
  bar(histIref);
  title('Histogramme image référence');
  subplot(3,3,6);
  bar(histIout);
  title('Histogramme image sortie');
  
  subplot(3,3,7);
  bar(HCNI);
  title('HCN image source');
  subplot(3,3,8);
  bar(HCNIref);
  title('HCN image référence');
  subplot(3,3,9);
  bar(HCNIout);
  title('HCN image sortie');
end