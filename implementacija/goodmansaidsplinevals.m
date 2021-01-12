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

        Bi = B{ti};
        b300 = Bi(1,1); b210 = Bi(1,2); b120 = Bi(1,3); b030 = Bi(1,4);
        b201 = Bi(2,1); b021 = Bi(2,3);
        b102 = Bi(3,1); b012 = Bi(3,2); b1112 = Bi(3,4); 
        b003 = Bi(4,1); b1113 = Bi(4,3); b1111 = Bi(4,4);
         
        uvw = pointbary(T, [x,y]);
        u = uvw(1); v = uvw(2); w = uvw(3);
        vw2 = (v * w)^2; wu2 = (w * u)^2; uv2 = (u * v)^2;

        Z(i) = u^3*b300 + 3*u^2*v*b210 + 3*u^2*w *b201 + 3*u*v^2*b120 + 3*u*w^2*b102+ ...
            v^3*b030 + 3*v^2*w*b021 + 3*v*w^2*b012 + w^3 * b003 + ...
            6*u*v*w*(vw2*b1111 + wu2*b1112 + uv2*b1113) / (vw2 + wu2 + uv2);
    end
end