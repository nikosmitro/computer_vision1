clc;
clear all;
close all;

addpath(genpath('./'));
addpath(genpath('./matching'),genpath('./detectors'),genpath('./descriptors'),genpath('./classification'));
%% 3.1
load('snrImgSet.mat');
sigma=2;
integra=2.5;
k=0.05;
theta_corn=0.005;
s=1.5;
N=4;

%% Angles Detection 
detector_func = @(I) Angle_Detection_Part3(I, sigma, integra, k, theta_corn);

descriptor_func = @(I,points) featuresSURF(I,points);
[scale_error_ang_SURF, theta_error_ang_SURF] = ...
   evaluation(detector_func, descriptor_func);

descriptor_func = @(I,points) featuresHOG(I,points);
[scale_error_ang_HOG, theta_error_ang_HOG] = ...
   evaluation(detector_func, descriptor_func);

disp('Angles Detection - SURF : Scale_Error');
disp('The scale_error of the first set of images is:');
disp(scale_error_ang_SURF(1));
disp('The scale_error of the second set of images is:');
disp(scale_error_ang_SURF(2));
disp('The scale_error of the third set of images is:');
disp(scale_error_ang_SURF(3));
fprintf('\n');

disp('Angles Detection - SURF : Theta_Error');
disp('The theta_error of the first set of images is:');
disp(theta_error_ang_SURF(1));
disp('The theta_error of the second set of images is:');
disp(theta_error_ang_SURF(2));
disp('The theta_error of the third set of images is:');
disp(theta_error_ang_SURF(3));
fprintf('\n');

disp('Angles Detection - HOG : Scale_Error');
disp('The scale_error of the first set of images is:');
disp(scale_error_ang_HOG(1));
disp('The scale_error of the second set of images is:');
disp(scale_error_ang_HOG(2));
disp('The scale_error of the third set of images is:');
disp(scale_error_ang_HOG(3));
fprintf('\n');

disp('Angles Detection - HOG : Theta_Error');
disp('The theta_error of the first set of images is:');
disp(theta_error_ang_HOG(1));
disp('The theta_error of the second set of images is:');
disp(theta_error_ang_HOG(2));
disp('The theta_error of the third set of images is:');
disp(theta_error_ang_HOG(3));
fprintf('\n');


%% Multiscale Angles Detection 
detector_func = @(I) Multiscale_Angle_Detection(I, sigma, integra, k, theta_corn, s, N);

descriptor_func = @(I,points) featuresSURF(I,points);
[scale_error_multang_SURF, theta_error_multang_SURF] = ...
        evaluation(detector_func, descriptor_func);
    
descriptor_func = @(I,points) featuresHOG(I,points);
[scale_error_multang_HOG, theta_error_multang_HOG] = ...
    evaluation(detector_func, descriptor_func); 

disp('Multiscale Angles Detection - SURF : Scale_Error');
disp('The scale_error of the first set of images is:');
disp(scale_error_multang_SURF(1));
disp('The scale_error of the second set of images is:');
disp(scale_error_multang_SURF(2));
disp('The scale_error of the third set of images is:');
disp(scale_error_multang_SURF(3));
fprintf('\n');

disp('Multiscale Angles Detection - SURF : Theta_Error');
disp('The theta_error of the first set of images is:');
disp(theta_error_multang_SURF(1));
disp('The theta_error of the second set of images is:');
disp(theta_error_multang_SURF(2));
disp('The theta_error of the third set of images is:');
disp(theta_error_multang_SURF(3));
fprintf('\n');

disp('Multiscale Angles Detection - HOG : Scale_Error');
disp('The scale_error of the first set of images is:');
disp(scale_error_multang_HOG(1));
disp('The scale_error of the second set of images is:');
disp(scale_error_multang_HOG(2));
disp('The scale_error of the third set of images is:');
disp(scale_error_multang_HOG(3));
fprintf('\n');

disp('Multiscale Angles Detection - HOG : Theta_Error');
disp('The theta_error of the first set of images is:');
disp(theta_error_multang_HOG(1));
disp('The theta_error of the second set of images is:');
disp(theta_error_multang_HOG(2));
disp('The theta_error of the third set of images is:');
disp(theta_error_multang_HOG(3));
fprintf('\n');

%% Blobs Detection 
detector_func = @(I) Blob_Detection_Part3(I, sigma, theta_corn);

descriptor_func = @(I,points) featuresSURF(I,points);
[scale_error_blobs_SURF, theta_error_blobs_SURF] = ...
        evaluation(detector_func, descriptor_func);
    
descriptor_func = @(I,points) featuresHOG(I,points);
[scale_error_blobs_HOG, theta_error_blobs_HOG] = ...
    evaluation(detector_func, descriptor_func); 

disp('Blobs Detection - SURF : Scale_Error');
disp('The scale_error of the first set of images is:');
disp(scale_error_blobs_SURF(1));
disp('The scale_error of the second set of images is:');
disp(scale_error_blobs_SURF(2));
disp('The scale_error of the third set of images is:');
disp(scale_error_blobs_SURF(3));
fprintf('\n');

