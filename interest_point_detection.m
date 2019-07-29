clear all;
close all;

Io = imread('sunflowers17.png');
Igo = rgb2gray(Io);
Igo = im2double(Igo);
figure(4);
imshow(Igo);

N=4;
sigma = 2;
integra = 2.5;
theta_corn = 0.005;
k=0.05;
s=1.5;

sigmas = [];
for i=0:(N-1)
    sigmas(i+1) = s.^i;
end
integs = sigmas.*integra;
sigmas = sigmas.*sigma;

Angle = cell(N,1);
for i=1:N
    Angle{i} = Angle_Detection(Igo,sigmas(i),integs(i),k,theta_corn);
end

Logs = cell(N,1);
for i=1:N
     tmp = ceil(3.*sigmas(i)).*2+1;
     %loG = fspecial('log',[tmp tmp],sigmas(i));
     gauss = fspecial('Gaussian',[tmp tmp],sigmas(i));
     Is = imfilter(Igo,gauss);
     [Lx, Ly] = imgradientxy(Is);
     [Lxx, ~] = imgradientxy(Lx);
     [~, Lyy] = imgradientxy(Ly);
     flt = (sigmas(i).^2).*abs(Lxx+Lyy);
     Logs{i} = imfilter(Igo,flt);
end
clear Is Gs Lx Ly Lxx Lyy;

Angles = cell(N,1);
for i=1:N
    angle = Angle{i};
    logs = Logs{i};
    if(i==1)
        logn = Logs{i+1};
        condition = (logs>logn);
    elseif(i==N)
        logp = Logs{i-1};
        condition = (logs>logp);
    else
        logn = Logs{i+1};
        logp = Logs{i-1};
        condition = (logs>logp) & (logs>logn);
    end
    Angles{i} = angle & condition;    
end

ImgA = cell(N,1);
Img = [];
for k =1:N
    angle = Angles{k};
    for i=1:size(Igo,1)
         for j=1:size(Igo,2)
             if(angle(i,j) == 1)
                Img = [Img ; [j i sigmas(k)]];
             end
         end
    end
end

figure;
interest_points_visualization(Io,Img);

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