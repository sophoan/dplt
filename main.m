clc;
addpath(genpath('./'));
img = imread('dataset/images/2.bmp');
hsv = rgb2hsv(img);
v = hsv(:,:,3);
gray_v = uint8(v * 255);
figure(1);
subplot(3,3,1),imshow(img), title('Original Image');
lo = zeros(9,1);

% histeq
v_he = histeq(v);
hsv_he = hsv;
hsv_he(:,:,3) = v_he;
img_edited_he = hsv2rgb(hsv_he);
subplot(3,3,2), imshow(img_edited_he), title('HE');
lo(2) = loe(img, img_edited_he);

% bi-histeq
v_bi = bi_histeq(gray_v);
hsv_bi = hsv;
hsv_bi(:,:,3) = v_bi / 255;
img_edited_bi = hsv2rgb(hsv_bi);
subplot(3,3,3), imshow(img_edited_bi), title('BBHE');
lo(3) = loe(img, img_edited_bi);

% dsi-histeq
v_dsi = dsi_histeq(gray_v);
hsv_dsi = hsv;
hsv_dsi(:,:,3) = v_dsi / 255;
img_edited_dsi = hsv2rgb(hsv_dsi);
subplot(3,3,4), imshow(img_edited_dsi), title('DSIHE');
lo(4) = loe(img, img_edited_dsi);

% esi-histeq
v_esi = esi_histeq(gray_v);
hsv_esi = hsv;
hsv_esi(:,:,3) = v_esi / 255;
img_edited_esi = hsv2rgb(hsv_esi);
subplot(3,3,5), imshow(img_edited_esi), title('ESIHE');
lo(5) = loe(img, img_edited_esi);

% bpd-histeq
dist = sub_dist(gray_v, 1);
v_bpd = bpd_histeq(gray_v, dist);
hsv_bpd = hsv;
hsv_bpd(:,:,3) = v_bpd / 255;
img_edited_bpd = hsv2rgb(hsv_bpd);
subplot(3,3,6), imshow(img_edited_bpd), title('BPDHE');
lo(6) = loe(img, img_edited_bpd);

% amsr
img_edited_amsr = amsr(img);
subplot(3,3,7), imshow(img_edited_amsr), title('AMSR');
lo(7) = loe(img, img_edited_amsr);

% atuo-piecewise
dist = sub_dist(gray_v);
v_auto_plt = auto_plt(gray_v, dist);
hsv_auto_plt = hsv;
hsv_auto_plt(:,:,3) = v_auto_plt / 255;
img_edited_auto_plt = hsv2rgb(hsv_auto_plt);
subplot(3,3,8), imshow(img_edited_auto_plt), title('PLT');
lo(8) = loe(img, img_edited_auto_plt);

% proposed
mean_img = mean2(gray_v) / 255;
disp("OK");
disp(mean_img);
gray_v_modified = gray_v;
% inverse
if mean_img > 0.5
    gray_v_modified = 255 - gray_v;
end
dist = sub_dist(gray_v_modified, 1);
v_proposed = proposed_method_revised(gray_v_modified, dist, 1);
% inverse back
if mean_img > 0.5
    v_proposed = 255 - v_proposed;
end
hsv_proposed = hsv;
hsv_proposed(:,:,3) = v_proposed / 255;
%hsv_proposed(:,:,3) = 1 - hsv_proposed(:,:,3);
img_edited_proposed = hsv2rgb(hsv_proposed);
subplot(3,3,9), imshow(img_edited_proposed), title('Proposed Method');
lo(9) = loe(img, img_edited_proposed);

disp(lo);

