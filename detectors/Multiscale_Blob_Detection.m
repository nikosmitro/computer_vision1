function Blobs = Multiscale_Blob_Detection(I,sigma,theta_corn,s,N,type)
sigmas = [];
for i=0:(N-1)
    sigmas(i+1) = s.^i;
end
sigmas = sigmas.*sigma;

blobs = cell(N,1);

for i=1:N
    if(type==1)
        blobs{i} = Blob_Detection(I,sigmas(i),theta_corn);
    elseif(type==2)
        ns = ceil(3*sigmas(i))*2+1;
        [Lxx, Lyy, Lxy] = box_flt(I,ns);
        R = Lxx.*Lyy - ((0.9.*Lxy).^2);
        B_sq = strel('disk',ns);
        Cond1 = ( R==imdilate(R,B_sq));
        thr = theta_corn.*max(R(:));
        Cond2 = (R>thr);
        blobs{i} = (Cond1 & Cond2);
    else
        ns = ceil(3*sigmas(i))*2+1;
        IntegralImg = cumsum(cumsum(I,2),1);
        [Dxx, Dyy, Dxy] = BoxFilter(ns);
        Lxx = integralFilter(IntegralImg,Dxx);
        Lyy = integralFilter(IntegralImg,Dyy);
        Lxy = integralFilter(IntegralImg,Dxy);
        %Padding Arrays To Enable The Computation of R
        Lxx=padarray(Lxx,[Dxx.Size(1) Dxx.Size(2)],'post');
        Lyy=padarray(Lyy,[Dyy.Size(1) Dyy.Size(2)],'post');
        Lxy=padarray(Lxy,[Dxy.Size(1) Dxy.Size(2)],'post');
        R = Lxx.*Lyy - ((0.9*Lxy).^2);
        B_sq = strel('disk',ns);
        Cond1 = ( R==imdilate(R,B_sq));
        thr = theta_corn.*max(R(:));
        Cond2 = (R>thr);
        blobs{i} = (Cond1 & Cond2);
    end
end

Logs = cell(N,1);
for i=1:N
    tmp = ceil(3.*sigmas(i)).*2+1;
    loG = fspecial('log',[tmp tmp],sigmas(i));
    Logs{i} = (sigmas(i).^2).*abs(imfilter(I,loG));
end
clear Is Gs Lx Ly Lxx Lyy;

Blobs = [];
if(N~=1)
for i=1:N
    blob = blobs{i};
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
    Blobs = [Blobs ; visualization(sigmas(i),blob & condition)];
end
elseif(N==1)
    Blobs = visualization(sigmas(1),blobs);
end
end