disp('Blobs Detection - SURF : Theta_Error');
disp('The theta_error of the first set of images is:');
disp(theta_error_blobs_SURF(1));
disp('The theta_error of the second set of images is:');
disp(theta_error_blobs_SURF(2));
disp('The theta_error of the third set of images is:');
disp(theta_error_blobs_SURF(3));
fprintf('\n');

disp('Blobs Detection - HOG : Scale_Error');
disp('The scale_error of the first set of images is:');
disp(scale_error_blobs_HOG(1));
disp('The scale_error of the second set of images is:');
disp(scale_error_blobs_HOG(2));
disp('The scale_error of the third set of images is:');
disp(scale_error_blobs_HOG(3));
fprintf('\n');

disp('Blobs Detection - HOG : Theta_Error');
disp('The theta_error of the first set of images is:');
disp(theta_error_blobs_HOG(1));
disp('The theta_error of the second set of images is:');
disp(theta_error_blobs_HOG(2));
disp('The theta_error of the third set of images is:');
disp(theta_error_blobs_HOG(3));
fprintf('\n');

%% Multiscale Blobs Detection (type = 1)
detector_func = @(I) Multiscale_Blob_Detection(I, sigma, theta_corn, s, N, 1);

descriptor_func = @(I,points) featuresSURF(I,points);
[scale_error_multblobs_SURF, theta_error_multblobs_SURF] =...
        evaluation(detector_func, descriptor_func);
    
descriptor_func = @(I,points) featuresHOG(I,points);
[scale_error_multblobs_HOG, theta_error_multblobs_HOG] = ...
    evaluation(detector_func, descriptor_func); 

disp('Multiscale Blobs Detection - SURF : Scale_Error');
disp('The scale_error of the first set of images is:');
disp(scale_error_multblobs_SURF(1));
disp('The scale_error of the second set of images is:');
disp(scale_error_multblobs_SURF(2));
disp('The scale_error of the third set of images is:');
disp(scale_error_multblobs_SURF(3));
fprintf('\n');

disp('Multiscale Blobs Detection - SURF : Theta_Error');
disp('The theta_error of the first set of images is:');
disp(theta_error_multblobs_SURF(1));
disp('The theta_error of the second set of images is:');
disp(theta_error_multblobs_SURF(2));
disp('The theta_error of the third set of images is:');
disp(theta_error_multblobs_SURF(3));
fprintf('\n');

disp('Multiscale Blobs Detection - HOG : Scale_Error');
disp('The scale_error of the first set of images is:');
disp(scale_error_multblobs_HOG(1));
disp('The scale_error of the second set of images is:');
disp(scale_error_multblobs_HOG(2));
disp('The scale_error of the third set of images is:');
disp(scale_error_multblobs_HOG(3));
fprintf('\n');

disp('Multiscale Blobs Detection - HOG : Theta_Error');
disp('The theta_error of the first set of images is:');
disp(theta_error_multblobs_HOG(1));
disp('The theta_error of the second set of images is:');
disp(theta_error_multblobs_HOG(2));
disp('The theta_error of the third set of images is:');
disp(theta_error_multblobs_HOG(3));
fprintf('\n');

%% Multiscale BoxFilter Blobs Detection (type !=  1 )
detector_func = @(I) Multiscale_Blob_Detection(I, sigma, theta_corn, s, N, 3);

descriptor_func = @(I,points) featuresSURF(I,points);
[scale_error_multbox_SURF, theta_error_multbox_SURF] = ...
        evaluation(detector_func, descriptor_func);
    
descriptor_func = @(I,points) featuresHOG(I,points);
[scale_error_multbox_HOG, theta_error_multbox_HOG] = ...
    evaluation(detector_func, descriptor_func); 

disp('Multiscale Boxfilter Blobs Detection - SURF : Scale_Error');
disp('The scale_error of the first set of images is:');
disp(scale_error_multbox_SURF(1));
disp('The scale_error of the second set of images is:');
disp(scale_error_multbox_SURF(2));
disp('The scale_error of the third set of images is:');
disp(scale_error_multbox_SURF(3));
fprintf('\n');

disp('Multiscale Boxfilter Blobs Detection - SURF : Theta_Error');
disp('The theta_error of the first set of images is:');
disp(theta_error_multbox_SURF(1));
disp('The theta_error of the second set of images is:');
disp(theta_error_multbox_SURF(2));
disp('The theta_error of the third set of images is:');
disp(theta_error_multbox_SURF(3));
fprintf('\n');

disp('Multiscale Boxfilter Blobs Detection - HOG : Scale_Error');
disp('The scale_error of the first set of images is:');
disp(scale_error_multbox_HOG(1));
disp('The scale_error of the second set of images is:');
disp(scale_error_multbox_HOG(2));
disp('The scale_error of the third set of images is:');
disp(scale_error_multbox_HOG(3));
fprintf('\n');

disp('Multiscale Boxfilter Blobs Detection - HOG : Theta_Error');
disp('The theta_error of the first set of images is:');
disp(theta_error_multbox_HOG(1));
disp('The theta_error of the second set of images is:');
disp(theta_error_multbox_HOG(2));
disp('The theta_error of the third set of images is:');
disp(theta_error_multbox_HOG(3));
