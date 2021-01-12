function [] = test_derivativeinterpol()
    n = 100;
    
   [f,dfx,dfy,Hf] = testfunction1();
   [X,Y] = meshgrid(linspace(-3,3,50));
   
   xk = 0.5; yk = 1.2; zk = f(xk,yk);
   pk = [xk, yk, zk];
   XY = [rand(n,2)*6-3; xk,yk]; Z = f(XY(:,1),XY(:,2));
   P = [XY,Z];
   
   u = derinterpol(XY,Z, pk);
   poly = @(x,y) zk + ...
    u(1) * (x-xk).^2 + u(2) * (x-xk).*(y-yk) + ...
    u(3) * (y-yk).^2 + u(4) * (x-xk) + u(5) * (y-yk);

   dpx = @(x,y) 2 * u(1) * (x-xk) + u(2) * (y-yk) + u(4);
   dpy = @(x,y) 2 * u(3) * (y-yk) + u(2) * (x-xk) + u(5);
   
   dpi = vecnorm(XY-pk(1:2),2,2);
   H = mink(dpi,9);
   S = P(dpi <= H(9),:); 
   
   n11 = -dpx(xk,yk); n12 = -dpy(xk,yk); n13 = 1;
   n21 = -dfx(xk,yk); n22 = -dfy(xk,yk); n23 = 1;

   scatter3(S(:,1),S(:,2),S(:,3),'red', 'filled');
   hold on;
   surf(X,Y,poly(X,Y));
   hold on;
   scatter3(xk,yk,zk,'black','filled');
   
end