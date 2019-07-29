function Blobs_Part3 = Blob_Detection_Part3(Igo,sigma,theta_corn)
     %2.3.1
     tmp = 2*ceil(3*sigma)+1;
     gauss = fspecial('Gaussian',[tmp tmp],sigma);
     Is = imfilter(Igo,gauss,'symmetric');
     [Lx, Ly] = imgradientxy(Is);
     [Lxx, Lxy] = imgradientxy(Lx);
     [Lyx, Lyy] = imgradientxy(Ly);
     R = (Lxx.*Lyy) - (Lxy.*Lyx);
     %2.3.2
     ns = ceil(3*sigma)*2+1;
     B_sq = strel('disk',ns);
     Cond1 = ( R==imdilate(R,B_sq));
     thr = theta_corn.*max(R(:));
     Cond2 = (R>thr);
     Blobs = (Cond1 & Cond2);
     Blobs_Part3 = visualization(sigma,Blobs);
end

