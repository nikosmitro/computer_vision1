function Img = visualization(sigma,B)
Img = [];
for i=1:size(B,1)
    for j=1:size(B,2)
        if(B(i,j) == 1)
            Img = [Img ; [j, i, sigma]];
        end
    end
end
end