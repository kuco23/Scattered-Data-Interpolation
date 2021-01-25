function [] = test_goodmansaid()
    f = testfunction3();
    
    n = 20; % random podatki
    m = 50; % m x m meshgrid
    a = -1; b=1; % range of approximation
    
    XY = rand(n,2)*(b-a)+a;
    X = XY(:,1); Y = XY(:,2); F = f(X,Y); % podatki
    tri = delaunayTriangulation(X,Y); % triangulacija
    [X2,Y2] = meshgrid(linspace(a,b,m)); % testne tocke aproksimacije
    
    dF = derivativeest([X,Y,F]);
    S = goodmansaidspline(tri,F,dF); % podatki za opis krp
    FApprox = goodmansaidsplinevals(tri,S,X2(:),Y2(:));
    
    subplot(1,2,1);
    trisurf(tri.ConnectivityList,X,Y,F);
    title(strcat(int2str(n),' testnih tock'));
    subplot(1,2,2);
    surf(X2,Y2,reshape(FApprox,m,m));
    title('goodman-said');
end