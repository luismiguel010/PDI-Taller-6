
image_labels = imread('../images/image_labels.png');

%------------------- User Config -------------------------
background_color = 1;
%---------------------------------------------------------

% Find all groups in the image
groups = unique(image_labels);
groups = groups(groups ~= background_color);

[rows, cols] = size (image_labels);


% Calculate centroid of each group
for group_index=1 : length(groups)
    
    current_group = groups(group_index);
    [rows_idx , cols_idx] = find(image_labels == current_group);
    
    
    min_row = min(rows_idx);
    max_row = max(rows_idx);
    
    min_col = min(cols_idx);
    max_col = max(cols_idx);
    
    x_center = round((max_row + min_row)/2);
    y_center = round((max_col + min_col)/2);
    
    
    %Change value of centroid pixel here
    centroid_color = 128;
    
    disp(['centroid at:  ' num2str(x_center), ' in x, ' , num2str(y_center), ' in y']);
    image_labels(x_center,y_center) = centroid_color;
end

imshow(image_labels,jet)

