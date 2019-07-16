% This code is written by Foroozan Karimzadeh
% References:
% [1]L. Fraiwan etal.,"Classification of Sleep Stages Using
% Multi-wavelet Time Frequency Entropy and LDA", 2011.

clc
clear 
close all

%% loading data
sig01=load('SC4001E0-PSG.mat');
sig01=sig01.data(2,:);
hyp01=load('SC4001E0-PSG_hyp.mat');
hyp01=hyp01.hypnogram;
sig11=load('SC4011E0-PSG.mat');
sig11=sig11.data(2,:);
hyp11=load('SC4011E0-PSG_hyp.mat');
hyp11=hyp11.hypnogram;
sig12=load('SC4012E0-PSG.mat');
sig12=sig12.data(2,:);
hyp12=load('SC4012E0-PSG_hyp.mat');
hyp12=hyp12.hypnogram;
sig21=load('SC4021E0-PSG.mat');
sig21=sig21.data(2,:);
hyp21=load('SC4021E0-PSG_hyp.mat');
hyp21=hyp21.hypnogram;
sig22=load('SC4022E0-PSG.mat');
sig22=sig22.data(2,:);
hyp22=load('SC4022E0-PSG_hyp.mat');
hyp22=hyp22.hypnogram;
sig31=load('SC4031E0-PSG.mat');
sig31=sig31.data(2,:);
hyp31=load('SC4031E0-PSG_hyp.mat');
hyp31=hyp31.hypnogram;
sig32=load('SC4032E0-PSG.mat');
sig32=sig32.data(2,:);
hyp32=load('SC4032E0-PSG_hyp.mat');
hyp32=hyp32.hypnogram;
sig41=load('SC4041E0-PSG.mat');
sig41=sig41.data(2,:);
hyp41=load('SC4041E0-PSG_hyp.mat');
hyp41=hyp41.hypnogram;
sig42=load('SC4042E0-PSG.mat');
sig42=sig42.data(2,:);
hyp42=load('SC4042E0-PSG_hyp.mat');
hyp42=hyp42.hypnogram;
sig51=load('SC4051E0-PSG.mat');
sig51=sig51.data(2,:);
hyp51=load('SC4051E0-PSG_hyp.mat');
hyp51=hyp51.hypnogram;

%% Add white Gaussian noise to signal
%     Syntax
%     y = awgn(x,snr) 

sig01=awgn(sig01,20,'measured');
sig11=awgn(sig11,20,'measured');
sig12=awgn(sig12,20,'measured');
sig21=awgn(sig21,20,'measured');
sig22=awgn(sig22,20,'measured');
sig31=awgn(sig31,20,'measured');
sig32=awgn(sig32,20,'measured');
sig41=awgn(sig41,20,'measured');
sig42=awgn(sig42,20,'measured');
sig51=awgn(sig51,20,'measured');
%% Feature Extraction: CWT and Entropy 
signal={sig01,sig11,sig12,sig21,sig22,sig31,sig32,sig41,sig42,sig51}; % 
hyp_all={hyp01,hyp11,hyp12,hyp21,hyp22,hyp31,hyp32,hyp41,hyp42,hyp51}; %

