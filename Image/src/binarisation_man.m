function [] = binarisation_man(path)
%BINARISATION_MAN Summary of this function goes here
%   Detailed explanation goes here

% Lecture, passage en NG, normalisation 
I1 = imread(path);
I1 = rgb2gray(I1);
I1 = rescale(I1,0,1);

f1 = figure;
imhist(I1);
answer = inputdlg('Rentrer la valeur de seuillage entre 0 et 1 compris =) :',...
             'Sample', [1 20]);
threshold = str2double(answer{1});
close(f1);
if threshold < 0 || threshold > 1
    disp("Doit être un flottant entre 0 et 1 compris. Sortie =(");
    return;
end
I2 = I1 > threshold;

f1 = figure;
subplot(1,2,1);
imshow(I1)
subplot(1,2,2);
imshow(I2);

% Attente de la fermeture
while size(findobj(f1))>0
    pause(0.01);
end

end

