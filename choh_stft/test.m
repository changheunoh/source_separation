
% 
% [x,fs] = audioread('Drum+Bass.wav');
% [x,fs] = audioread('BrianEno_extract.wav');
% [x,fs] = audioread('KeikoMatsui_extract.wav');
fs = 16000; x = ones(fs,1);
index = 1:fs;


window_size = 4048;
fft_size = 4048;
hop_size = window_size*0.25; % 25 percent
% hop_size = window_size*0.5; % 50 percent

[spect, f, t] = choh_stft(x, window_size, hop_size, fft_size, fs);
db_result = mag2db(abs(spect));
f_disp = size(spect, 1);
freq = fs/2/f_disp;
time = 512/fs;
figure, imagesc(db_result);
set(gca,'YDir','normal')
xlabel( ['Time (s) x ' num2str(time)] )
ylabel(['Frequency (Hz) x ' num2str(freq)] )

% soundsc(x,fs)
recon = choh_istft(spect, window_size, hop_size );

figure, 
subplot(2,1,1),plot(index, x(1:fs,1));
subplot(2,1,2),plot(index, recon(1:fs));

% soundsc(x(:,1),fs);
soundsc(recon,fs);