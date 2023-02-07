function [im1, im2] = init(filename);
    pkg load image
    % si pas de fichier specifié, prends image_test_bruit.tif
    if not(exist('filename')) || isempty(filename)
        im1 = imread('lena_fc.png');
        im2 = imread('outils.png');
    else
        im1 = imread(filename);
    end
    [nbLignes, nbColonnes, can] = size(im1); % m=nb lignes, n=nb colonnes, can=nb canaux
    if(can > 1)
        im1 = rgb2gray(im1); % si l’image est en couleur, la transformer en NG
    end
    [nbLignes, nbColonnes, can] = size(im2); % m=nb lignes, n=nb colonnes, can=nb canaux
    if(can > 1)
        im2 = rgb2gray(im2); % si l’image est en couleur, la transformer en NG
    end
end
