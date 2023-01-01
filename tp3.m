clear all 
close all
clc 

%exporter le fichier au matlab
load('ecg.mat');

%garder dans un variable
A=ecg;

%caluculer la taille
N=length(A);

%nbr de 
fs=500;
Te=1/fs;
t =[0:Te:(N-1)*Te];

% taracage du fct
title(" sig ECG");
% plot(t,A,'r');

%zommer sur sing 
% xlim([0.5 1.5])

%le spectre Amplitude
 y = fft(A);
 f = (0:N-1)*(fs/N);
 fshift = (-N/2:N/2-1)*(fs/N);

% subplot(2,2,2)
plot(fshift,fftshift(abs(y)))
title("spectre Amplitude")

%spectre Amplitude centré


%suppression du bruit des movements de corps

h = ones(size(A));
fh = 0.5;
index_h = ceil(fh*N/fs);
h(1:index_h)=0;
h(N-index_h+1:N)=0;

ecg1_freq = h.*y;
ecg1 =ifft(ecg1_freq,"symmetric");
% subplot(211)
% plot(t,ecg);
title("signal filtré")
% subplot(2,1,2)
% plot(t,ecg1);
% plot(t,A-ecg1);
title("La différence")

% Elimination interference 50Hz
 
Notch = ones(size(A));
fcn = 50;
index_hcn = ceil(fcn*N/fs)+1;
Notch(index_hcn)=0;
Notch(index_hcn+2)=0;

ecg2_freq = Notch.*fft(ecg1);
ecg2 =ifft(ecg2_freq,"symmetric");
% subplot(211)
% plot(t,ecg);
xlim([0.5 1.5])
title("signal filtré")
% subplot(212)
% plot(t,ecg2);
% xlim([0.5 1.5])

%
pass_bas = zeros(size(A));
fcb = 30;
index_hcb = ceil(fcb*N/fs);
pass_bas(1:index_hcb)=1;
pass_bas(N-index_hcb+1:N)=1;

ecg3_freq = pass_bas.*fft(ecg2);
ecg3 =ifft(ecg3_freq,"symmetric");
% subplot(211)
% plot(t,ecg,"linewidth",1.5);
% xlim([0.5 1.5])
% subplot(212)
% plot(t,ecg3);
% xlim([0.5 1.5])

[c,lags] = xcorr(ecg2,ecg2);
stem(lags/fs,c)




