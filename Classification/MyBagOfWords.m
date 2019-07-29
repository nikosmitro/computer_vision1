function [BoVWf_tr, BoVWf_ts] = MyBagOfWords(data_tr, data_ts)

train_data_sample = cell2mat(data_tr');

%get a random sample from the 50% of the train data
N = floor(size(train_data_sample,1) / 2) ;
random_index = randsample(1:length(train_data_sample), N);
train_data_sample = train_data_sample(random_index,:);

%construct a lexicon using k-means
centroids = 500;
[~, clusters] = kmeans(train_data_sample, centroids);

for i = 1:size(data_tr,2)
    %for each picture
    local = data_tr{1,i};
    
    %calculate the closer in euclidean distance terms centroid
    distances = LeastEucDist(local, clusters);
    [~,min_distance_centroids] = min(distances');
    
    %construct a histogram based on the centroid selection
    histogram_tr = histc(min_distance_centroids, 1:500);
    
    %normalise using the L2 norm
    histogram_tr = histogram_tr ./ norm(histogram_tr, 2);
    BoVWf_tr(i,:) = histogram_tr;
end

for i = 1:size(data_ts,2)
    %for each picture    
    local = data_ts{1,i};
    
    %calculate the closer in euclidean distance terms centroid
    distances = LeastEucDist(local,clusters);  
    [~,min_distance_centroids] = min(distances');
    
    %construct a histogram based on the centroid selection
    histogram_ts = histc(min_distance_centroids, 1:500);

    %normalise using the L2 norm
    histogram_ts = histogram_ts ./ norm(histogram_ts, 2);
    BoVWf_ts(i,:) = histogram_ts;
end

end
