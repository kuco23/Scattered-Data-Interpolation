function S = goodmansaidspline(tri,F,dF)
    k = length(tri.ConnectivityList);
    S = cell(k,1);
    for i=1:k
        Ti = tri.ConnectivityList(i,:);
        T = tri.Points(Ti,:);
        B = goodmansaid(T,F(Ti),dF(Ti,:));
        S{i} = B;
    end
end