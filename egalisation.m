function Iegalisation = egalisation (I)
    [nbLignes, nbColonnes, can] = size(I);
    if(can > 1)
        I = rgb2gray(I); % Si l’image est en couleur, la transformer en niveau de gris
    end

    % ------------------------------
    % Calcul de l'histogramme cumulé
    % ------------------------------

    % Fonction calculHCN déclarée en dessous de egalisation
    HCNoriginale = calculHCN(I);

    % --------------------------------------------
    % Calcul des niveaux de gris après égalisation
    % --------------------------------------------
    NGegalisation = floor(255 * HCNoriginale);

    % ------------------
    % Application du LUT
    % ------------------
    LUT = cast(NGegalisation,'uint8');


    Iegalisation = intlut(I, LUT);
    HCNegalisee = calculHCN(Iegalisation);

    % ---------
    % Affichage
    % ---------

    subplot(4, 3, 3); % Sélectionne le deuxieme cadran de la fenêtre
    imshow(Iegalisation)
    title({'Image égalisée', strcat(['min = ', num2str(min(min(Iegalisation))), ' max = ', num2str(max(max(Iegalisation)))])});

    subplot(4, 3, 6); % Sélectionne le quatrième cadran de la fenêtre
    imhist(Iegalisation);
    axis([-inf +inf -inf +inf]);
    title("Histogramme image égalisée (axes complets)");

    subplot(4, 3, 9); % Sélectionne le sixième cadran de la fenêtre
    imhist(Iegalisation);
    axis([-inf +inf 0 100]);
    title("Histogramme image égalisée (axes tronqués)");

    subplot(4, 3, 12); % Sélectionne le cinquième cadran de la fenêtre
    plot(LUT);
    axis([1 256 0 255]); % Index allant de 1 à 256
    xlabel('NG entrée');
    ylabel('NG sortie');
    title("LUT");
end

function HCN = calculHCN (I)
    [nbLignes, nbColonnes] = size(I);

    % ----------------------------------------------------------------
    % Calcul du nombre d'occurences de chaque niveau de gris de l'image
    % ----------------------------------------------------------------
    nbOccurencesNG = zeros(256, 1);
    totalOccurences = nbLignes * nbColonnes;

    for i = 1:nbLignes
        for j = 1:nbColonnes
            nbOccurencesNG(I(i, j) + 1) = nbOccurencesNG(I(i, j) + 1) + 1;
        endfor
    endfor

    % -----------------------------------
    % Calcul de la densité de probabilité
    % -----------------------------------
    densiteProba = nbOccurencesNG / totalOccurences;

    % ----------------------------------------
    % Calcul de l'histogramme cumulé normalisé
    % ----------------------------------------
    HCN = zeros(256, 1);
    HCN(1, 1) = densiteProba(1, 1);
    for i = 2:256
        HCN(i, 1) = densiteProba(i, 1) + HCN(i - 1, 1);
    endfor
end
