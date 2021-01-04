function derivatives = derivative_estimation(P)
    % assume N >= 9
    [N, ~] = size(P);
    derivatives = zeros(N,2);
    
    for i=1:N
        point = P(i,:);
        [distance,order] = mink(vecnorm(P - point,2,2),9);
        R = distance(9);
        
        A = zeros(8,5);
        v = zeros(8,1);
        for l=1:8
            j = order(l+1);
            d = distance(l+1);
            % utez poskrbi, da podatki dlje
            % od pointa ne vplivajo na njegov odvod
            w = (R - d) / (R * d);
            pointj = P(j,:);
            x = point(1); y = point(2);
            xj = pointj(1); yj = pointj(2);
            A(j,:) = w * [
                (xj - x)^2 (xj - x)*(yj - y) ...
                (y-yj)^2 (xj - x) (yj - y) ...
            ];  
            v(j) = w * (pointj(3) - point(3));
        end
        
        u = A \ v;
        derivatives(i,:) = u([4,5])';
    end
end