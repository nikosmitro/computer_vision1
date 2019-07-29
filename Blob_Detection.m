function Blobs = Blob_Detection(Igo,sigma,theta_corn)
     %2.3.1
     tmp = 2*ceil(3*sigma)+1;
     gauss = fspecial('Gaussian',[tmp tmp],sigma);
     Is = imfilter(Igo,gauss,'symmetric');
     [Lx, Ly] = imgradientxy(Is);
     [Lxx, Lxy] = imgradientxy(Lx);
     [Lyx, Lyy] = imgradientxy(Ly);
     R = (Lxx.*Lyy) - (Lxy.*Lyx);
%      figure, imshow(Lxx,[]), title(['$L_{xx}$ for $\sigma = ',num2str(sigma),'$'],'interpreter','Latex');
%      figure, imshow(Lyy,[]), title(['$L_{yy}$ for $\sigma = ',num2str(sigma),'$'],'interpreter','Latex');
%      figure, imshow(Lxy,[]), title(['$L_{xy}$ for $\sigma = ',num2str(sigma),'$'],'interpreter','Latex');
     figure, imshow(R,[]), title(['$R$ for $\sigma = ',num2str(sigma),'$'],'interpreter','Latex');
     %2.3.2
     ns = ceil(3*sigma)*2+1;
     B_sq = strel('disk',ns);
     Cond1 = ( R==imdilate(R,B_sq));
     thr = theta_corn.*max(R(:));
     Cond2 = (R>thr);
     Blobs = (Cond1 & Cond2);
end
