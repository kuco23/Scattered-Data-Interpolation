function derivatives = derivative_estimation(P)
    % predpostavi N >= 9
    [N, ~] = size(P);
    derivatives = zeros(N,2);
    
    for i=1:N
        pi = P(i,:); % tocka, v kateri dolocamo odvoda
        [distance,order] = mink(vecnorm(P-pi,2,2),9);
        R = distance(9);
        
        A = zeros(8,5);
        v = zeros(8,1);
        for l=1:8
            j = order(l+1);
            d = distance(l+1);
            % utez poskrbi, da podatki dlje
            % od pi vplivajo manj na njegova odvoda
            w = (R - d) / (R * d);
            pj = P(j,:);
            xi = pi(1); yi = pi(2);
            xj = pj(1); yj = pj(2);
            A(j,:) = w * [
                (xj - xi)^2 (xj - xi)*(yj - yi) ...
                (yj-yi)^2 (xj - xi) (yj - yi) ...
            ];
            v(j) = w * (pj(3) - pi(3));
        end
        
        % minimiziramo 2-normo, oddaljenosti
        % interpolacijskega polinoma skozi pi,
        % od vrednosti F v tockah okoli pi
        u = A \ v;
        derivatives(i,:) = u([4,5])';
    end
end