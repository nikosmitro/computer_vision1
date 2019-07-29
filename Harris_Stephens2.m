function [ Angles ] = Harris_Stephens(I,sigma,p,k,thita_corn)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[J1,J2,J3]=Compute_J(I,sigma,p);
Lp=(1/2)*(J1+J3+sqrt((J1-J3).^2+4*(J2.^2)));
Lm=(1/2)*(J1+J3-sqrt((J1-J3).^2+4*(J2.^2)));
R=Lm.*Lp-k*((Lm+Lp).^2);
ns=ceil(3*sigma)*2+1;
B_sq=strel('disk',ns);
Cond1=(R==imdilate(R,B_sq));
Rmax=max(R(:));
Angles=(Cond1 & (R >thita_corn*Rmax));
end

