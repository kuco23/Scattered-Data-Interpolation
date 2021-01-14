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
        b = B{ti};
        uvw = pointbary(T, [x,y]);
        u = uvw(1); v = uvw(2); w = uvw(3);
        vw2 = (v * w)^2; wu2 = (w * u)^2; uv2 = (u * v)^2;
        b111 = (vw2*b(4,4) + wu2*b(3,4) + uv2*b(4,3)) / (vw2 + wu2 + uv2);
        b(2,2) = b111;
        Z(i) = decasteljau3(b,uvw);
    end
end