fp = fopen('imgpath.txt','wt');
for i=1:40
for j =1 : 10
    fprintf(fp, '%s%d%s%d%s\n','C:\Users\serendipity\Desktop\研一\模式识别\orlData\', i,'\',j,'.pgm');
end
end
fclose(fp);