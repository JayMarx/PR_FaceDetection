function [TrainData, TestData, TrainLabel, TestLabel]=generatedata(p)
ftr = fopen('trainimg.txt','wt');
fte = fopen('testimg.txt','wt');

img_path = '../imageData/faceImage/yaleBExtData/';
img_file = {'yaleB01/'; 'yaleB02/'; 'yaleB03/'; 'yaleB04/'; 'yaleB05/';...
            'yaleB06/'; 'yaleB07/'; 'yaleB08/'; 'yaleB09/'; 'yaleB10/';...
            'yaleB11/'; 'yaleB12/'; 'yaleB13/'; 'yaleB15/'; 'yaleB16/';...
            'yaleB17/'; 'yaleB18/'; 'yaleB19/'; 'yaleB20/'; 'yaleB21/';...
            'yaleB22/'; 'yaleB23/'; 'yaleB24/'; 'yaleB25/'; 'yaleB26/';...
            'yaleB27/'; 'yaleB28/'; 'yaleB29/'; 'yaleB30/'; 'yaleB31/';...
            'yaleB32/'; 'yaleB33/'; 'yaleB34/'; 'yaleB35/'; 'yaleB36/';...
            'yaleB37/'; 'yaleB38/'; 'yaleB39/'};

for i=1:38
    AllPath = strcat(img_path, img_file{i}, '*.pgm');
    ImgName = dir(AllPath);         
    ImgNum = length(ImgName);       
    [tr,te]=randnorepeat(p,ImgNum);     
    for j=1:size(tr,2)    
        m=tr(1,j);
        temp = strcat(img_path, img_file{i}, ImgName(m).name);
        fprintf(ftr, '%s\n', temp);
    end
    for k=1:size(te,2)
        n=te(1,k);
        temp2 = strcat(img_path, img_file{i}, ImgName(n).name);
        fprintf(fte, '%s\n', temp2);
    end
end

TrainData=[];
TrainLabel=[];
for la=1:38
  for ite=1:p
    TrainLabel=[TrainLabel la];
  end
end
TrainLabel=TrainLabel';

fid1 = fopen('trainimg.txt');
tline = fgetl(fid1);
while ischar(tline)
%   disp(tline)
    
    I=imread(tline);
    I = blockproc(I,[4 4],@(x)max(max(x.data,[],1),[],2));  %DownSample by MaxPooling
    I=double(I)/256;    %normalization
    I=reshape(I,[],1);
    I=I/sqrt(sum(I.^2));
    TrainData=[TrainData I];
    tline = fgetl(fid1);
end

% TrainData=sparse(TrainData);
% libsvmwrite('train.txt',TrainLabel,TrainData);

TestData=[];
TestLabel=[];
for lab=1:38
  AllPath = strcat(img_path, img_file{lab}, '*.pgm');
  ImgName = dir(AllPath);         
  ImgNum = length(ImgName);       
  for ite=1:(ImgNum - p)
    TestLabel=[TestLabel lab];
  end
end
TestLabel=TestLabel';
fid2 = fopen('testimg.txt');
tline = fgetl(fid2);
while ischar(tline)
%     disp(tline)
    
    H=imread(tline);
    H = blockproc(H,[4 4],@(x)max(max(x.data,[],1),[],2));  %DownSample by MaxPooling
    H=double(H)/256;
    H=reshape(H,[],1);
    H=H/sqrt(sum(H.^2));
    TestData=[TestData H];
    tline = fgetl(fid2);
end
% TestData=sparse(TestData);
% libsvmwrite('test.txt',TestLabel,TestData);


fclose(ftr);
fclose(fte);