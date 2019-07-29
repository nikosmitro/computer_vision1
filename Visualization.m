function [ Visual ] = Visualization( I,N,Angles_Cell,sigmas )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[q,m]=size(I);
index=0;
for l=1:N
    Angles=Angles_Cell{l};
    for i=1:q
        for j=1:m
            if (Angles(i,j)==1)
                index=index+1;
                pixel_x(index)=i;
                pixel_y(index)=j;
                klimakes(index)=sigmas(l);
            end
        end
    end
end

Visual=[pixel_x; pixel_y; klimakes];
Visual=transpose(Visual);
end

