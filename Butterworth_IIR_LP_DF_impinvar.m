% Author: Zeyu
% 2019-06-21 11:49:36 @ SUT
%%
fpb = 2100; % stopband_boundary_frequency
fsb = 8000; % passband_boundary_frequency
sampling_rate = 20000;
Rp = 0.5; Rs = 30; % passband attenuation & stopband_attenuation
T = 1/sampling_rate;% sample time
W1p = fpb/sampling_rate*2;
W1s = fsb/sampling_rate*2; % normalization
[N,Wn] = buttord(W1p,W1s,Rp,Rs,'s'); % ensure the min DF order
[z,p,k] = buttap(N); % analog filter prototype
[bp,ap] = zp2tf(z,p,k);
[bs,as] = lp2lp(bp,ap,Wn*pi*sampling_rate);
[bz,az] = impinvar(bs,as,sampling_rate);
sys = tf(bz,az,T);% Transformation_Function
[H,W] = freqz(bz,az,512,sampling_rate); % frequency response argument
figure('NumberTitle', 'off', 'Name', 'DSP_Zeyu');
subplot(3,1,1);
plot(W,abs(H));
grid on;
xlabel('Frequency/Hz');
ylabel('Amplitude/Gain');
title('Butterworth IIR LP DF Impinvar')
subplot(3,1,2);
plot(W,angle(H));
grid on;
xlabel('Frequency/Hz');
ylabel('Phase/Radian');
t = 0:1/sampling_rate:25/sampling_rate;
y = impulse(sys,t);
subplot(3,1,3);
plot(t,y);
grid on;
xlabel('Time/s');
ylabel('Amplitude');
