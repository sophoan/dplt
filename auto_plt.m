function result = auto_plt(img, dist);

[p,val] = imhist(img);
y = [];
y(1) = 0;
for i = 2:length(dist)
    s = 0;
    for j = 1:dist(i)
       s = s + p(j+1);
    end
    y(i) = s / sum(p) * 255;
end
%disp(y);
sz = size(img);
result = zeros(sz);
for i = 1:sz(1)
    for j = 1:sz(2)
        for k = 2:length(dist)
            if img(i, j) >= dist(k-1) & img(i, j) <= dist(k)
               result(i, j) = ((y(k) - y(k-1)) / (dist(k) - dist(k-1))) * (img(i, j) - dist(k-1)) + y(k-1);
               continue;
            end
        end
    end
end