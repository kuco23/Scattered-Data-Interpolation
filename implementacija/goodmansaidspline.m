function S = goodmansaidspline(tri,F,dF)
    k = length(tri.ConnectivityList);
    S = cell(k,3);
    for i=1:k
        Ti = tri.ConnectivityList(i,:);
        T = tri.Points(Ti,:);
        [B1,B2,B3] = goodmansaid(T,F(Ti),dF(Ti,:));
        S{i,1} = B1;
        S{i,2} = B2;
        S{i,3} = B3;
    end
end