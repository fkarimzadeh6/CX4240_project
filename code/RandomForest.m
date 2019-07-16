% This code is written by Foroozan Karimzadeh
% Random forest classifier
clear;close all;clc;

%% Data: Hypnogram of each data
 hyp01=load('SC4001E0-PSG_hyp'); 
 hyp11=load('SC4011E0-PSG_hyp'); 
 hyp12=load('SC4012E0-PSG_hyp'); 
 hyp21=load('SC4021E0-PSG_hyp');
 hyp22=load('SC4022E0-PSG_hyp');
 hyp31=load('SC4031E0-PSG_hyp');
 hyp32=load('SC4032E0-PSG_hyp');
 hyp41=load('SC4041E0-PSG_hyp');
 hyp42=load('SC4042E0-PSG_hyp');
 hyp51=load('SC4051E0-PSG_hyp');
%  
hyp01=hyp01.hypnogram(700:1633,2);
hyp11=hyp11.hypnogram(700:1633,2);
hyp12=hyp12.hypnogram(700:1633,2);
hyp21=hyp21.hypnogram(700:1633,2);
hyp22=hyp22.hypnogram(700:1633,2);
hyp31=hyp31.hypnogram(700:1633,2);
hyp32=hyp32.hypnogram(700:1633,2);
hyp41=hyp41.hypnogram(700:1633,2);
hyp42=hyp42.hypnogram(700:1633,2);
hyp51=hyp51.hypnogram(700:1633,2);

label=[hyp01;hyp11;hyp12;hyp21;hyp22;hyp31;hyp32;hyp41;hyp42;hyp51]; %

% Labeling based on AASM creteria:
for i=1:length(label)
    if label(i,1)==4
        label(i,1)=3;
    elseif label(i,1)==6
       label(i,1)=0; 
    end
end

feat1=load('features(10)_cwt');
data1=feat1.features;
% feat2=load('feat(11-20)_cwt');
% data2=feat2.features;
data = [];
for i = 1:10
    data2=data1(700+(i-1)*1633:1633+(i-1)*1633,:);
    data =[data; data2];
end

errorTrain=0;
errorTest=0;
resultTrain=[];
resultTest=[];
%-----------------------test via kfold-----------------
for j=1:10
    j
  indices = crossvalind('Kfold',label,10);
  errorTrain=0;
  errorTest=0;
  for i = 1:10
	test = (indices == i);
	train = ~test;
	%----------------------------------------
	b = TreeBagger(50,data(train,:),label(train,:),'minleaf', 50);
	%----------------------------------------
% 	predictedTrain=b.predict(data(train,:));
% 	predictedTrain=str2num(cell2mat(predictedTrain));
% 	cm = confusionmat(predictedTrain,label(train,:));         
% 	N = sum(cm(:));
% 	err = ( N-sum(diag(cm)) ) / N; 
% 	errorTrain=(100-(err*100))+errorTrain;
	%----------------------------------------
	predictedTest=b.predict(data(test,:));
	predictedTest=str2num(cell2mat(predictedTest));
	cm = confusionmat(predictedTest,label(test,:));           
	N = sum(cm(:));
	err = ( N-sum(diag(cm)) ) / N; 
	errorTest=(100-(err*100))+errorTest;
	%----------------------------------------
    
     for k=1:length(cm)
            
            TP=cm(k,k);
            TN=sum (diag(cm))-TP;
            FP=sum (cm(:,k))-TP;
            FN=sum (cm(k,:)')-TP;
            
            ac(i,k)=(TP+TN)/(TP+TN+FP+FN);
            sp(i,k)=TN/(TN+FP);
            se(i,k)=TP/(TP+FN);
        end
  end
%   resultTrain(j,1)=(errorTrain/10);
  resultTest(j,1)=(errorTest/10); 
  ss=mean(se);
end
% disp('----------------------Train Result---------------------------');
% fprintf('performane of train : %f\n',mean(resultTrain));
% fprintf('std of train : %f\n',std(resultTrain));
disp('----------------------Test Result-----------------------');
fprintf('performane of test: %f\n',mean(resultTest));
fprintf('std of test  : %f\n',std(resultTest));
% errorTrain=0;
% errorTest=0;
% resultTrain=[];
% resultTest=[];
% %-----------------------test via kfold-----------------
% for j=1:10
%     j
%   indices = crossvalind('Kfold',label,10);
%   errorTrain=0;
%   errorTest=0;
%   for i = 1:10
% 	test = (indices == i);
% 	train = ~test;
% 	%----------------------------------------
% 	b = TreeBagger(50,data(train,:),label(train,:),'minleaf', 10);
% 	%----------------------------------------
% 	predictedTrain=b.predict(data(train,:));
% 	predictedTrain=str2num(cell2mat(predictedTrain));
% 	cm = confusionmat(predictedTrain,label(train,:));         
% 	N = sum(cm(:));
% 	err = ( N-sum(diag(cm)) ) / N; 
% 	errorTrain=(100-(err*100))+errorTrain;
% 	%----------------------------------------
% 	predictedTest=b.predict(data(test,:));
% 	predictedTest=str2num(cell2mat(predictedTest));
% 	cm = confusionmat(predictedTest,label(test,:));           
% 	N = sum(cm(:));
% 	err = ( N-sum(diag(cm)) ) / N; 
% 	errorTest=(100-(err*100))+errorTest;
% 	%----------------------------------------
%   end
%   resultTrain(j,1)=(errorTrain/10);
%   resultTest(j,1)=(errorTest/10); 
% end
% disp('----------------------Train Result---------------------------');
% fprintf('performane of train : %f\n',mean(resultTrain));
% fprintf('std of train : %f\n',std(resultTrain));
% disp('----------------------Test Result-----------------------');
% fprintf('performane of test: %f\n',mean(resultTest));
% fprintf('std of test  : %f\n',std(resultTest));
