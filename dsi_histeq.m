function result = dsi_histeq(img);

sz = size(img);
%h: frequency in histogram 
h = zeros(256,1);
%c: cumulative density function
c = zeros(256, 1);
%i_new: values to change
i_new = zeros(256, 1);

m = round(median(img(:)));
%disp(m);

n = sum(sum(img <= m));
p_c = 0;
for i = 0:m
    h(i + 1) = sum(sum(img == i)); 
    p_i = h(i + 1) / n;
    p_c = p_c + p_i;
    c(i + 1) = p_c;
    i_new(i + 1) = uint8(c(i + 1) * m);
end 

n = sum(sum(img > m));
p_c = 0;
for i = m+1:255
    h(i + 1) = sum(sum(img == i)); 
    p_i = h(i + 1) / n;
    p_c = p_c + p_i;
    c(i + 1) = p_c;
    i_new(i + 1) = uint8(c(i + 1) * (256 - m) + m);
end 

result = zeros(sz); 
for i = 1:sz(1)
    for j = 1:sz(2)
        result(i,j) = i_new(img(i,j)+1);
    end
end