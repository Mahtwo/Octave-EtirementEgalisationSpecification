function NGegalisation = egalisation (I)
    [nbLignes, nbColonnes, can] = size(I); % m=nb lignes, n=nb colonnes, can=nb canaux
    if(can > 1)
        I = rgb2gray(I); % si l’image est en couleur, la transformer en NG
    end

    % -----------------------------------------------------------------------------------
    % Calcul du nombre d'occrence de chaque niveau de gris de l'image (pour chaque pixel)
    % -----------------------------------------------------------------------------------

    nbOccurenceNG = zeros(256, 1);
    totalOccurence = nbLignes * nbColonnes;

    for i = 1:nbLignes
        for j = 1:nbColonnes
            nbOccurenceNG(I(i, j) + 1) = nbOccurenceNG(I(i, j) + 1) +1;
        endfor
    endfor

    % -----------------------------------
    % Calcul de la densité de probabilité
    % -----------------------------------

    densiteProba = nbOccurenceNG / totalOccurence;

    % -----------------------------------------------
    % Calcul des HCN cumulés pour chaque probabilités
    % -----------------------------------------------

    HCNcumule = zeros(256, 1);
    HCNcumule(1, 1) = densiteProba(1, 1); % floor arrondis a l'entier inférieur
    for i = 2:256
        HCNcumule(i, 1) = densiteProba(i, 1) + HCNcumule(i - 1, 1);
    endfor

    % -------------------------------
    % Calcul des NG après égalisation
    % -------------------------------

    NGegalisation = floor(255 * HCNcumule);

    % ------------------
    % Application du LUT
    % ------------------

    LUTng = cast(NGegalisation,'uint8');


    Iegalisation = intlut(I, LUTng);

    % ---------
    % affichage
    % ---------
    figure;

    subplot(4, 2, 1); %sélectionne le premier cadran de la fenêtre
    imshow(I);
    %title(strcat(['min = ', num2str(amin), ' max = ', num2str(amax)])); % a la fin du subplot

    subplot(4, 2, 2); %sélectionne le deuxieme cadran de la fenêtre
    imshow(Iegalisation)
    %title(strcat(['min = ', num2str(min(min(Ietirement))), ' max = ', num2str(max(max(Ietirement)))])); % a la fin du subplot

    subplot(4, 2, 3); %sélectionne le troisème cadran de la fenêtre
    imhist(I);
    axis([-inf +inf -inf +inf]); %spécifie l'axis par défaut, sinon ça utilise l'axis du LUT
    title("Histogramme image base (axes complets)");

    subplot(4, 2, 4); %sélectionne le quatrième cadran de la fenêtre
    imhist(Iegalisation);
    axis([-inf +inf -inf +inf]); %spécifie l'axis par défaut, sinon ça utilise l'axis du LUT
    title("Histogramme image égalisée (axes complets)");

    subplot(4, 2, 5); %sélectionne le cinquième cadran de la fenêtre
    imhist(I);
    title("Histogramme image base (axes tronqués)");

    subplot(4, 2, 6); %sélectionne le sixième cadran de la fenêtre
    imhist(Iegalisation);
    title("Histogramme image égalisée (axes tronqués)");

    subplot(4, 2, 7); %sélectionne le cinquième cadran de la fenêtre
    plot(LUTng);
    axis([1 256 0 255]);
    xlabel('NG entrée');
    ylabel('NG sortie');
    title("LUT");

    subplot(4, 2, 8); %sélectionne le sixième cadran de la fenêtre
    plot(HCNcumule);
    title("HCN de l'image égalisée");
    axis([1 256 0 1]);

end

