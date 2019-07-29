function distances = LeastEucDist(local, clusters)
[data_size, ~] = size(local);
[centres_num, ~] = size(clusters);

% d = local^2 + clusters^2 - 2*local*clusters
distances = (ones(centres_num, 1) * sum((local.^2)', 1))' + ones(data_size, 1) * sum((clusters.^2)',1) - 2.*(local*(clusters'));

% conceive negatives as zeros
if any(any(distances < 0))
  distances(distances < 0) = 0;
end

end