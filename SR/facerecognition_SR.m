Accuracy=[];    
traintime = [];
testtime = [];
average_train_time = [];
for p = [7 13 20]
    for iii=1:10
        [TrainData, TestData, TrainLabel, TestLabel] = generatedata(p);
        [N,M] = size(TrainData);
        PreLabel=[];
        
        temp_train_time = 0;
        temp_test_time = 0;
        
        for i=1:length(TestLabel)
            tic;
            y = TestData(:,i);
            [x,k] = SolveOMP(TrainData,y);
            %[x,k, kk] = SolveOMP_CBM(TrainData,y);
            train_time = toc;
            traintime = [traintime, train_time];
            temp_train_time = temp_train_time + train_time;
            err=[];
            tic;
            for j=1:38
                il=(j-1)*p+1;
                ir=j*p;
                xi=x(il:ir,1);
                err = [err errorcal(y - TrainData(:,il:ir)*xi)];
            end
            [r c]=find(err==min(min(err)));
            PreLabel=[PreLabel c];
            test_time = toc;
            temp_test_time = temp_test_time + test_time;
        end
        
        temp_train_time  = temp_train_time/length(TestLabel);
        average_train_time = [average_train_time, temp_train_time];
        
        temp_test_time  = temp_test_time/length(TestLabel);
        testtime = [testtime, temp_test_time];
            
        PreLabel=PreLabel';
        NumRight=sum(PreLabel==TestLabel);
        accuracy=NumRight/size(TestLabel,1);
        Accuracy=[Accuracy accuracy*100];
        sprintf('%s %0.2f %s %s %d %s %d %s\n','Accuracy:',accuracy*100,'%','(',NumRight,'/',size(TestLabel,1),')')
    end
end

averageacc=[];
averagetime=[];  

a3=0;
t3=0;
for i=1:10
    a3=a3+Accuracy(1,i);    
    t3=t3+average_train_time(1,i);
end
a3=a3/10;
t3=t3/10;
averageacc=[averageacc a3];
averagetime=[averagetime t3];

a4=0;
t4=0;
for i=11:20
    a4=a4+Accuracy(1,i);
    t4=t4+average_train_time(1,i);
end
a4=a4/10;
t4=t4/10;
averageacc=[averageacc a4];
averagetime=[averagetime t4];

a5=0;
t5=0;
for i=21:30
    a5=a5+Accuracy(1,i); 
    t5=t5+average_train_time(1,i);
end
a5=a5/10;
t5=t5/10;
averageacc=[averageacc a5];
averagetime=[averagetime t5];


 P=[7 13 20];
 figure
 plot(P,averageacc,'r-');
 title('平均识别精度与训练样本数的关系(%)');
 grid on;
 figure
 plot(P,averagetime,'b-');
 title('平均训练时间与训练样本数的关系(s)');
 grid on;



