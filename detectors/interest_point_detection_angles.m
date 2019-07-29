clear all;
close all;
%% Αρχικοποίηση
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


%% Aνίχνευση γωνιών σε μια κλίμακα
A = Angle_Detection(Igo,sigma,integra,k,theta_corn);
figure;
interest_points_visualization(Io,visualization(sigma,A));

%% Πολυκλιμακωτή Ανίχνευση γωνιών
[Imgs,~] = Multiscale_Angle_Detection(Igo, sigma, integra, k, theta_corn, s, N);
L=[];
for i=1:size(Imgs,2)
    L = [L ; Imgs{i}];
end
figure;
interest_points_visualization(Io,L);

