function [] = test()
    f = @(x,y) 3*(1-x).^2.*exp(-x.^2 - (y+1).^2) ...
        - 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) ...
        - 1/3*exp(-(x+1).^2 - y.^2);
    
    XY = rand(100,2);
    Z = f(XY(:,1), XY(:,2));
    dF = derivative_estimation([XY,Z]);
    [tri,B] = scattered_interpolation([XY,Z],dF);
    
    [X,Y] = meshgrid(linspace(0,1,50));
    Z_approx = scattered_interpolation_values(tri,B,[X(:),Y(:)]);
    
    surf(X,Y,reshape(Z_approx,50,50));
end