function S = argyrisspline(tri,f,Df,Hf)
    k = length(tri.ConnectivityList);
    S = cell(k,1);
    for i=1:k
        TI = tri.ConnectivityList(i,:);
        T = tri.Points(TI,:);
        S{i} = argyris(T,f,Df,Hf);
    end
end