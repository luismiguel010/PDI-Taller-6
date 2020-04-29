clear all
close all
clc

image = [
    0     1     0     1     1     0     0     1
    1     0     0     1     1     0     1     1
    1     1     0     1     1     0     1     1
    1     1     0     1     1     0     1     1
    1     1     0     1     1     0     1     1
    0     1     1     0     1     1     0     0
    0     0     1     1     1     1     0     0
    1     0     1     1     1     1     1     1
    ];

%------------------- User Config -------------------------
background_color = 1;
%---------------------------------------------------------



% ---------------- For fill image borders ----------------
[rows, cols] = size(image);

row_fill = ones(rows,1)'*background_color;
col_fill = ones(cols + 2,1)*background_color;

image = [row_fill;image;row_fill];
image = [col_fill image col_fill];
%--------------------------------------------------------


image_labels = ones(rows+2,cols+2)*background_color;

label = 1;
for row=2:rows
    for col=2:cols
        
        % If actual value is not backround value
        if(image(row,col)~=background_color)
            
            % search if any neighbor has a assigned label
            search_matrix = image_labels(row - 1 : row + 1, col-1:col+1);
            search_matrix_idx = search_matrix~=background_color;
            
            % create a vector with the labels of your neighbors
            flat_matrix = search_matrix(search_matrix_idx);
            flat_matrix = flat_matrix(:);
            
            
            % If the element has neighbors, with an assigned label,
            % it takes that value, otherwise it creates a new one.
            if(sum(search_matrix_idx(:))==0)
                %label = label + 1;
                label = rand();
            else
                for i =1:9
                    if(flat_matrix(i)~=0)
                        label = flat_matrix(i);
                        break;
                    end
                end
            end
            
            % Finds all non-background elements in the current group
            image_piece = image(row - 1 : row + 1, col-1:col+1);
            
            % Create a new group with de backround color, and the label
            % that was calculated before
            replace_matrix = ones(3,3)*background_color;
            replace_matrix(image_piece~=background_color) = label;
            
            % Replace the new group in the labels image
            image_labels(row - 1 : row + 1, col-1:col+1) = replace_matrix;
            
        end
    end
end

imshow(image_labels)
