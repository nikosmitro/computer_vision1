
%%Meros1
%%1.1 Creating Input Images
PSNR1=20;
PSNR2=10;
Io=imread('edgetest_17.png');
Io=im2double(Io);
figure(1);
imshow(Io);
%Imax_columns=max(Io);
%Imax=max(Imax_columns);
Imax=max(max(Io));
%Imin_columns=min(Io);
%Imin=min(Imin_columns);
Imin=min(min(Io));
Sn1=(Imax-Imin)/10^(PSNR1/20);
Sn2=(Imax-Imin)/10^(PSNR2/20);
I1=imnoise(Io,'gaussian',0,Sn1^2);
I2=imnoise(Io,'gaussian',0,Sn2^2);
%I11=Io + sqrt(Sn1^2)*randn(523,537) +0;
I1_8bit=uint8(255*mat2gray(I1));
I2_8bit=uint8(255*mat2gray(I2));
figure(2);
imshow(I1);
figure(3);
imshow(I2);
%%1.2 Algoriphms for Detecting Edges
D1=EdgeDetect(I1,1.5,0.2,0);
figure(12);
imshow(D1);
D2=EdgeDetect(I2,3,0.2,0);
figure(13);
imshow(D2);

%%1.3.Αξιολόγηση των Αποτελεσμάτων Ανίχνευσης Ακμών
B=strel('diamond',1);
rl_threshold=0.3;
M=imdilate(Io,B) - imerode(Io,B);
T=(M > rl_threshold);
figure(10);
imshow(T);
%Tομή D και T
[k,m]=size(Io);
Tomi=zeros(k,m);
for i=1:k
    for j=1:m
        if ((T(i,j)==1) && (D1(i,j)==1))
            Tomi(i,j)=1;
        end
    end
end
figure(11);
imshow(Tomi);
card_Tomis=sum(Tomi(:));
%card T
card_T=sum(T(:));
%card D
card_D=sum(D1(:));
%C array
C=((card_Tomis/card_T)+(card_Tomis/card_D))/2;

%%Μέρος 2ο
I_color=imread('matrix17.png');
I_gray=rgb2gray(I_color);
I_gray=im2double(I_gray);
figure(1);
imshow(I_gray);
% Visual=AngleDetect(I_gray,2,2.5,0.05,0.005,1.5,4);
sigma=2;
p=2.5;
k=0.05;
thita_corn=0.005;
s=1.5;
N=4;
ps=zeros(N);
sigmas=zeros(N);
Angles_Cell=cell(N,1);
%filters=cell(N,1);
LoGs=cell(N,1);
%[q,m]=size(IM);
for i=1:N
    sigmas(i)=(s^(i-1))*sigma;
    ps(i)=(s^(i-1))*p;
    Angles=Harris_Stephens(I_gray,sigmas(i),ps(i),k,thita_corn);
    Angles_Cell{i}=Angles;
    ns=ceil(3*sigmas(i))*2+1;
    Gsize=[ns ns];
    filter=fspecial('log',Gsize,sigmas(i));
    LoGs{i}=imfilter(I_gray,filter);
end
% if N>1
%     Angles_Cell=Angle_Policlimax(I,N,Angles_Cell,LoGs);
% end
% Visual=Visualization(I,N,Angles_Cell);
[q,m]=size(I_gray);
if N>1
    disp('y');
    for i=1:N
        Angles=Angles_Cell{i};
        Log=abs(LoGs{i});
        if i==1
            Log_n=abs(LoGs{i+1});
            for j=1:q
                for l=1:m
                    while (Angles(j,l)==1)
                        if (Log(j,l)<Log_n(j,l))
                            Angles(j,l)=0;
                        end
                    end
                end
            end
            Angles_Cell{i}=Angles;
        elseif i==N
            Log_p=abs(LoGs{i-1});
            for j=1:q
                for l=1:m
                    while (Angles(j,l)==1)
                        if (Log(j,l)<Log_p(j,l))
                            Angles(j,l)=0;
                        end
                    end
                end
            end
            Angles_Cell{i}=Angles;
        else
            Log_p=abs(LoGs{i-1});
            Log_n=abs(LoGs{i+1});
            for j=1:q
                for l=1:m
                    while (Angles(j,l)==1)
                        if ((Log(j,l)<Log_p(j,l)) || (Log(j,l)<Log_n(j,l)))
                            Angles(j,l)=0;
                        end
                    end
                end
            end
            Angles_Cell{i}=Angles;
        end
    end
