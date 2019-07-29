function C = EdgeEval(original, edges, theta_real_edge_thr)
B = strel('disk',1,4);
M = imdilate(original,B)-imerode(original,B);
T = M>theta_real_edge_thr;
% figure;
% imshow(T);
common_edges = edges & T;
card_int = sum(common_edges(:));
card_real = sum(T(:));
card_aprox = sum(edges(:));

C = ((card_int./card_real) + (card_int./card_aprox))./2;
end