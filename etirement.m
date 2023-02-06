function Ietirement = etirement (I)
    [nbLignes, nbColonnes, can] = size(I); % m=nb lignes, n=nb colonnes, can=nb canaux
    if(can > 1)
        I = rgb2gray(I); % si l’image est en couleur, la transformer en NG
    end

    % ----------------------
    % Debut Calcul Etirement
    % ----------------------
    amin = min(min(I)) + 1; % niveau de gris minimum de I
    amax = max(max(I)) + 1; % niveau de gris maximum de I

    Ietirement = zeros(nbLignes, nbColonnes); % image après étirement

    amin = cast (amin, "double");
    amax = cast (amax, "double");

    Ietirement = cast(255.0 * (cast(I, "double") - amin) / (amax - amin), "uint8"); % calcu de l'étirement sur chaque pixel

    % -----------------
    % LUT de Ietirement
    % -----------------
    LUT = zeros(256, 1); % initialisation à 0

    a = (255 - 0) / (amax - amin); % coefficient directeur
    b = amin; % ordonnée à l'origine
    LUT(amin:amax) = ((amin:amax) - amin) * a; % calcul de la courbe entre amin et amax

    LUT(amax:end) = 255; % passage des valeurs après amax à 255

    % ---------
    % affichage
    % ---------
    figure;
    subplot(3, 2, 1); %sélectionne le premier cadran de la fenêtre
    imshow(I);
    title(strcat(['min = ', num2str(amin), ' max = ', num2str(amax)])); % a la fin du subplot
    subplot(3, 2, 2); %sélectionne le deuxieme cadran de la fenêtre
    imshow(Ietirement);
    title(strcat(['min = ', num2str(min(min(Ietirement))), ' max = ', num2str(max(max(Ietirement)))])); % a la fin du subplot
    subplot(3, 2, 3); %sélectionne le troisème cadran de la fenêtre
    imhist(I);
    axis([-inf +inf -inf +inf]); %spécifie l'axis par défaut, sinon ça utilise l'axis du LUT
    subplot(3, 2, 4); %sélectionne le quatrième cadran de la fenêtre
    imhist(Ietirement);
    axis([-inf +inf -inf +inf]); %spécifie l'axis par défaut, sinon ça utilise l'axis du LUT
    subplot(3, 2, 5:6); %sélectionne le cinquième cadran de la fenêtre
    plot(LUT);
    xlabel('NG entrée');
    ylabel('NG sortie');
    title(strcat(['LUT - a = ', num2str(a), ' b = ', num2str(b)])); % a la fin du subplot
    axis([0 255 0 255]);
end

