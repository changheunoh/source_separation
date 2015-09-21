function y=mymedian_hor(spectrogram, median_length)
    time_length = size(spectrogram, 2);
    freq_length = size(spectrogram, 1);
    
    gap = floor(median_length/2);
    
    zero_padding = zeros( freq_length, time_length + gap + gap);
    zero_padding( :, 1+gap: gap+time_length ) = spectrogram;
    
    y = zeros(size(spectrogram));
    
    for jj=1:freq_length
        for ii=(1):(time_length)
            y(jj,ii) = median( zero_padding(jj, ii:ii+gap+gap) );
        end
    end
end