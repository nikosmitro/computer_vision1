clear all;
close all;

inputs = {'matrix17.png','sunflowers17.png'};
Io = imread(inputs{1});
Igo = rgb2gray(Io);
Igo = im2double(Igo);
figure;
imshow(Igo);

N=4;
sigma = 1.3;
integra = 1.1;
theta_corn = 0.029;
k=0.09;
s=1.7;

% N=4;
% sigma = 2;
% integra = 2.5;
% theta_corn = 0.005;
% k=0.05;
% s=1.5;



A = Angle_Detection(Igo,sigma,integra,k,theta_corn);
figure;
interest_points_visualization(Io,visualization(sigma,A));

[Imgs,~] = Multiscale_Angle_Detection(Igo, sigma, integra, k, theta_corn, s, N);
L=[];
for i=1:size(Imgs,2)
    L = [L ; Imgs{i}];
end
figure;
interest_points_visualization(Io,L);

% for k=1:N
%     figure(k)
%     angle = Angle{k};
%     overlap=[];
%     for i=1:size(Igo,1)
%          for j=1:size(Igo,2)
%              if(angle(i,j) == 1)
%                 overlap = [overlap ; [j i sigmas(k)]];
%              end
%          end
%     end
%     interest_points_visualization(Io,overlap);
%     title(['Sigma = ',num2str(sigmas(k))]);
% end