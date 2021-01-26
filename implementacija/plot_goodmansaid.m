function [] = plot_goodmansaid(F,X,Y,a,b)
    tri = delaunayTriangulation(X,Y);
    [X2,Y2] = meshgrid(linspace(a,b,m));
    
    dF = derivativeest([X,Y,F]);
    S = goodmansaidspline(tri,F,dF);
    FApprox = goodmansaidsplinevals(tri,S,X2(:),Y2(:));
    
    subplot(1,2,1);
    trisurf(tri.ConnectivityList,X,Y,F);
    title('triangulacija to?k v prostoru');
    subplot(1,2,2);
    surf(X2,Y2,reshape(FApprox,m,m));
    title('Goodman-Said aproksimacija');
end