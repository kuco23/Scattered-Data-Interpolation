function [f,dfx,dfy,Hf] = testfunction4()
    f = @(x,y) x.^2;
    dfx = @(x,y) 2*x;
    dfy = @(x,y) zeros(size(y));
    Hf = @(x,y) [2,0;0,0];
end