%% read file

% [x,fs] = audioread('Drum+Bass.wav');
[x,fs] = audioread('BrianEno_extract.wav');
% [x,fs] = audioread('KeikoMatsui_extract.wav');

% soundsc(x,fs); 
window_size = 4048;
fft_size = 4048;
hop_size = window_size*0.25;

[spect, f, t] = choh_stft(x, window_size, hop_size, fft_size, fs);

%% decompose mag and phase
abs_spect = abs(spect);
angle_spect = angle(spect);
phase_spect = exp(1j*angle_spect);
recon_spect = abs_spect.*phase_spect;

%% display original
disp_ylim = 100;

db_result = mag2db(abs_spect);
f_disp = size(spect, 1);
freq = fs/2/f_disp;
time = 512/fs;
figure, imagesc(db_result);
set(gca,'YDir','normal');ylim([0 disp_ylim]);
xlabel( ['Time (s) x ' num2str(time)] )
ylabel(['Frequency (Hz) x ' num2str(freq)] )

%% time and freq smooth(median)
smootheness = 25;

time_smooth_spect = mymedian_hor(abs_spect, smootheness);
spect_time_smooth = time_smooth_spect.*phase_spect;


freq_smooth_spect = mymedian_ver(abs_spect, smootheness);
spect_freq_smooth = freq_smooth_spect.*phase_spect;


%% display time and freq smooth spect
db_result2 = mag2db(abs(spect_time_smooth));
figure, imagesc(db_result2);ylim([0 disp_ylim]);
set(gca,'YDir','normal');

db_result3 = mag2db(abs(spect_freq_smooth));
figure, imagesc(db_result3);ylim([0 disp_ylim]);
set(gca,'YDir','normal');



%% generate mask, p =1 or 2(mainly)
MH = generate_mask(time_smooth_spect, freq_smooth_spect, 2, 0); %y = (A.^p) ./ (A.^p + B.^p) ;
MP = generate_mask(freq_smooth_spect, time_smooth_spect, 2, 0);

H_hat = abs_spect.*MH;
P_hat = abs_spect.*MP;
spect_H_hat = H_hat.*phase_spect;
spect_P_hat = P_hat.*phase_spect;


db_result4 = mag2db(abs(spect_H_hat));
figure, imagesc(db_result4); set(gca,'YDir','normal');ylim([0 disp_ylim]);

db_result5 = mag2db(abs(spect_P_hat));
figure, imagesc(db_result5); set(gca,'YDir','normal');ylim([0 disp_ylim]);

%% generate mask with separation factor

MH_with_separation_factor = generate_mask(time_smooth_spect, freq_smooth_spect, 2, 1);
MH_SF_hat = abs_spect.*MH_with_separation_factor;
spect_MH_SF_hat = MH_SF_hat.*phase_spect;
db_result6 = mag2db(abs(spect_MH_SF_hat));
figure, imagesc(db_result6); set(gca,'YDir','normal');ylim([0 disp_ylim]);

MP_with_separation_factor = generate_mask(freq_smooth_spect, time_smooth_spect, 2, 1);
MP_SF_hat = abs_spect.*MP_with_separation_factor;
spect_MP_SF_hat = MP_SF_hat.*phase_spect;
db_result7 = mag2db(abs(spect_MP_SF_hat));
figure, imagesc(db_result7); set(gca,'YDir','normal');ylim([0 disp_ylim]);

%%

recon_origin = choh_istft(spect, window_size, hop_size );

recon_time_smooth = choh_istft(spect_time_smooth, window_size, hop_size );
recon_freq_smooth = choh_istft(spect_freq_smooth, window_size, hop_size );

recon_H_hat = choh_istft(spect_H_hat, window_size, hop_size );
recon_P_hat = choh_istft(spect_P_hat, window_size, hop_size );

recon_MH_SF_hat = choh_istft(spect_MH_SF_hat, window_size, hop_size );
recon_MP_SF_hat = choh_istft(spect_MP_SF_hat, window_size, hop_size );


%%
soundsc(recon_origin, fs);
% soundsc(recon_time_smooth, fs);
% soundsc(recon_freq_smooth, fs);
% soundsc(recon_H_hat, fs);
% soundsc(recon_P_hat, fs);
% soundsc(recon_MH_SF_hat, fs);
% soundsc(recon_MP_SF_hat, fs);





