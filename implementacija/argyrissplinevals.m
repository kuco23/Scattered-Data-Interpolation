function avals = argyrissplinevals(tri,A,X,Y)
    [n,~] = size(X);
    avals = zeros(n,1);
    for i=1:n
        x = X(i); y = Y(i);
        loc = tri.pointLocation(x,y);
        if isnan(loc)
            avals(i) = nan;
            continue;
        end
        T = tri.Points(tri.ConnectivityList(loc,:),:);
        avals(i) = decasteljau3(A{loc},pointbary(T,[x,y]));
    end
end
        