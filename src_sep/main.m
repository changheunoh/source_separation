[x,fs] = audioread('Drum+Bass.wav');
% soundsc(x,fs); 
win = 256;
fft_size = 1024;
hop = 128;

[result, t, f]=STFT(x,fs, 'hann', win, hop, fft_size);
% imagesc(abs(result));

db_result = mag2db(abs(result));
f_disp = size(result, 1);
freq = fs/2/f_disp;
time = 512/fs;
figure, imagesc(db_result);
set(gca,'YDir','normal')
xlabel( ['Time (s) x ' num2str(time)] )
ylabel(['Frequency (Hz) x ' num2str(freq)] )



time_smooth_spect = mymedian_hor(result, 17);

db_result2 = mag2db(abs(time_smooth_spect));
f_disp = size(result, 1);
freq = fs/2/f_disp;
time = 512/fs;
figure, imagesc(db_result2);
set(gca,'YDir','normal')
xlabel( ['Time (s) x ' num2str(time)] )
ylabel(['Frequency (Hz) x ' num2str(freq)] )



freq_smooth_spect = mymedian_ver(result, 17);

db_result3 = mag2db(abs(freq_smooth_spect));
f_disp = size(result, 1);
freq = fs/2/f_disp;
time = 512/fs;
figure, imagesc(db_result3);
set(gca,'YDir','normal')
xlabel( ['Time (s) x ' num2str(time)] )
ylabel(['Frequency (Hz) x ' num2str(freq)] )






%% gen mask


MH = time_smooth_spect./(freq_smooth_spect + time_smooth_spect);
MP = freq_smooth_spect./(freq_smooth_spect + time_smooth_spect);

H_hat = result.*MH;
P_hat = result.*MP;

db_result4 = mag2db(abs(H_hat));
f_disp = size(result, 1);
freq = fs/2/f_disp;
time = 512/fs;
figure, imagesc(db_result4);
set(gca,'YDir','normal')
xlabel( ['Time (s) x ' num2str(time)] )
ylabel(['Frequency (Hz) x ' num2str(freq)] )

db_result5 = mag2db(abs(P_hat));
f_disp = size(result, 1);
freq = fs/2/f_disp;
time = 512/fs;
figure, imagesc(db_result5);
set(gca,'YDir','normal')
xlabel( ['Time (s) x ' num2str(time)] )
ylabel(['Frequency (Hz) x ' num2str(freq)] )

