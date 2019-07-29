function [ D ] = EdgeDetect(I,Sn,threshold,LaplacType)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n=ceil(3*Sn)*2+1;
Gsize=[n n];
G=fspecial('gaussian',Gsize,Sn);
%LoG=fspecial('log',Gsize,Sn);
%Iss=conv2(G,I1);
Is=imfilter(I,G);
B=strel('diamond',1);
switch LaplacType
    case 0
        LoG=fspecial('log',Gsize,Sn);
        L1=imfilter(I,LoG);
        figure(4);
        imshow(L1);
        X=(L1 >= 0);
        Y=imdilate(X,B) - imerode(X,B);
        [Is_grad_x, Is_grad_y]=gradient(Is);
        Is_grad=sqrt(Is_grad_x.^2 + Is_grad_y.^2);
        Is_grad_max=max(max(abs(Is_grad)));
        [k,m]=size(Is);
        D=zeros(k,m);
        for i=1:k
            for j=1:m
                if (Y(i,j)==1) && (abs(Is_grad(i,j)) > (threshold*Is_grad_max))
                    D(i,j)=1;
                end
            end
        end
        figure(8);
        imshow(D);
    case 1
        Is_dil=imdilate(Is,B);
        figure(5);
        imshow(Is_dil);
        Is_er=imerode(Is,B);
        figure(6);
        imshow(Is_er);
        L2=Is_dil+Is_er-2*Is;
        figure(7);
        imshow(L2);
        X=(L2 >= 0);
        Y=imdilate(X,B) - imerode(X,B);
        Is_grad=gradient(Is);
        Is_grad_max=max(max(abs(Is_grad)));
        [k,m]=size(Is);
        D=zeros(k,m);
        for i=1:k
            for j=1:m
                if (Y(i,j)==1) && (abs(Is_grad(i,j)) > (threshold*Is_grad_max))
                    D(i,j)=1;
                end
            end
        end
        figure(8);
        imshow(D);
    otherwise
        disp('Wrong Value:LaplacType can be either 0 for Linear Laplacian or 1 for Non-Linear Laplacian');
end
% D_8bit=uint8(255*mat2gray(D));
% figure(9);
% imshow(D_8bit);
            
end

