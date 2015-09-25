
% 
% [x,fs] = audioread('Drum+Bass.wav');
% [x,fs] = audioread('BrianEno_extract.wav');
% [x,fs] = audioread('KeikoMatsui_extract.wav');
fs = 16000; x = ones(2*fs,1);
x = x(1:2*fs,1);
index = 1:2*fs;


window_size = 256;
fft_size = 1024;
hop_size = window_size*0.25; % 25 percent
% hop_size = window_size*0.5; % 50 percent
% hop_size = window_size*0.75; % 75 percent
% hop_size = window_size*0.125; % 50 percent

[spect, f, t] = choh_stft(x, window_size, hop_size, fft_size, fs);
db_result = mag2db(abs(spect));
f_disp = size(spect, 1);
freq = fs/2/f_disp;
time = 512/fs;
figure, imagesc(db_result); ylim([0 100]);
set(gca,'YDir','normal')
xlabel( ['Time (s) x ' num2str(time)] )
ylabel(['Frequency (Hz) x ' num2str(freq)] )

% soundsc(x,fs)
recon = choh_istft(spect, window_size, hop_size );

% figure, 
% subplot(2,1,1),plot(index, x(1:fs,1));
% subplot(2,1,2),plot(index, recon(1:fs));
figure, 
subplot(2,1,1),plot(index, x(1:2*fs,1)); ylim([0 2]);
subplot(2,1,2),plot(index, recon(1:2*fs)); ylim([0 2]);

% soundsc(x(:,1),fs);
soundsc(recon,fs);

%%
