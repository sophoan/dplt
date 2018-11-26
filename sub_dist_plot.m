function result = sub_dist_plot(img, use_peak);
if (~exist('use_peak', 'var'))
    use_peak = 0;
end
    
[p,val] = imhist(img);
y_v = 2;
y_p = 1;
x_p = 0;
x = 0;
x_n = 0;
result = [];
peak = [];
result(1) = 0;
for i = 2:length(p)-1
    x = p(i);
    x_n = p(i+1);
    if x < x_p & x < x_n
        result(y_v) = i;
        y_v = y_v + 1;
    end
    if x > x_p & x > x_n
        peak(y_p) = i;
        y_p = y_p + 1;
    end
    x_p = p(i);
end
result(y_v) = length(p) - 1;

i_w = 1;
w = [];
for i = 2:length(result)
    w(i_w) = result(i) - result(i-1);
    i_w = i_w + 1;
end
w_max = mean(w);

figure,plot(p)

sigma = w_max;
f = normpdf(-9:9,0,sigma); % <== f(x) gaussian distribution
p1 = conv(p,f); % <== p'(x) new histogram after applying gaussian filtering

y_v = 2;
y_p = 2;
x_p = 0;
x = 0;
x_n = 0;
result = [];
peak = [];
result(1) = 0;
peak(1) = 0;
for i = 10:length(p1)-1
    x = p1(i);
    x_n = p1(i+1);
    if x < x_p & x < x_n & i <= 255      
        result(y_v) = i-9-1;
        y_v = y_v + 1;
    end
    if x > x_p & x > x_n & i <= 255 + 9
        peak(y_p) = i-9-1;
        y_p = y_p + 1;
    end
    x_p = p1(i);
end
result(y_v) = length(p) - 1;
peak(y_p) = length(p) - 1;
if use_peak == 1
    result = peak;
end

%figure, histogram(p1);
hold on, plot(val(1)-9:val(end)+9,p1,'.')