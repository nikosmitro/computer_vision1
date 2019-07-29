function [percent,percent_my] = ClassAccuracy(features)

addpath(genpath('libsvm-3.17'));
%% Image Classification

parfor k = 1:5
    %% Split train and test set
    [data_train, label_train, data_test, label_test] = createTrainTest(features, k);
    disp('train-test ok')
    %% Bag of Words - My Bag of Words
    [BOF_tr, BOF_ts] = BagOfWords(data_train, data_test);
    [My_BOF_tr, My_BOF_ts] = MyBagOfWords(data_train, data_test);
    disp('lexikon ok');
    %% SVM classification
    [percent(k), ~] = svm(BOF_tr, label_train, BOF_ts, label_test);
    [percent_my(k), ~] = svm(My_BOF_tr, label_train, My_BOF_ts, label_test);
    fprintf('Classification Accuracy: %f %%\n',percent(k)*100);
    fprintf('My Classification Accuracy: %f %%\n',percent_my(k)*100);
end    

end

