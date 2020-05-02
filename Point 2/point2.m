clear all
close all
clc

%------------------- User Config -------------------------
background_color = 0;
%---------------------------------------------------------

image = imread('../images/nice_work.png');

% To convert image to binary
image = im2bw(image,0.8);

% ---------------- For fill image borders ----------------
[rows, cols] = size(image);

row_fill = ones(cols,1)'*background_color;
col_fill = ones(rows + 2,1)*background_color;

image = [row_fill;image;row_fill];
image = [col_fill image col_fill];
%--------------------------------------------------------


%  Matrix to store labels
image_labels = ones(rows+2,cols+2)*background_color;
current_label = 2;

for row=2:rows+1
    
    for col=2:cols+1
        
        % If current value is not backround value
        if(image(row,col)~=background_color)
            
            % search if any neighbor has a assigned label
            search_matrix = image_labels(row - 1 : row + 1, col-1:col+1);
            search_matrix_idx = search_matrix~=background_color;
            
            % create a vector with the labels of your neighbors
            flat_matrix = search_matrix(search_matrix_idx);
            flat_matrix = flat_matrix(:)';
            
            
            % If the element has neighbors, with an assigned label,
            % it takes that value, otherwise it creates a new one.
            if(sum(search_matrix_idx(:))==0)
                current_label = current_label + 1;
                label = current_label;
                
                % To replace all repeated labels in image
            else
                labels = unique(flat_matrix);
                label = min(labels);
                
                if(length(labels)>1)
                    for lb = 1:length(labels)
                        image_labels(image_labels ==labels(lb) ) = label;
                    end
                end
            end
            image_labels(row,col) = label;
        end
    end
end

image_labels = image_labels(2:rows+1,2:cols+1);
imshow(image_labels,hsv)

imwrite(uint8(image_labels) , '../images/image_labels.png')
