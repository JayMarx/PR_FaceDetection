acc=[];
time=[];
testtime = [];
for p = [7 13 20]
    for i=1:10
        generatedata(p);
        % reading data
        [trainlabel, traindata]=libsvmread('./train.txt');
        [testlabel, testdata]=libsvmread('./test.txt');
        % training
        tic;
        model = libsvmtrain(trainlabel, traindata, '-t 0');
        t=toc;
        time=[time t];
        % predicting
        tic;
        [predict_label, accuracy, dec_values] = libsvmpredict(testlabel, testdata, model);
        tt = toc;
        testtime = [testtime, tt];
        acc=[acc accuracy(1,1)];
    end
end

averageacc=[];
averagetime=[];

a3=0;
t3=0;
for i=1:10
    a3=a3+acc(1,i);    
    t3=t3+time(1,i);
end
a3=a3/10;
t3=t3/10;
averageacc=[averageacc a3];
averagetime=[averagetime t3];

a4=0;
t4=0;
for i=11:20
    a4=a4+acc(1,i);
    t4=t4+time(1,i);
end
a4=a4/10;
t4=t4/10;
averageacc=[averageacc a4];
averagetime=[averagetime t4];

a5=0;
t5=0;
for i=21:30
    a5=a5+acc(1,i); 
    t5=t5+time(1,i);
end
a5=a5/10;
t5=t5/10;
averageacc=[averageacc a5];
averagetime=[averagetime t5];

x=[7 13 20];
figure
plot(x,averageacc,'r-')
title('平均识别精度与训练样本数的关系(%)');
grid on;
figure
plot(x,averagetime,'b-')
title('平均训练时间与训练样本数的关系(s)');
grid on;


