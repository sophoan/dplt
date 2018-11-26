function result = esi_histeq(img);

[p,val] = imhist(img);

sz = size(img);

sum_hk = sum(p .* val);
sum_h = sum(p);
exposure = sum_hk / (sum_h * 256);
m = round(256 * (1 - exposure));
t_c = sum_h / 256;


%h: frequency in histogram 
h = zeros(256,1);
%c: cumulative density function
c = zeros(256, 1);
%i_new: values to change
i_new = zeros(256, 1);

n =0;
for i = 0:m
    t = sum(sum(img == i));
    if t >= t_c
        t = t_c;
    end
    n = n + t;
end
p_c = 0;
for i = 0:m
    h(i + 1) = sum(sum(img == i)); 
    if h(i + 1) >= t_c
        h(i + 1) = t_c;
    end
    p_i = h(i + 1) / n;
    p_c = p_c + p_i;
    c(i + 1) = p_c;
    i_new(i + 1) = uint8(c(i + 1) * m);
end 

n =0;
for i = m+1:255
    t = sum(sum(img == i));
    if t >= t_c
        t = t_c;
    end
    n = n + t;
end
p_c = 0;
for i = m+1:255
    h(i + 1) = sum(sum(img == i));
    if h(i + 1) >= t_c
        h(i + 1) = t_c;
    end
    p_i = h(i + 1) / n;
    p_c = p_c + p_i;
    c(i + 1) = p_c;
    i_new(i + 1) = uint8(c(i + 1) * (256 - m + 1) + m + 1);
end 

result = zeros(sz); 
for i = 1:sz(1)
    for j = 1:sz(2)
        result(i,j) = i_new(img(i,j)+1);
    end
end