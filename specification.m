function Ispecification = specification (Ix, Iz)
    [nbLignes_ix, nbColonnes_ix, can_ix] = size(Ix); % m=nb lignes, n=nb colonnes, can=nb canaux
    if(can_ix > 1)
        Ix = rgb2gray(Ix); % si l’image est en couleur, la transformer en NG
    end

    [nbLignes_iz, nbColonnes_iz, can_iz] = size(Iz); % m=nb lignes, n=nb colonnes, can=nb canaux
    if(can_iz > 1)
        Iz = rgb2gray(Iz); % si l’image est en couleur, la transformer en NG
    end

    % -------------------------------------------
    % Calcul de l'histogramme cumulé des 2 images
    % -------------------------------------------

    % Fonction HC declaré en dessous de specification
    HC_x = calculHC(Ix);
    HC_z = calculHC(Iz);

    % --------------------------------------------------
    % Application des niveaux de gris de quantité proche
    % --------------------------------------------------

    LUT = zeros(256, 1, 'uint8');

    for i = 1:256
        iNGC = HC_x(i);
        diff = realmax;
        for j = 1:256
            jNGC = HC_z(j);
            if abs(iNGC - jNGC) < diff
                diff = abs(iNGC - jNGC);
                nouveauNG = j - 1;
            endif
        endfor
        LUT(i) = nouveauNG;
    endfor

    Ispecification = intlut(Ix, LUT);

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
    plot(HC_x);
    axis([-inf +inf -inf +inf]);
    title("Histogramme cumulée image source");

    subplot(4, 2, 6); %sélectionne le sixième cadran de la fenêtre
    plot(HC_z);
    axis([-inf +inf -inf +inf]);
    title("Histogramme cumulée image de référence");

    subplot(4, 2, 7); %sélectionne le cinquième cadran de la fenêtre
    imshow(Ispecification);
    title("Image obtenue par la spécification");

    subplot(4, 2, 8); %sélectionne le sixième cadran de la fenêtre
    imhist(Ispecification);
    title("Histogramme de l'image obtenue par la spécification");
    axis([-inf +inf -inf +inf]);
end

function HC = calculHC (I)
    [nbLignes, nbColonnes] = size(I);

    % -----------------------------------------------------------------------------------
    % Calcul du nombre d'occurence de chaque niveau de gris de l'image (pour chaque pixel)
    % -----------------------------------------------------------------------------------

    nbOccurenceNG = zeros(256, 1);
    totalOccurence = nbLignes * nbColonnes;

    for i = 1:nbLignes
        for j = 1:nbColonnes
            nbOccurenceNG(I(i, j) + 1) = nbOccurenceNG(I(i, j) + 1) +1;
        endfor
    endfor

    % ------------------------------
    % Calcul de l'histogramme cumulé
    % ------------------------------

    HC(1, 1) = nbOccurenceNG(1, 1);
    for i = 2:256
        HC(i, 1) = nbOccurenceNG(i, 1) + HC(i - 1, 1);
    endfor
end

