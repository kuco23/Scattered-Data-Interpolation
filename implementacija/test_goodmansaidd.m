function [] = test_goodmansaidd()
    [f,dfx,dfy,~] = testfunction1();
    
    n = 50; % random podatki 150/1500
    m = 50; % m x m meshgrid
    a = -1; b = 1; % range of approximation
    
    XY = rand(n,2)*(b-a)+a;
    X = XY(:,1); Y = XY(:,2); F = f(X,Y); % podatki
    tri = delaunayTriangulation(X,Y); % triangulacija
    [X2,Y2] = meshgrid(linspace(a,b,m)); % testne tocke aproksimacije
    
    dF = [dfx(X,Y), dfy(X,Y)];
    S = goodmansaidspline(tri,F,dF); % podatki za opis krp
    FApprox = goodmansaidsplinevals(tri,S,X2(:),Y2(:));
    
    subplot(1,2,1);
    surf(X2,Y2,f(X2,Y2));
    title('ocenjevana funkcija');
    subplot(1,2,2);
    surf(X2,Y2,reshape(FApprox,m,m));
    title(strcat("aproksimacija na ", int2str(n), " tockah, z znanimi odvodi"));
end