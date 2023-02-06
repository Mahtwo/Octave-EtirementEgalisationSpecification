function im = init(filename);
    pkg load image
    % si pas de fichier specifié, prends image_test_bruit.tif
    if not(exist('filename')) || isempty(filename)
        im = imread('image_test_bruit.tif');
    else
        im = imread(filename);
    end
    [nbLignes, nbColonnes, can] = size(im); % m=nb lignes, n=nb colonnes, can=nb canaux
    if(can > 1)
        im = rgb2gray(im); % si l’image est en couleur, la transformer en NG
    end
end
