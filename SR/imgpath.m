fp = fopen('imgpath.txt','wt');
for i=1:40
for j =1 : 10
    fprintf(fp, '%s%d%s%d%s\n','C:\Users\serendipity\Desktop\��һ\ģʽʶ��\orlData\', i,'\',j,'.pgm');
end
end
fclose(fp);