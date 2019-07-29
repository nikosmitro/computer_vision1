function [Dxx,Dyy,Dxy] = box_flt(So,n)
p = floor(n/6);
a = 2*floor(n/6)+1;

l = 3*p+1;
tp = 2*p;
pp = p+1;
ap = a+1;

offset = l+1;
S = cumsum(cumsum(padarray(So,[offset offset],'symmetric'),1),2);
% size(S,2)
% size(S,1)

Z = @(x1,y1,x2,y2) com(S,x1,y1,x2,y2);

imax = size(So,1);
jmax = size(So,2);
Dxx = zeros(imax,jmax);
parfor i=1:imax
    x = i+offset;
    for j=1:jmax
        y = j+offset;
        Dxx(i,j) = -2.*Z(x-tp, y-p, x+tp, y+p) ...
                   +   Z(x-tp,y-l,x+tp,y-pp) ...
                   +   Z(x-tp,y+pp,x+tp,y+l);
    end
end
imax = size(So,1);
jmax = size(So,2);
Dyy = zeros(imax,jmax);
parfor i=1:imax
    x = i+offset;
    for j=1:jmax
        y = j+offset;
        Dyy(i,j) = -2.*Z(x-p, y-tp, x+p, y+tp) ...
            + Z(x-l,y-tp,x-pp,y+tp) ...
            + Z(x+pp,y-tp,x+l,y+tp);
    end
end
imax = size(So,1);
jmax = size(So,2);
Dxy = zeros(imax,jmax);
parfor i=1:imax
    x = i+offset;
    for j=1:jmax
        y = j+offset;
        Dxy(i,j) = Z(x-ap,y-ap,x-1,y-1) ...
            + Z(x+1,y+1,x+ap,y+ap) ...
            - Z(x+1,y-ap,x+ap,y-1) ...
            - Z(x-ap,y+1,x-1,y+ap);
    end
end
end
