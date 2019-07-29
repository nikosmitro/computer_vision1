clear all;
close all;
clc;

addpath(genpath('./'));
%% 3.2
%% MultAngleDetect
detector_func = @(I) Multiscale_Angle_Detection(I, 1.4, 1.6, 0.05, 0.005, 2, 4);

descriptor_func = @(I,points) featuresSURF(I,points);
features_multang_SURF = FeatureExtraction(detector_func, descriptor_func);

descriptor_func = @(I,points) featuresHOG(I,points);
features_multang_HOG = FeatureExtraction(detector_func, descriptor_func);    

%% ClassAccuracy MultAngle
[percent_multang_SURF, my_percent_multang_SURF] = ClassAccuracy (features_multang_SURF); 
fprintf('Average Classification MultAng Accuracy for SURF : %f %%\n',mean(percent_multang_SURF)*100);
fprintf('My Average Classification MultAng Accuracy for SURF : %f %%\n',mean(my_percent_multang_SURF)*100);

[percent_multang_HOG, my_percent_multang_HOG] = ClassAccuracy (features_multang_HOG); 
fprintf('Average Classification MultAng Accuracy for HOG : %f %%\n', mean(percent_multang_HOG)*100);
fprintf('My Average Classification MultAng Accuracy for HOG : %f %%\n', mean(my_percent_multang_HOG)*100);
 
%% MultBlobDetect
detector_func = @(I) Multiscale_Blob_Detection(I, 1.5, 0.009, 2, 4, 1);

descriptor_func = @(I,points) featuresSURF(I,points);
features_multblob_SURF = FeatureExtraction(detector_func, descriptor_func);
    
descriptor_func = @(I,points) featuresHOG(I,points);
features_multblob_HOG = FeatureExtraction(detector_func, descriptor_func); 

%% ClassAccuracy MultBlob
[percent_multblob_SURF, my_percent_multblob_SURF] = ClassAccuracy (features_multblob_SURF); 
fprintf('Average Classification multblob Accuracy for SURF : %f %%\n', mean(percent_multblob_SURF)*100);
fprintf('My Average Classification multblob Accuracy for SURF : %f %%\n', mean(my_percent_multblob_SURF)*100);

[percent_multblob_HOG, my_percent_multblob_HOG] = ClassAccuracy (features_multblob_HOG); 
fprintf('Average Classification multblob Accuracy for HOG : %f %%\n', mean(percent_multblob_HOG)*100);
fprintf('My Average Classification multblob Accuracy for HOG : %f %%\n', mean(my_percent_multblob_HOG)*100);

%% MultBoxFilterDetect
detector_func = @(I) Multiscale_Blob_Detection(I, 1.5, 0.009, 2, 4, 2);

descriptor_func = @(I,points) featuresSURF(I,points);
features_multbox_SURF = FeatureExtraction(detector_func, descriptor_func);

descriptor_func = @(I,points) featuresHOG(I,points);
features_multbox_HOG = FeatureExtraction(detector_func, descriptor_func); 

%% ClassAccuracy Multbox
[percent_multbox_SURF, my_percent_multbox_SURF] = ClassAccuracy (features_multbox_SURF); 
fprintf('Average Classification multbox Accuracy for SURF : %f %%\n',mean(percent_multbox_SURF)*100);
fprintf('My Average Classification multbox Accuracy for SURF : %f %%\n',mean(my_percent_multbox_SURF)*100);

[percent_multbox_HOG, my_percent_multbox_HOG] = ClassAccuracy (features_multbox_HOG); 
fprintf('Average Classification multbox Accuracy for HOG : %f %%\n', mean(percent_multbox_HOG)*100);
fprintf('My Average Classification multbox Accuracy for HOG : %f %%\n', mean(my_percent_multbox_HOG)*100);