k=1;
h=1;
for o=1:length(signal)

    fs=100; % Sampling frequency
    N=length(sig01);
    %% Part 1: Preprocessing:
    hyp=hyp_all{1,o};
    sig01=signal{1,o};
    % Designing bandpass filter with lower cut-off=0.1 & higher cut-off=50
    fl=0.01/fs;   % fl and fu are the lower and upper frequency ranges of the bandpass filter normalized by the sampling frequency
    fu=35/fs;
    sig = BPFilter(sig01,fl,fu);

    %% Calculating Continuous wavelet transform (CWT) for each epoch of 30 sec

    for i= 1:1633
        epoch=sig(1,hyp(i):hyp(i+1)-1);
        % Continuous wavelet transform (CWT)
        freq = (0.5:0.5:35);
        wname = 'db20';
        a = scal2frq(freq, wname, 1.0/fs);
        coefs =cwt(epoch, a, wname);

        coef_delta= coefs((find(freq==0.5):find(freq==4)),:);
        coef_theta= coefs((find(freq==4)+1:find(freq==8)),:);
        coef_alpha= coefs((find(freq==8)+1:find(freq==13)),:);
        coef_beta1= coefs((find(freq==13)+1:find(freq==22)),:);
        coef_beta2= coefs((find(freq==22)+1:find(freq==35)),:);
        coef_ss= coefs((find(freq==12):find(freq==14)),:);
        coef_kc= coefs((find(freq==0.5):find(freq==1.5)),:);

        [c_delta,x] = imhist(coef_delta);
        [c_theta,x] = imhist(coef_theta);
        [c_alpha,x] = imhist(coef_alpha);
        [c_beta1,x] = imhist(coef_beta1);
        [c_beta2,x] = imhist(coef_beta2);
        [c_ss,x] = imhist(coef_ss);
        [c_kc,x] = imhist(coef_kc);

     % Calculating Renyi’s entropy 
        En_delta=-sum((c_delta+1).*log(c_delta+1));
        En_theta=-sum((c_theta+1).*log(c_theta+1));
        En_alpha=-sum((c_alpha+1).*log(c_alpha+1));
        En_beta1=-sum((c_beta1+1).*log(c_beta1+1));
        En_beta2=-sum((c_beta2+1).*log(c_beta2+1));
        En_ss=-sum((c_ss+1).*log(c_ss+1));
        En_kc=-sum((c_kc+1).*log(c_kc+1));

        features1(k,:)=[En_delta,En_theta,En_alpha,En_beta1,En_beta2,En_ss,En_kc];
        k=k+1
    end
    k=k-1633;
    for i= 1:1633
        epoch=sig(1,hyp(i):hyp(i+1)-1);
        % Continuous wavelet transform (CWT)
        freq = (0.5:0.5:35);
        wname = 'gaus1';
        a = scal2frq(freq, wname, 1.0/fs);
        coefs =cwt(epoch, a, wname);

        coef_delta= coefs((find(freq==0.5):find(freq==4)),:);
        coef_theta= coefs((find(freq==4)+1:find(freq==8)),:);
        coef_alpha= coefs((find(freq==8)+1:find(freq==13)),:);
        coef_beta1= coefs((find(freq==13)+1:find(freq==22)),:);
        coef_beta2= coefs((find(freq==22)+1:find(freq==35)),:);
        coef_ss= coefs((find(freq==12):find(freq==14)),:);
        coef_kc= coefs((find(freq==0.5):find(freq==1.5)),:);

        [c_delta,x] = imhist(coef_delta);
        [c_theta,x] = imhist(coef_theta);
        [c_alpha,x] = imhist(coef_alpha);
        [c_beta1,x] = imhist(coef_beta1);
        [c_beta2,x] = imhist(coef_beta2);
        [c_ss,x] = imhist(coef_ss);
        [c_kc,x] = imhist(coef_kc);

     % Calculating Renyi’s entropy 
        En_delta=-sum((c_delta+1).*log(c_delta+1));
        En_theta=-sum((c_theta+1).*log(c_theta+1));
        En_alpha=-sum((c_alpha+1).*log(c_alpha+1));
        En_beta1=-sum((c_beta1+1).*log(c_beta1+1));
        En_beta2=-sum((c_beta2+1).*log(c_beta2+1));
        En_ss=-sum((c_ss+1).*log(c_ss+1));
        En_kc=-sum((c_kc+1).*log(c_kc+1));

        features2(k,:)=[En_delta,En_theta,En_alpha,En_beta1,En_beta2,En_ss,En_kc];
        k=k+1
    end
    
    k=k-1633;
    for i= 1:1633
        epoch=sig(1,hyp(i):hyp(i+1)-1);
        % Continuous wavelet transform (CWT)
        freq = (0.5:0.5:35);
        wname = 'rbio3.3';
        a = scal2frq(freq, wname, 1.0/fs);
        coefs =cwt(epoch, a, wname);

        coef_delta= coefs((find(freq==0.5):find(freq==4)),:);
        coef_theta= coefs((find(freq==4)+1:find(freq==8)),:);
        coef_alpha= coefs((find(freq==8)+1:find(freq==13)),:);
        coef_beta1= coefs((find(freq==13)+1:find(freq==22)),:);
        coef_beta2= coefs((find(freq==22)+1:find(freq==35)),:);
        coef_ss= coefs((find(freq==12):find(freq==14)),:);
        coef_kc= coefs((find(freq==0.5):find(freq==1.5)),:);

        [c_delta,x] = imhist(coef_delta);
        [c_theta,x] = imhist(coef_theta);
        [c_alpha,x] = imhist(coef_alpha);
        [c_beta1,x] = imhist(coef_beta1);
        [c_beta2,x] = imhist(coef_beta2);
        [c_ss,x] = imhist(coef_ss);
        [c_kc,x] = imhist(coef_kc);

     % Calculating Renyi’s entropy 
        En_delta=-sum((c_delta+1).*log(c_delta+1));
        En_theta=-sum((c_theta+1).*log(c_theta+1));
        En_alpha=-sum((c_alpha+1).*log(c_alpha+1));
        En_beta1=-sum((c_beta1+1).*log(c_beta1+1));
        En_beta2=-sum((c_beta2+1).*log(c_beta2+1));
        En_ss=-sum((c_ss+1).*log(c_ss+1));
        En_kc=-sum((c_kc+1).*log(c_kc+1));

        features3(k,:)=[En_delta,En_theta,En_alpha,En_beta1,En_beta2,En_ss,En_kc];
        k=k+1
    end
    
end


    feature=[features1, features2, features3];
    
    
    
    