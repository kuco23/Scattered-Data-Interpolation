function [] = test()
    f2 = @(x,y) 0.75 * exp(-((9*x-2).^2 + (9*y-2).^2/4)) ...
        + 0.75 * exp(-(9*x+1).^2/49 - (9*y+1)/10) ...
        + 0.5 * exp(-((9*x-7).^2 + (9*y-3).^2)/4) ...
        - 0.2 * exp(-(9*x-4).^2 - (9*y-7).^2);
    
    n = 150; % random podatki
    m = 50; % m x m meshgrid
    
    XY = rand(n,2);
    X = XY(:,1); Y = XY(:,2); Z = f2(X, Y); % podatki
    % scatter3(X,Y,Z); % razsevni diagram podatkov
    [X2,Y2] = meshgrid(linspace(0,1,m)); % testne tocke aproksimacije
    
    dF = derivative_estimation([X,Y,Z]);
    [tri,B] = scattered_interpolation([X,Y,Z],dF); % podatki za opis krp
    ZApprox = scattered_interpolation_values(tri,B,[X2(:),Y2(:)]);
    
    surf(X2,Y2,reshape(ZApprox,m,m));
end