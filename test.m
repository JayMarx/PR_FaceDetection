img = imread('./a.pgm');
img = blockproc(img,[4 4],@(x)max(max(x.data,[],1),[],2));
img = double(img)/256;
imwrite(img, './norm.png');
%imshow(img);