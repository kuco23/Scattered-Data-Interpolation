function [f,dfx,dfy,Hf] = testfunction3()
    f = @(x,y) sin(x.*y) + cos(x.*y);
    dfx = @(x,y) y.*cos(x.*y) - y.*sin(x.*y);
    dfy = @(x,y) x.*cos(x.*y) - x.*sin(x.*y);
    dfxx = @(x,y) -y.^2.*sin(x.*y) - y.^2.*sin(x.*y);
    dfyy = @(x,y) -x.^2.*sin(x.*y) - x.^2.*sin(x.*y);
    dfxy = @(x,y) -x.*y.*sin(x.*y) - x.*y.*cos(x.*y);
    Hf = @(x,y) [dfxx(x,y), dfxy(x,y); dfxy(x,y), dfyy(x,y)];
end