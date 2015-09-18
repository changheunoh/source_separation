function y=mymedian_ver(spectrogram, median_length)
    time_length = size(spectrogram, 2);
    freq_length = size(spectrogram, 1);
    
    gap = floor(median_length/2);
    
    y = zeros(size(spectrogram));
    for ii=1:time_length
        for jj=(1+gap):(freq_length-gap)
            y(jj,ii) = median( spectrogram(jj-gap:jj+gap, ii) );
        end
    end
end