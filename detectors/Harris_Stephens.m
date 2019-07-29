function [J1,J2,J3] = Harris_Stephens(I,sigma,integ)
    n = ceil(3*sigma)*2+1;
    Gs = fspecial('Gaussian',[n n],sigma);
    Gr = fspecial('Gaussian',[n n],integ);
    Is = imfilter(I,Gs,'symmetric');
    [gx, gy] = imgradientxy(Is);
    J1 = imfilter(gx.*gx, Gr);
    J2 = imfilter(gx.*gy, Gr);
    J3 = imfilter(gy.*gy, Gr);
end