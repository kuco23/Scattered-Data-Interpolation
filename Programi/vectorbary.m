function out = vectorbary(T,u)
    A = [1 1 1; T'];
    out = (A \ [0; u(1); u(2)])';
end