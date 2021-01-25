function [] = test_goodmansaid_error()
    [f,dfx,dfy,Hf] = testfunction3();
    
    n = 30; % random podatki
    m = 50; % m x m meshgrid
    a = -1; b=1; % range of approximation
    
    XY = rand(n,2)*(b-a)+a;
    X = XY(:,1); Y = XY(:,2); F = f(X,Y); % podatki
    tri = delaunayTriangulation(X,Y); % triangulacija
    [X2,Y2] = meshgrid(linspace(a,b,m)); % testne tocke aproksimacije
    X3 = X2(:); Y3 = Y2(:);
    
    dF = derivativeest([X,Y,F]);
    S = goodmansaidspline(tri,F,dF); % podatki za opis krp
    FApprox = goodmansaidsplinevals(tri,S,X2(:),Y2(:));
    
    filt = isnan(tri.pointLocation([X3,Y3]));
    X3(filt) = nan; Y3(filt) = nan;
    X2 = reshape(X3,m,m);
    Y2 = reshape(Y3,m,m);
    Z2 = f(X2,Y2);
    
    F2 = reshape(FApprox,m,m);
    
%     subplot(1,2,1);
%     surf(X2,Y2,Z2);
%     title('Funkcija');
    subplot(1,2,1);
    surf(X2,Y2,F2);
    title('Goodman-Said aproksimacija');
    subplot(1,2,2);
    surf(X2,Y2,abs(F2 - Z2));
    title('Napaka aproksimacije');
end