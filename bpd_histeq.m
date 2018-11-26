function result = bpd_histeq(img, dist);
span = zeros(1, length(dist)-1);
factor = span;
for i = 2:length(dist)
    span(i-1) = dist(i) - dist(i-1);
    m = sum(sum((dist(i-1) == 0 | img > dist(i-1)) & img <= dist(i)));
    factor(i-1) = span(i-1) * log(m);
    if m == 0
        factor(i-1) = 255;
    end
end
range = zeros(1, length(factor));
for i = 1:length(factor)
    range(i) = (255 * factor(i)) / sum(factor);
end
start = zeros(1, length(range));
endd = start;
for i = 1:length(range)
    start(i) = round(sum(range(1:i-1)));
    endd(i) = round(sum(range(1:i)));
end


sz = size(img);
%h: frequency in histogram 
h = zeros(256,1);
%c: cumulative density function
c = zeros(256, 1);
%i_new: values to change
i_new = zeros(256, 1);

for x = 1:length(start)
    n = sum(sum(img >= start(x) & img <= endd(x)));
    p_c = 0;
    for i = start(x):endd(x)
        h(i + 1) = sum(sum(img == i)); 
        p_i = h(i + 1) / n;
        p_c = p_c + p_i;
        c(i + 1) = p_c;
        i_new(i + 1) = uint8(c(i + 1) * (endd(x) - start(x)) + start(x));
    end 
end
result = zeros(sz);

for i = 1:sz(1)
    for j = 1:sz(2)
        result(i,j) = i_new(img(i,j)+1);
    end
end

m_i = mean2(img);
m_o = mean2(result);

for i = 1:sz(1)
    for j = 1:sz(2)
        result(i,j) = result(i,j) * m_i / m_o;
    end
end