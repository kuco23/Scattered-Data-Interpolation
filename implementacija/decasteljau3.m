function C = decasteljau3(B, u)
    [n,~] = size(B); n = n-1;
    C = B;
    for r=1:n
        c = zeros(n-r);
        for i=0:(n-r)
            for j=0:(n-r-i)
                c(i+1,j+1) = ...
                    u(1) * C(i+1,j+1) + ...
                    u(2) * C(i+1,j+2) + ...
                    u(3) * C(i+2,j+1);
            end
        end
        C = c;
    end
end