function [] = testytest()
    XY = rand(250,2);
    x1 = 0.5; y1 = 0.5; r = 0.1;
    
    d = vecnorm(XY - [x1, y1], 2, 2);
    S = XY(d < r,:);
    
    circle = @(t) [cos(t),sin(t)];
    c = circle(linspace(0,2*pi,100)');
    
    scatter(x1,y1,'black', 'filled');
    hold on;
    scatter(XY(:,1), XY(:,2));
    hold on;
    scatter(S(:,1), S(:,2), 'r', 'filled');
    hold on;
    plot(x1 + r*c(:,1), y1 + r*c(:,2));
    axis equal;
end