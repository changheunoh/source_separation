window_size = 128;
fft_size = 128;
hop_size = window_size*0.5; % 50 percent

x = ones(window_size*1.5,1);
index = (1:window_size*1.5)';
fs = 512;

figure, plot(index, x);

[spect, f, t] = choh_stft(x, window_size, hop_size, fft_size, fs);
recon = choh_istft(spect, window_size, hop_size );

% figure, 
% subplot(2,1,1),plot(index, x);
% subplot(2,1,2),plot(index, recon(1:window_size*5));
figure, plot(1:256, recon);

%%

win = hann(window_size, 'periodic');
x1 = x(1:128).*win;

X1 = fft(x1, 128);
r1 = ifft(X1, 128);

% figure, subplot(2,1,1), plot(1:128, x1);
% subplot(2,1,2), plot(1:128, r1);
