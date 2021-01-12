function [] = test_derivativeest()
    f = testfunction3();
    dfx = @(x,y) cos(x.*y).*y - sin(x.*y).*y;
    dfy = @(x,y) cos(x.*y).*x - sin(x.*y).*x;
    [f,dfx,dfy,~] = testfunction1();
    
    n =40;
    
    [X,Y] = meshgrid(linspace(-1,1,n));
    Z = f(X,Y);
    
    dF = derivativeest([X(:),Y(:),Z(:)]);
    dFx = reshape(dF(:,1),n,n); dFy = reshape(dF(:,2),n,n);
    derr = sqrt((dfx(X,Y) - dFx).^2 + (dfy(X,Y) - dFy).^2);
    
    subplot(1,2,1);
    surf(X,Y,f(X,Y));
    title('ocenjevana funkcija');
    hold on;
    subplot(1,2,2);
    surf(X,Y,derr);
    title(strcat("napaka aproksimacije odvoda na ",int2str(n),"x",int2str(n), " mreži"));
end