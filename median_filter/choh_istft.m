function recon = choh_istft(spect, window_size, hop_size )
    
    time_bin = size(spect,2);
    
    if (hop_size/window_size)==0.25
        win = hann(window_size, 'periodic');
    elseif (hop_size/window_size)==0.5
        index = 1/window_size:1/window_size:1;
        win = sin(pi*index');
    else
        win = 1:window_size;
    end
    
    
    X(:,:) = [spect(1:end,:) ; conj(spect(end:-1:1,:))];
    recon = zeros(hop_size*time_bin + window_size, 1);
    
    for tt = 1:time_bin    
        
        ifft_result = ifft( X(:,tt) );
        temp_sound = real( ifft_result(1:window_size) .* win );

        recon( (tt-1)*hop_size + 1: (tt-1)*hop_size + window_size) = ...
            recon( (tt-1)*hop_size + 1: (tt-1)*hop_size + window_size) + ...
            temp_sound;
    end
end