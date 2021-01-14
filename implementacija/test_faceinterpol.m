function [] = test_faceinterpol()
    m = 80; step = 5;
    
    P = load('./face/face15.vert');
    P = P(1:step:end,:);
    X = P(:,1); Y = P(:,2); F = P(:,3);

    a1 = min(X); b1 = max(X);
    a2 = min(Y); b2 = max(Y);
    
    tri = delaunayTriangulation(X,Y);
    dF = derivativeest(P);
    
    [X2,Y2] = meshgrid(linspace(a1,b1,m),linspace(a2,b2,m));
    S = goodmansaidspline(tri, F, dF);
    FApprox = goodmansaidsplinevals(tri,S,X2(:),Y2(:));
   
    subplot(1,2,1);
    trisurf(tri.ConnectivityList,X,Y,F);
    subplot(1,2,2);
    surf(X2,Y2,reshape(FApprox,m,m));
end