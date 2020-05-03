clear all;
clc;

ImageOriginal = imread('./../images/dados/3.jpg');
BW = im2bw(ImageOriginal,0.5);
[x,y] = size(BW);
ImageLabel = zeros(x,y);
label = 1;

for i = 1 : size(BW,1)
    [fila,columna]=find(BW(i,:)==1);
    if size(columna) > 0
        for j = 1 : length(columna)
            if i > 1
                if columna(1) == 1
                    if BW(i,columna(j)-1) == 1
                       ImageLabel(i,columna(j))=ImageLabel(i,columna(j)-1);
                       label = label + 1;
                    end
                else
                    if BW(i,columna(j)-1) == 1
                       ImageLabel(i,columna(j))=ImageLabel(i,columna(j)-1);
                       label = label + 1;
                    elseif BW(i-1,columna(j)) == 1
                       ImageLabel(i,columna(j))=ImageLabel(i-1,columna(j));
                       label = label + 1;
                    else
                       ImageLabel(i,columna(j))=label; 
                    end
                end
            else
                if columna(1) == 1
                    ImageLabel(i,columna(j))=label;
                    label = label + 1;
                else
                    if BW(i, columna(j)-1) == 1
                      ImageLabel(i,columna(j))=ImageLabel(i, columna(j)-1);
                       label = label + 1;  
                    end
                end
            end
        end
    end
end

NumberObject = unique(ImageLabel);
counter = 0;

for k = 1 : length(NumberObject)
    if NumberObject(k) ~= 0
        counter = counter + 1;
    end
end

X = sprintf('El número de objetos es: %d',counter);
disp(X);