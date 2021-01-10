function Z = goodmansaidsplinevals(tri,B,X,Y)
    [N,~] = size(X);
    Z = zeros(N,1);
    for i=1:N
        x = X(i); y = Y(i);
        ti = tri.pointLocation(x, y);
        if isnan(ti) % tocka xy ni v triangulaciji
            Z(i) = nan;
            continue; 
        end
        Ti = tri.ConnectivityList(ti,:);
        T = tri.Points(Ti,:);
        
        uvw = pointbary(T, [x,y]);
        P1 = decasteljau3(B{ti,1},uvw);
        P2 = decasteljau3(B{ti,2},uvw);
        P3 = decasteljau3(B{ti,3},uvw);
        
        u = uvw(1); v = uvw(2); w = uvw(3);
        vw2 = (v * w)^2; 
        wu2 = (w * u)^2; 
        uv2 = (u * v)^2;
        Z(i) = (vw2 * P1 + wu2 * P2 + uv2 * P3) / (vw2 + wu2 + uv2);
    end
end