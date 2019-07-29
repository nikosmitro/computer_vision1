function Angles = Multiscale_Angle_Detection(I, sigma, integra, k, theta_corn, s, N)
%2.2.1
%I = rgb2gray(I);
sigmas = [];
for i=0:(N-1)
    sigmas(i+1) = s.^i;
end
integs = sigmas.*integra;
sigmas = sigmas.*sigma;

Angle = cell(N,1);
for i=1:N
    Angle{i} = Angle_Detection(I,sigmas(i),integs(i),k,theta_corn);
end

%2.2.2
Logs = cell(N,1);
for i=1:N
     tmp = ceil(3.*sigmas(i)).*2+1;
     loG = fspecial('log',[tmp tmp],sigmas(i));
     Logs{i} = (sigmas(i).^2).*abs(imfilter(I,loG,'symmetric'));
end
clear Is Gs Lx Ly Lxx Lyy;

Angles = [];
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
        Angles = [Angles ; visualization(sigmas(i),angle & condition)];
end

end