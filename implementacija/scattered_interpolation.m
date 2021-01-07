function [tri, B] = scattered_interpolation(P, dF)
    V = P(:,1:2); % triangle nodes
    F = P(:,3); % values
    tri = delaunayTriangulation(V);
    
    [N,~] = size(tri.ConnectivityList);
    B = cell(N, 3);
    for i=1:N
        T = tri.ConnectivityList(i,:);
        j = T(1); k = T(2); l = T(3);
        
        x1 = V(j,1); y1 = V(j,2);
        x2 = V(k,1); y2 = V(k,2);
        x3 = V(l,1); y3 = V(l,2);
        
        Fxj = dF(j,1); Fyj = dF(j,2);
        Fe2j = (x1 - x3) * Fxj + (y1 - y3) * Fyj;
        Fe3j = (x2 - x1) * Fxj + (y2 - y1) * Fyj;
        
        Fxk = dF(k,1); Fyk = dF(k,2);
        Fe1k = (x3 - x2) * Fxk + (y3 - y2) * Fyk;
        Fe3k = (x2 - x1) * Fxk + (y2 - y1) * Fyk;
        
        Fxl = dF(l,1); Fyl = dF(l,2);
        Fe1l = (x3 - x2) * Fxl + (y3 - y2) * Fyl;
        Fe2l = (x1 - x3) * Fxl + (y1 - y3) * Fyl;
        
        b300 = F(j);
        b210 = F(j) + Fe3j / 3;
        b201 = F(j) - Fe2j / 3;
        
        b030 = F(k);
        b021 = F(k) + Fe1k / 3;
        b120 = F(k) - Fe3k / 3;
        
        b003 = F(l);
        b102 = F(l) + Fe2l / 3;
        b012 = F(l) - Fe1l / 3;
        
        hj = -(x3*x1 + y3*y1) / (x1^2 + y1^2);
        b11j = (b120 + b102 + hj * (2 * b012 - b021 - b003)) / 2 + ...
            (1 - hj) * (2 * b021 - b030 - b012);
        
        hk = -(x1*x2 + y1*y2) / (x2^2 + y2^2);
        b11k = (b012 + b210 + hk * (2 * b201 - b102 - b300)) / 2 + ...
            (1 - hk) * (2 * b102 - b003 - b201);
        
        hl = -(x2*x3 + y2*y3) / (x3^2 + y3^2);
        b11l = (b201 + b021 + hl * (2 * b120 - b210 - b030)) / 2 + ...
            (1 - hl) * (2 * b210 - b300 - b120);
        
        BT = [
            b300 b210 b120 b030; ...
            b201 b11j b021 nan; ...
            b102 b012 nan nan; ...
            b003 nan nan nan; ...
        ];
        
        B{i,1} = BT;
        BT(2,2) = b11k;
        B{i,2} = BT;
        BT(2,2) = b11l;
        B{i,3} = BT;
    end
end