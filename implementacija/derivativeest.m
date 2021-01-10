function der = derivativeest(P)
    M = 9; % stevilo vozlisc, ki jih upostevamo v okolici
    % predpostavi N >= 9
    [N, ~] = size(P);
    der = zeros(N,2);
    for i=1:N
        u = derinterpol(P(:,1:2),P(:,3),P(i,:));
        der(i,:) = u(4:5);
    end
end