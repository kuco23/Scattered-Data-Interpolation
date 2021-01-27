function out = pointbary(T,xy)
    A = [1 1 1; T'];
    out = (A \ [1; xy(1); xy(2)])';
end