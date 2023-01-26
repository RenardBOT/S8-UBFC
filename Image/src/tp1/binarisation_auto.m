function [] = binarisation_auto(path)
%BINARISATION_MAN Summary of this function goes here
%   Detailed explanation goes here

% Lecture, passage en NG, normalisation 
I1 = imread(path);
I1 = rgb2gray(I1);
I1 = rescale(I1,0,1);


threshold = graythresh(I1)
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
