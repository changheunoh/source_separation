function [spect, f, t] = choh_stft(x, window_size, hop_size, fft_size, fs)
    if size(x, 2) > size(x, 1)
        x = x';        
    end
    if size(x,2)==2
        x = x(:,1);
    end
    
    % generate window
    if (hop_size/window_size)==0.25
        win = hann(window_size, 'periodic');          
    elseif (hop_size/window_size)==0.5
        index = 0:1/(window_size-1):1;
        win = sin(pi*index');
    else
        win = hann(window_size, 'periodic');
    end
    
    
    
    xlen = length(x);    
    freq_bin = fft_size/2;
    time_bin = ceil((xlen - window_size)/hop_size) + 1;
    
    spect = zeros(freq_bin, time_bin);
    
    
    for tt=1:(time_bin-1)
        temp_sound = x((tt-1)*hop_size+1:(tt-1)*hop_size+window_size) .* win ;
        fft_result = fft(temp_sound, fft_size);
        spect(:,tt) = fft_result(1:freq_bin);
        
    end
    temp_sound = zeros(window_size,1);
    rest_sound = x((time_bin-1)*hop_size+1:end);
    temp_sound(1:length(rest_sound)) = rest_sound;
    temp_sound = temp_sound .*win;
    fft_result = fft(temp_sound, fft_size);
    spect(:,time_bin) = fft_result(1:freq_bin);
    
    
    
    
    t = (window_size/2:hop_size:window_size/2+(time_bin-1)*hop_size)/fs;
    f = (0:freq_bin-1)*fs/fft_size;
end