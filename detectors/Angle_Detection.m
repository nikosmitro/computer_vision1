function Angles = Angle_Detection(Igo, sigma, integra, k, theta_corn)
%% 2.1.1
[J1,J2,J3] = Harris_Stephens(Igo,sigma,integra);
% figure(1);
% imshow(J1,[]);
% figure(2);
% imshow(J2,[]);
% figure(3);
% imshow(J3,[]);
%% 2.1.2
lp = (1/2)*(J1+J3+sqrt((J1-J3).^2+4.*(J2.^2)));
lm = (1/2)*(J1+J3-sqrt((J1-J3).^2+4.*(J2.^2)));
R = lm.*lp - k.*((lm+lp).^2);

% figure;
% imshow(lp,[]);
% title(['$\lambda_{+}$ for scale $\sigma = ',num2str(sigma),'$ and $\rho = ',num2str(integra),'$'],'interpreter','Latex');
% figure;
% imshow(lm,[]);
% title(['$\lambda_{-}$ for scale $\sigma = ',num2str(sigma),'$ and $\rho = ',num2str(integra),'$'],'interpreter','Latex');
% figure;
% imshow(R,[]);
% title(['$R$ for scale $\sigma = ',int2str(sigma),'$ and $\rho = ',int2str(integra),'$'],'interpreter','Latex');

%% 2.1.3

%2.1.3.S1
ns = ceil(3*sigma)*2+1;
B_sq = strel('disk',ns);
Cond1 = ( R==imdilate(R,B_sq));
%2.1.3.S2
thr = theta_corn.*max(R(:));
Cond2 = (R>thr);
Angles = (Cond1 & Cond2);

% figure;
% imshow(Angles,[]);
end
