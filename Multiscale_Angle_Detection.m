function [Img,Angles]= Multiscale_Angle_Detection(Igo, sigma, integra, k, theta_corn, s, N)
%2.2.1
sigmas = [];
for i=0:(N-1)
    sigmas(i+1) = s.^i;
end
integs = sigmas.*integra;
sigmas = sigmas.*sigma;

Angle = cell(N,1);
for i=1:N
    Angle{i} = Angle_Detection(Igo,sigmas(i),integs(i),k,theta_corn);
    img = visualization(sigmas(i),Angle{i});
%      figure;
%      interest_points_visualization(Igo,img);
end

%2.2.2
Logs = cell(N,1);
for i=1:N
     tmp = ceil(3.*sigmas(i)).*2+1;
     loG = fspecial('log',[tmp tmp],sigmas(i));
%    gauss = fspecial('Gaussian',[tmp tmp],sigmas(i));
%    Is = imfilter(Igo,gauss);
%    [Lx, Ly] = imgradientxy(Is);
%    [Lxx, ~] = imgradientxy(Lx);
%    [~, Lyy] = imgradientxy(Ly);
%    loG = (sigmas(i).^2).*abs(Lxx+Lyy);
     Logs{i} = (sigmas(i).^2).*abs(imfilter(Igo,loG,'symmetric'));
%    Logs{i} = Logs{i}./max(Logs{i}(:));
%    figure;
%    imshow(Logs{i},[]);
%    title(['Log ',int2str(i)]);
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
%     sigmas(i)
%     sum(angle(:))
%     sum(condition(:))
    Angles{i} = angle & condition;
    Img{i} = visualization(sigmas(i),Angles{i});
end

end