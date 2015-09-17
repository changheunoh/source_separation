function y=mymedian_hor(spectrogram, median_length)
    time_length = size(spectrogram, 2);
    freq_length = size(spectrogram, 1);
    
    gap = floor(median_length/2);
    
    y = zeros(size(spectrogram));
    for jj=1:freq_length
        for ii=(1+gap):(time_length-gap)
            y(jj,ii) = median( spectrogram(jj, ii-gap:ii+gap) );
        end
    end
end