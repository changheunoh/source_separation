function [result, t, f]=STFT(orig,Fs, window_type, window_size, hop_size, FFT_size)

% window_type,      window_size,    hop_size,   FFT_size
%     'boxcar'      default=        default=    default=
%     'bartlett'        
%     'hann'        
%     'hamming'        
%     'blackman'

size_measure = int32( size(orig));
%picking one channel only
if(size(orig, 2)~=1)
    orig = squeeze(orig(:,1));
end

size_orig=size_measure(1,1);

switch window_type
    case 'boxcar'
        selected_window = ones(window_size,1);
    case 'bartlett'
        selected_window = bartlett(window_size);
    case 'hann'
        selected_window = hann(window_size);
    case 'hamming'
        selected_window = hamming(window_size);
	case 'blackman'
      	selected_window = blackman(window_size);
%     otherwise                    
end


bin_size = ceil( double(double(size_orig)/double(hop_size)) ) ; % number of bin size
bin_orig = zeros(FFT_size, bin_size);

for ii = 1:(bin_size -1)
    if ( window_size + (ii-1)*hop_size )>size_orig
        temp_padding = zeros(window_size, 1);
        temp_padding(1: size_orig - (ii-1)*hop_size) = orig( 1 + (ii-1)*hop_size : size_orig );
        bin_orig(1:window_size, ii) = temp_padding .* selected_window;
    else
        bin_orig(1:window_size, ii) = orig( 1 + (ii-1)*hop_size : window_size + (ii-1)*hop_size ) .* selected_window;
    end
end
temp_padding = zeros(window_size, 1);
temp_padding(1:size_orig - hop_size*(bin_size-1)) = orig( 1 + hop_size*(bin_size-1) : size_orig );
bin_orig(1:window_size, bin_size)  = temp_padding .* selected_window;

f_disp = ceil( (FFT_size+1)/2 );
result_full = zeros(FFT_size,bin_size);
result = zeros( f_disp, bin_size);
for ii = 1 : bin_size
    result_full(:,ii) = fft(bin_orig(:,ii));
    result(:,ii) = result_full(1:f_disp, ii);
end
t=(0:hop_size:size_orig)/Fs;
f = (0:f_disp-1)*Fs/(f_disp-1)/2;
end