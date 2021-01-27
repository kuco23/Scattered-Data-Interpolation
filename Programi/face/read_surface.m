function surface = read_surface(fpath,fname)

surface = [];

f = fopen(sprintf('%s/%s.tri', fpath,fname), 'rt');
TRIV = fscanf(f,'%d');
fclose(f);
surface.TRIV = reshape(TRIV',[3 length(TRIV(:))/3])';

f = fopen(sprintf('%s/%s.vert', fpath,fname), 'rt');
XX = fscanf(f,'%f');
fclose(f);
XX = reshape(XX',[3 length(XX(:))/3])';
surface.X = XX(:,1);
surface.Y = XX(:,2);
surface.Z = XX(:,3);

f = fopen(sprintf('%s/%s.text', fpath,fname), 'rt');
surface.I = fscanf(f,'%f');
fclose(f);

trisurf(surface.TRIV,surface.X,surface.Y,surface.Z,surface.I)