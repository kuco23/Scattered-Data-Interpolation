function Z = scattered_interpolation_values(tri,B,XY)
    [N,~] = size(XY);
    Z = zeros(N,1);
    for i=1:N
        xy = XY(i,:);
        ti = tri.pointLocation(xy(1), xy(2));
        if isnan(ti) continue; end
        Ti = tri.ConnectivityList(ti,:);
        T = tri.Points(Ti,:);
        
        uvw = pointbary(T, xy);
        B1 = B{ti,1}; 
        B2 = B{ti,2}; 
        B3 = B{ti,3};
        P1 = decasteljau3(B1,uvw);
        P2 = decasteljau3(B2,uvw);
        P3 = decasteljau3(B3,uvw);
        
        u = uvw(1); v = uvw(2); w = uvw(3);
        vw2 = (v * w)^2; 
        wu2 = (w * u)^2; 
        uv2 = (u * v)^2;
        Z(i) = (vw2 * P1 + wu2 * P2 + uv2 * P3) / (vw2 + wu2 + uv2);
    end
end