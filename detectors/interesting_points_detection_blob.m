clear all;
close all;
%% Aρχικοποίηση
inputs = {'matrix17.png','sunflowers17.png'};
Io = imread(inputs{2});
Igo = rgb2gray(Io);
Igo = im2double(Igo);
figure;
%subplot(1,2,1);
imshow(Igo);

%for simple
theta_corn = 0.009;
sigma = 2;
s = 1.5;
N=1;

% theta_corn = 0.01;
% sigma = 2;
% s = 1.5;
% N = 4;

type = 2;

%% 2.3 : Aνίχνευση Blobs σε μια κλίμακα
B = Blob_Detection(Igo,sigma,theta_corn);
%figure;
%imshow(B);

Img = visualization(sigma,B);

figure;
%subplot(1,2,2);
interest_points_visualization(Io,Img);
title('Blob Detection');
%% 2.4 : Πολυκλιμακωτή Aνίχνευση Blobs
%2.4 a
[Imgs,~] = Multiscale_Blob_Detection(Igo,sigma,theta_corn,s,N,type);
L=[];
for i=1:size(Imgs,1)
    L = [L ; Imgs{i}];
end

figure;
interest_points_visualization(Io,L);
title('Multiscale Blob Detection');
% % 2.4 b
% sigma = 2;
% [Imgs,~] = Multiscale_Blob_Detection(Igo,sigma,theta_corn,s,N,3);
% L=[];
% for i=1:size(Imgs,1)
%     L = [L ; Imgs{i}];
% end
% 
% figure(4);
% %subplot(1,2,2);
% interest_points_visualization(Io,L);
% title('Multiscale Blob Detection (using matlab built in)');
