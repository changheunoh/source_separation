
% 
% [x,fs] = audioread('Drum+Bass.wav');
[x,fs] = audioread('BrianEno_extract.wav');
% [x,fs] = audioread('KeikoMatsui_extract.wav');



window_size = 256;
fft_size = 1024;
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

% soundsc(x(:,1),fs);
soundsc(recon,fs);