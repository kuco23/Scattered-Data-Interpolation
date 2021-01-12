function [] = test_goodmansaidvsargyris()
    n = 10; % stevilo aproksimacijskih tock
    m = 50; % m x m je dimenzija grida, ko risemo aproksimacijo
    a = 0; b = 1; % [a,b] je interval na katerem aproksimiramo
    [f,dfx,dfy,Hf] = testfunction1();
    
    XY = rand(n,2)*(b-a)+a; % testne vrednosti
    X = XY(:,1); Y = XY(:,2);
    tri = delaunayTriangulation(X,Y);
    F = f(X,Y); dF = [dfx(X,Y), dfy(X,Y)];
    
    [X2,Y2] = meshgrid(linspace(a,b,m));
    G = goodmansaidspline(tri,F,dF);
    FApprox1 = goodmansaidsplinevals(tri,G,X2(:),Y2(:));
    A = argyrisspline(tri,f,@(x,y) [dfx(x,y),dfy(x,y)], Hf);
    FApprox2 = argyrissplinevals(tri,A,X2(:),Y2(:));
    
    F0 = f(X2,Y2);
    F1 = reshape(FApprox1,m,m);
    F2 = reshape(FApprox2,m,m);
    
    % primerjava vrednosti
    subplot(1,2,1);
    surf(X2,Y2,F1);
    title('goodman-said');
    subplot(1,2,2);
    surf(X2,Y2,F2);
    title('argyris');
    
    % primerjava napak
%     subplot(1,2,1);
%     surf(X2,Y2,reshape(abs(F1-F0),m,m));
%     title('goodman-said');
%     subplot(1,2,2);
%     surf(X2,Y2,reshape(abs(F2-F0),m,m));
%     title('argyris');
end