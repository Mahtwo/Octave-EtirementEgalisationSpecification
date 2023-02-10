function Ietirement = etirement (I)
    [nbLignes, nbColonnes, can] = size(I);
    if(can > 1)
        I = rgb2gray(I); % Si l’image est en couleur, la transformer en niveau de gris
    end

    % ----------------------
    % Début calcul étirement
    % ----------------------
    amin = min(min(I)); % Niveau de gris minimum de I
    amax = max(max(I)); % Niveau de gris maximum de I

    Ietirement = zeros(nbLignes, nbColonnes); % Image après étirement

    amin = cast(amin, "double");
    amax = cast(amax, "double");

    Ietirement = cast(255.0 * (cast(I, "double") - amin) / (amax - amin), "uint8"); % Calcul de l'étirement sur chaque pixel

    % -----------------
    % LUT de Ietirement
    % -----------------
    LUT = zeros(256, 1); % Initialisation à 0

    a = (255 - 0) / (amax - amin); % Coefficient directeur : (x2 - x1) / (y2 - y1)
    b = amin; % Ordonnée à l'origine
    LUT((amin:amax) + 1) = ((amin:amax) - amin + 1) * a; % Calcul de la courbe entre amin et amax

    LUT((amax + 1):end) = 255; % Passage des valeurs après amax à 255

    % ---------
    % Affichage
    % ---------
    figure;

    subplot(4, 2, 1); % Sélectionne le premier cadran de la fenêtre
    imshow(I);
    title(strcat(['min = ', num2str(amin), ' max = ', num2str(amax)]));

    subplot(4, 2, 2); % Sélectionne le deuxième cadran de la fenêtre
    imshow(Ietirement);
    title(strcat(['min = ', num2str(min(min(Ietirement))), ' max = ', num2str(max(max(Ietirement)))]));

    subplot(4, 2, 3); % Sélectionne le troisième cadran de la fenêtre
    imhist(I);
    axis([-inf +inf -inf +inf]);
    title("Histogramme image originale (axes complets)");

    subplot(4, 2, 4); % Sélectionne le quatrième cadran de la fenêtre
    imhist(Ietirement);
    axis([-inf +inf -inf +inf]);
    title("Histogramme image étirée (axes complets)");

    subplot(4, 2, 5); % Sélectionne le cinquième cadran de la fenêtre
    imhist(I);
    axis([-inf +inf 0 100]);
    title("Histogramme image originale (axes tronqués)");

    subplot(4, 2, 6); % Sélectionne le sixième cadran de la fenêtre
    imhist(Ietirement);
    axis([-inf +inf 0 100]);
    title("Histogramme image étirée (axes tronqués)");

    subplot(4, 2, 7:8); % Sélectionne le septième et huitième cadran de la fenêtre
    plot(LUT);
    xlabel('NG entrée');
    ylabel('NG sortie');
    title(strcat(['LUT - a = ', num2str(a), ' b = ', num2str(b)]));
    axis([1 256 0 255]); % Index allant de 1 à 256
end

