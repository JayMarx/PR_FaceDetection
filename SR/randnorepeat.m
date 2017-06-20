function [tr,te]=randnorepeat(m,n)
p=randperm(n);
tr=p(1:m);
te=p(m+1:n);
