function  Angles_Part3 = Angle_Detection_Part3( Igo, sigma, integra, k, theta_corn )
%% 2.1.1 
[J1,J2,J3] = Harris_Stephens(Igo,sigma,integra);

%% 2.1.2
lp = (1/2)*(J1+J3+sqrt((J1-J3).^2+4.*(J2.^2)));
lm = (1/2)*(J1+J3-sqrt((J1-J3).^2+4.*(J2.^2)));
R = lm.*lp - k.*((lm+lp).^2);



%% 2.1.3

%2.1.3.S1
ns = ceil(3*sigma)*2+1;
B_sq = strel('disk',ns);
Cond1 = ( R==imdilate(R,B_sq));
%2.1.3.S2
thr = theta_corn.*max(R(:));
Cond2 = (R>thr);
Angles = (Cond1 & Cond2);
%Angles_Part3 : Coordinates and Scales (a NX3 array input for the descriptors)
Angles_Part3=visualization(sigma,Angles);


end

