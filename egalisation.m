function Iegalisation = egalisation (I)
    [nbLignes, nbColonnes, can] = size(I);
    if(can > 1)
        I = rgb2gray(I); % Si l’image est en couleur, la transformer en niveau de gris
    end

    % ----------------------------------------------------------------
    % Calcul du nombre d'occurences de chaque niveau de gris de l'image
    % ----------------------------------------------------------------
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

    % ----------------------------------------
    % Calcul de l'histogramme cumulé normalisé
    % ----------------------------------------
    HCN = zeros(256, 1);
    HCN(1, 1) = densiteProba(1, 1);
    for i = 2:256
        HCN(i, 1) = densiteProba(i, 1) + HCN(i - 1, 1);
    endfor

    % --------------------------------------------
    % Calcul des niveaux de gris après égalisation
    % --------------------------------------------
    NGegalisation = floor(255 * HCN);

    % ------------------
    % Application du LUT
    % ------------------
    LUT = cast(NGegalisation,'uint8');


    Iegalisation = intlut(I, LUT);

    % ---------
    % Affichage
    % ---------
    figure;

    subplot(4, 2, 1); % Sélectionne le premier cadran de la fenêtre
    imshow(I);
    title(strcat(['min = ', num2str(min(min(I))), ' max = ', num2str(max(max(I)))]));

    subplot(4, 2, 2); % Sélectionne le deuxième cadran de la fenêtre
    imshow(Iegalisation)
    title(strcat(['min = ', num2str(min(min(Iegalisation))), ' max = ', num2str(max(max(Iegalisation)))]));

    subplot(4, 2, 3); % Sélectionne le troisième cadran de la fenêtre
    imhist(I);
    axis([-inf +inf -inf +inf]);
    title("Histogramme image base (axes complets)");

    subplot(4, 2, 4); % Sélectionne le quatrième cadran de la fenêtre
    imhist(Iegalisation);
    axis([-inf +inf -inf +inf]);
    title("Histogramme image égalisée (axes complets)");

    subplot(4, 2, 5); % Sélectionne le cinquième cadran de la fenêtre
    imhist(I);
    axis([-inf +inf 0 100]);
    title("Histogramme image base (axes tronqués)");

    subplot(4, 2, 6); % Sélectionne le sixième cadran de la fenêtre
    imhist(Iegalisation);
    axis([-inf +inf 0 100]);
    title("Histogramme image égalisée (axes tronqués)");

    subplot(4, 2, 7); % Sélectionne le septième cadran de la fenêtre
    plot(LUT);
    axis([1 256 0 255]); % Index allant de 1 à 256
    xlabel('NG entrée');
    ylabel('NG sortie');
    title("LUT");

    subplot(4, 2, 8); % Sélectionne le huitième cadran de la fenêtre
    plot(HCN);
    title("HCN de l'image égalisée");
    axis([1 256 0 1]); % Index allant de 1 à 256

end

