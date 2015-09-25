function recon = choh_istft(spect, window_size, hop_size )
    
    time_bin = size(spect,2);
    
    if (hop_size/window_size)==0.25
        Nelements = window_size/hop_size;
        norm = 0.25*Nelements + 0.25*0.5*Nelements;
        win = (1/norm)*hann(window_size, 'periodic');    
    elseif (hop_size/window_size)==0.5
        index = 0:1/(window_size-1):1;
        win = sin(pi*index');        
    else
        Nelements = window_size/hop_size;
        norm = 0.25*Nelements + 0.25*0.5*Nelements;
        win = (1/norm)*hann(window_size, 'periodic');
    end
    
    
    X(:,:) = [spect(1:end,:) ;zeros(1,time_bin); conj(spect(end:-1:2,:))];
    recon = zeros(hop_size*time_bin + window_size, 1);
    
    for tt = 1:time_bin    
        
        ifft_result = ifft( X(:,tt) );
        temp_sound = real( ifft_result(1:window_size) .* win );

        recon( (tt-1)*hop_size + 1: (tt-1)*hop_size + window_size) = ...
            recon( (tt-1)*hop_size + 1: (tt-1)*hop_size + window_size) + ...
            temp_sound;
    end
end