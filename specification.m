function Ispecification = specification (Ix, Iz)
    [nbLignes_ix, nbColonnes_ix, can_ix] = size(Ix); % m=nb lignes, n=nb colonnes, can=nb canaux
    if(can_ix > 1)
        Ix = rgb2gray(Ix); % si l’image est en couleur, la transformer en NG
    end

    [nbLignes_iz, nbColonnes_iz, can_iz] = size(Iz); % m=nb lignes, n=nb colonnes, can=nb canaux
    if(can_iz > 1)
        Iz = rgb2gray(Iz); % si l’image est en couleur, la transformer en NG
    end

    Ispecification = zeros(nbLignes_ix, nbColonnes_ix);

    % -------------------------------------------
    % Calcul de l'histogramme cumulé des 2 images
    % -------------------------------------------

    % Fonction HC declaré en dessous de specification
    HC_x = HC(Ix);
    HC_z = HC(Iz);

    % --------------------------------------------------
    % Application des niveaux de gris de quantité proche
    % --------------------------------------------------

    % TODO : Pour chaque niveau de gris dans l'image source, calculer sa quantité,
    % puis calculer sa différence avec tous les quantité de niveau de gris de
    % l'image de référence, pour ensuite prendre le niveau de gris de l'image
    % de référence avec la plus petite différence

    % ---------
    % affichage
    % ---------
    figure;

    subplot(4, 2, 1); %sélectionne le premier cadran de la fenêtre
    imshow(Ix);
    title("Image source");

    subplot(4, 2, 2); %sélectionne le deuxieme cadran de la fenêtre
    imshow(Iz)
    title("Image de référence");

    subplot(4, 2, 3); %sélectionne le troisème cadran de la fenêtre
    imhist(Ix);
    axis([-inf +inf -inf +inf]);
    title("Histogramme image source");

    subplot(4, 2, 4); %sélectionne le quatrième cadran de la fenêtre
    imhist(Iz);
    axis([-inf +inf -inf +inf]);
    title("Histogramme image de référence");

    subplot(4, 2, 5); %sélectionne le cinquième cadran de la fenêtre
    %imhist(Ix);
    %axis([-inf +inf -inf +inf]);
    title("Histogramme cumulée image source");

    subplot(4, 2, 6); %sélectionne le sixième cadran de la fenêtre
    %imhist(Iz);
    %axis([-inf +inf -inf +inf]);
    title("Histogramme cumulée image de référence");

    subplot(4, 2, 7); %sélectionne le cinquième cadran de la fenêtre
    imshow(Ispecification);
    title("Image obtenue par la spécification");

    subplot(4, 2, 8); %sélectionne le sixième cadran de la fenêtre
    %imhist(Ispecification);
    title("Histogramme de l'image obtenue par la spécification");
    %axis([-inf +inf -inf +inf]);
end

function HC = calculHC (I)
    HC = zeros(1,1);
    % TODO : Implémenter
end
