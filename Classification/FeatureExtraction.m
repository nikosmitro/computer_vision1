function features = FeatureExtraction(detector_func,descriptor_func)
path{1} = './Data/TUGraz_person';
path{2} = './Data/TUGraz_cars';
path{3} = './Data/TUGraz_bike';
name{1} = '/person_';
name{2} = '/carsgraz_';
name{3} = '/bike_';

addpath(genpath('../detectors'));
addpath(genpath('../descriptors'));
t2=0;

for c=1:size(path,2);
    dir1=dir(path{c});
    num_im = length(dir1)-2;
    j=1;
    for i=1:num_im
        try
            I=rgb2gray(im2double(imread([path{c} name{c} sprintf('%03d',i) '.png'])));
            I=imresize(I,0.5);
            %% Interest Points
            t1=tic;
            %[points,scales] = detector_func(I);
            points = detector_func(I);
            t2=t2+toc(t1);
            %% Descriptors
            features{c}{j} =descriptor_func(I,points);
            j=j+1;
        catch err
            %display(err);
            ;
            %err
        end
    end
end

fprintf('Interest Points Detection Total Time: %f sec\n',t2);
end