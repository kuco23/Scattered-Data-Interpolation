function [tri, B] = scattered_interpolation(P)
    V = P(:,1:2); % triangle nodes
    F = P(:,3); % values
    dF = derivative_estimation(P);
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
        Fe1j = (x3 - x2) * Fxj + (y3 - y2) * Fyj;
        Fe2j = (x1 - x3) * Fxj + (y1 - y3) * Fyj;
        Fe3j = (x2 - x1) * Fxj + (y2 - y1) * Fyj;
        
        Fxk = dF(k,1); Fyk = dF(k,2);
        Fe1k = (x3 - x2) * Fxk + (y3 - y2) * Fyk;
        Fe2k = (x1 - x3) * Fxk + (y1 - y3) * Fyk;
        Fe3k = (x2 - x1) * Fxk + (y2 - y1) * Fyk;
        
        Fxl = dF(l,1); Fyl = dF(l,2);
        Fe1l = (x3 - x2) * Fxl + (y3 - y2) * Fyl;
        Fe2l = (x1 - x3) * Fxl + (y1 - y3) * Fyl;
        Fe3l = (x2 - x1) * Fxl + (y2 - y1) * Fyl;
        
        b300 = F(j);
        b210 = F(j) + Fe3j / 3;
        b201 = F(j) - Fe2j / 3;
        
        b030 = F(k);
        b021 = F(k) + Fe1k / 3;
        b120 = F(k) - Fe3k / 3;
        
        b003 = F(l);
        b102 = F(l) + Fe2l / 3;
        b012 = F(l) - Fe1l / 3;
        
        b11 = nan;
        
        B{i,1} = [
            b300 b210 b120 b030; ...
            b201 b111 b021 nan; ...
            b102 b012 nan nan; ...
            b003 nan nan nan; ...
        ];
    end
end