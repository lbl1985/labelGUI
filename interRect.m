function [rect tAll] = interRect(key, t)
% Interpolate rect according to key rect and time info t
% Input:
% key:      n x 4 matrix with [ x y w h] information
% t:        n x 1 matrix with time information for each key before. (monocreate
% data);
% Output:
% rect:     Intepolated rect
% tAll:     Consecutive 
% Binlong Li        14 May 2012 

if length(t) > 1
    rect = zeros(t(end) - t(1) + 1, 4);
    tAll = t(1) : t(end);

    dis = circshift(t, -1) - t;
    dis = dis(1:end-1);
    place = [1; dis];
    place = cumsum(place);

    for i = 1 : 4
        tmp = zeros(size(rect, 1), 1);    
        for j = 1 : length(place)-1            
            gap = (key(j + 1, i) - key(j, i)) / dis(j);
            if gap ~= 0
                tmp(place(j) : place(j+1)) = key(j, i) : gap : key(j+1, i);
            else
                tmp(place(j) : place(j+1)) = key(j, i);
            end
        end    
        rect(:, i) = round(tmp);
    end
elseif length(t) == 1
    rect = key;
    tAll = t;
end
    
