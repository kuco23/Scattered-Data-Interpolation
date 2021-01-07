function derivatives = derivative_estimation(P)
    M = 9; % stevilo vozlisc, ki jih upostevamo v okolici
    % predpostavi N >= 9
    [N, ~] = size(P);
    derivatives = zeros(N,2);
    
    for i=1:N
        pi = P(i,:); % tocka, v kateri dolocamo odvoda
        dpi = vecnorm(P-pi,2,2); % oddaljenost tock od pi
        
        H = mink(dpi,M+1);
        R = H(M+1); % radij okoli pi, znotraj katerega tocke vplivajo na odvod
        filt = (0 < dpi & dpi <= R);
        S = P(filt,:); % tocke znotraj radija (brez pi)
        D = dpi(filt); % oddaljenost tock znotraj S
        
        k = length(D);
        A = zeros(k,5);
        v = zeros(k,1);
        for j=1:k
            dj = D(j);
            pj = S(j,:);
            xi = pi(1); yi = pi(2);
            xj = pj(1); yj = pj(2);
            % utez poskrbi, da podatki dlje
            % od pi vplivajo manj na njegova odvoda
            w = (R - dj) / (R * dj);
            A(j,:) = w * [
                (xj - xi)^2 (xj - xi) * (yj - yi) ...
                (yj-yi)^2 (xj - xi) (yj - yi) ...
            ];
            v(j) = w * (pj(3) - pi(3));
        end
        
        % minimiziramo 2-normo, oddaljenosti
        % interpolacijskega polinoma skozi pi,
        % od vrednosti v tockah okoli pi
        u = A \ v;
        derivatives(i,:) = u([4,5])';
    end
end