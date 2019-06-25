% Author: Zeyu
% 2019-06-25 20:09:46 @ SUT
%%
fpb = 0.2*pi; % passband_boundary_frequency
fsb = 0.4*pi; % stopband_boundary_frequency
wn = (fpb + fsb)/(2*pi); % normalized cutoff freq
Bt = fsb - fpb;
N = ceil(6.2*pi/Bt);%Hanning window,DF ordder
%N = N0 + mod(N0+1,2);
bz = fir1(N,wn,'low',hanning(N+1));
[H,W] = freqz(bz,1,512);

figure('NumberTitle', 'off', 'Name', 'DSP_Zeyu');
subplot(3,1,1);
plot(W,abs(H));
grid on;
xlabel('Frequency/\omega');
ylabel('Amplitude/Gain');
title('Hanning FIR LP DF Winfun');

subplot(3,1,2);
plot(W,20*log10(abs(H)));
grid on;
xlabel('Frequency/\omega');
ylabel('Amplitude/dB');

subplot(3,1,3);
uir = ifft(H,'symmetric');
T = [0:24];
plot(T,uir(1:25));
grid on;
xlabel('Point');
ylabel('Amplitude');