close all;
clear all;
%%1.1 : Δημιουργία Εικόνων Εισόδου
%1.1.1 : Kανονικιποίηση Αρχικής Εικόνας
Io = imread('edgetest_17.png');
Io = im2double(Io);
sig1 = 3 ;
sig2 = 1.5;
figure;
imshow(Io);
%1.1.2 : Προσθήκη Θορύβου
nsigma1 = get_sigma_from_psnr(Io,10);
nsigma2 = get_sigma_from_psnr(Io,20);
%i)Θορυβώδης εικόνα για PSNR = 10db
I1 = imnoise(Io,'gaussian',0,nsigma1.^2);
figure;
imshow(I1);
title('Noised signal $I_{1}$ for $PSNR = 10$','interpreter','Latex');
%ii)Θορυβώδης εικόνα για PSNR = 20db
I2 = imnoise(Io,'gaussian',0,nsigma2.^2);
figure;
imshow(I2);
title('Noised signal $I_{2}$ for $PSNR = 20$','interpreter','Latex');
%%1.2 : Υλοποίηση Αλγορίθμων Ανίχνευσης Ακμών
y11 = EdgeDetect(I1,sig1,0.2,'linear');
y12 = EdgeDetect(I1,sig1,0.2,'non-linear');
y21 = EdgeDetect(I2,sig2,0.2,'linear');
y22 = EdgeDetect(I2,sig2,0.2,'non-linear');
%Plotting
figure;
imshow(y11);
title(['Linear Edge Detection $(PSNR=10,\sigma = ',int2str(sig1),')$'],'interpreter','Latex');
figure;
imshow(y12);
title(['Non-Linear Edge Detection $(PSNR=10,\sigma = ',int2str(sig1),')$'],'interpreter','Latex');
figure;
imshow(y21);
title(['Linear Edge Detection $(PSNR=20,\sigma = ',int2str(sig2),')$'],'interpreter','Latex');
figure;
imshow(y22);
title(['Non-Linear Edge Detection $(PSNR=20,\sigma = ',int2str(sig2),')$'],'interpreter','Latex');
%%1.3 : Αξιολόγηση των Αποτελεσμάτων Ανίχνευσης Ακμών
C11 = EdgeEval(Io,y11,0.1);
disp('Evaluation of linear method with PSNR=10db is:');
disp(C11);
C12 = EdgeEval(Io,y12,0.1);
disp('Evaluation of non-linear method with PSNR=10db is:');
disp(C12);
C21 = EdgeEval(Io,y21,0.1);
disp('Evaluation of linear method with PSNR=20db is:');
disp(C21);
C22 = EdgeEval(Io,y22,0.1);
disp('Evaluation of non-linear method with PSNR=20db is:');
disp(C22);
