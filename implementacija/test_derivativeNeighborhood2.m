function [] = test_derivativeNeighborhood2()
    XY = rand(20,2);
    x1 = 0.5; y1 = 0.5; r = 0.5;
    
    d = vecnorm(XY - [x1, y1], 2, 2);
    filt = (d < r);
    S = XY(filt,:);
    R = XY(~filt,:);
    W = vecnorm(S - [x1,y1],2,2);
    W = (r - W) ./ (r .* W);
    
    circle = @(t) [cos(t),sin(t)];
    c = circle(linspace(0,2*pi,100)');
    
    scatter(x1,y1,'black', 'filled');
    hold on;
    scatter(R(:,1), R(:,2));
    hold on;
    scatter(S(:,1), S(:,2), W*20, 'r', 'filled');
    hold on;
    plot(x1 + r*c(:,1), y1 + r*c(:,2), 'r');
    axis equal;
    set(gca,'visible','off')
end