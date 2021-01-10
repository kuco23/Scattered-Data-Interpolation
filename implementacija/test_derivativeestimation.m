function [] = test_derivativeestimation()
    n = 200;
    
   [f,dfx,dfy,Hf] = testfunction1();
   [X,Y] = meshgrid(linspace(-3,3,50));
   
   xk = 0.06122; yk = 1.653; zk = f(xk,yk);
   pk = [xk, yk, zk];
   XY = [rand(n,2)*6-3; xk,yk]; Z = f(XY(:,1),XY(:,2));
   P = [XY,Z];
   
   u = derinterpol(XY,Z, pk);
   poly = @(x,y) zk + ...
    u(1) * (x-xk).^2 + u(2) * (x-xk).*(y-yk) + ...
    u(3) * (y-yk).^2 + u(4) * (x-xk) + u(5) * (y-yk);
   
   dpi = vecnorm(XY-pk(1:2),2,2);
   H = mink(dpi,9);
   S = P(dpi <= H(9),:); 
   
   napprox = [-u(4), -u(5),1];
   nprecise = [-dfx(xk,yk),-dfy(xk,yk),1];
   
   surf(X,Y,f(X,Y));
   hold on;
   scatter3(S(:,1),S(:,2),S(:,3),'red', 'filled');
   hold on;
   surf(X,Y,poly(X,Y));
   hold on;
   scatter3(xk,yk,zk,'black','filled');
   
end