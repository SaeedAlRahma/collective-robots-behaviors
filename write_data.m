function centroid = write_data(file1ID, file2ID, robs, path)
% the function, must be on a folder in matlab path
% file1ID is the id of the open file to write robots to centroid distance
% file2ID is the id of the open file to write path to centroid distance
% robs is an array with robots' position
% path is the course path to follow

    centroid = mean(robs, 2).';
    
    robs_to_centroid = zeros(1,size(robs,2));
    for i=1:size(robs,2)
        robs_to_centroid(i) = pdist2(centroid, robs(:,i).', 'euclidean');
    end
    centroid_to_path = zeros(1,size(path,2));
    for i=1:size(path,2)
        centroid_to_path(i) = pdist2(centroid, path(:,i).', 'euclidean');
    end
    
    fprintf(file1ID,'%3.2f\n', mean(robs_to_centroid));
    fprintf(file2ID,'%3.2f\n', min(centroid_to_path));
%     fprintf(fileID,'%d, %3.2f, %3.2f\n', ...
%         t, mean(robs_to_centroid), min(centroid_to_path));
end