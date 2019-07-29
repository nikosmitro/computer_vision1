function [ J1, J2, J3 ] = Compute_J(I,sigma,p )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ns=ceil(3*sigma)*2+1;
Gs_size=[ns ns];
Gs=fspecial('gaussian',Gs_size,sigma);
Is=imfilter(I,Gs);
np=ceil(3*p)*2+1;
Gp_size=[np np];
Gp=fspecial('gaussian',Gp_size,p);
[Is_grad_x , Is_grad_y]=imgradientxy(Is);
Is_grad_xx=Is_grad_x.*Is_grad_x;
Is_grad_xy=Is_grad_x.*Is_grad_y;
Is_grad_yy=Is_grad_y.*Is_grad_y;
J1=imfilter(Is_grad_xx,Gp);
J2=imfilter(Is_grad_xy,Gp);
J3=imfilter(Is_grad_yy,Gp);
figure(4);
imshow(J3,[]);
end