end
Visual=Visualization(I_gray,N,Angles_Cell,sigmas);
interest_points_visualization(I_color,Visual);
% ns=ceil(3*sigma)*2+1;
% Gs_size=[ns ns];
% Gs=fspecial('gaussian',Gs_size,sigma);
% Is=imfilter(IMo,Gs);
% figure(2);
% imshow(Is);
% p=2.5;
% np=ceil(3*p)*2+1;
% Gp_size=[np np];
% Gp=fspecial('gaussian',Gp_size,p);
% [Is_grad_x , Is_grad_y]=imgradientxy(Is);
% Is_grad_xx=Is_grad_x.*Is_grad_x;
% Is_grad_xy=Is_grad_x.*Is_grad_y;
% Is_grad_yy=Is_grad_y.*Is_grad_y;
% J1=imfilter(Is_grad_xx,Gp);
% %J1gray=rgb2gray(J1);
% figure(3);
% imshow(J1,[]);
% J2=imfilter(Is_grad_xy,Gp);
% %J2gray=rgb2gray(J2);
% figure(4);
% imshow(J2,[]);
% J3=imfilter(Is_grad_yy,Gp);
% %J3gray=rgb2gray(J3);
% figure(5);
% imshow(J3,[]);

%2.1.2
% k=0.05;
% thita_corn=0.005;
% Lp=(1/2)*(J1+J3+sqrt((J1-J3).^2+4*(J2.^2)));
% Lm=(1/2)*(J1+J3-sqrt((J1-J3).^2+4*(J2.^2)));
% R=Lm.*Lp-k*((Lm+Lp).^2);
% ns=ceil(3*sigma)*2+1;
% B_sq=strel('disk',ns);
% Cond1=(R==imdilate(R,B_sq));
% Rmax=max(R(:));
% Angles=(Cond1 & (R >thita_corn*Rmax));
% %[q,m]=size(R);
% % Angles=zeros(k,m);
% % for i=1:k
% %     for j=1:m
% %         if ((R(i,j)>thita_corn*Rmax)&&(Cond1(i,j)==1))
% %         end
% %     end
% % end
% number_of_angles=sum(Angles(:));
% sigmas=[];
% % for l=1:number_of_angles
% %     klimakes(l)=sigma;
% % end
% pixel_x=[];
% pixel_y=[];
% index=0;
% for i=1:q
%     for j=1:m
%         if (Angles(i,j)==1)
%             index=index+1;
%             pixel_x(index)=i;
%             pixel_y(index)=j;
%         end
%     end
% end
% Visual=[pixel_x; pixel_y; sigmas];
% %2.2
% N=4;
% sigma=2;
% s=1.5;
% p=2.5;
% k=0.05;
% thita_corn=0.005;
% ps=zeros(N);
% sigmas=zeros(N);
% Angles_Cell=cell(N,1);
% filters=cell(N,1);
% LoGs=cell(N,1);
% [q,m]=size(I_gray);
% for i=1:N
%     sigmas(i)=(s^(i-1))*sigma;
%     ps(i)=(s^(i-1))*p;
%     Angles=Harris_Stephens(I_gray,sigmas(i),ps(i),k,thita_corn);
%     Angles_Cell{i}=Angles;
%     ns=ceil(3*sigmas(i))*2+1;
%     Gsize=[ns ns];
%     filters{i}=fspecial('log',Gsize,sigmas(i));
%     LoGs{i}=imfilter(I_gray,filters{i});
% end
% sigmas=transpose(sigmas);
% %Angles_Final=cell(N,1);
% for i=1:N
%     Angles=Angles_Cell{i};
%     Log=LoGs{i};
%     if i==1
%         Log_n=LoGs{i+1};
%         for j=1:q
%             for l=1:m
%                 if ((Angles(j,l)==1) && (Log(j,l)<Log_n(j,l)))
%                     Angles(j,l)=0;
%                 end
%             end
%         end
%         Angles_Cell{i}=Angles;
%     elseif i==N
%         Log_p=LoGs{i-1};
%         for j=1:q
%             for l=1:m
%                 if ((Angles(j,l)==1) && (Log(j,l)<Log_p(j,l)))
%                     Angles(j,l)=0;
%                 end
%             end
%         end
%         Angles_Cell{i}=Angles;
%     else
%         Log_p=LoGs{i-1};
%         Log_n=LoGs{i+1};
%         for j=1:q
%             for l=1:m
%                 if ~((Angles(j,l)==1) && (Log(j,l)>Log_p(j,l)) && (Log(j,l)>Log_n(j,l)))
%                     Angles(j,l)=0;
%                 end
%             end
%         end
%         Angles_Cell{i}=Angles;
%     end
% end
                    
                
                
            


        
        


