function r=errorcal(x)
[m,n]=size(x);
sum = 0;
for l=1:m
    sum=sum+x(l,1);
end
r=sqrt(sum);