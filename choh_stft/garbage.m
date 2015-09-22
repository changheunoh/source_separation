clear all;
window_size = 128;
index2 = 1:window_size*5;
win = hann(window_size, 'periodic');
% win = hann(window_size, 'symmetric');
sig1 = zeros(window_size*5, 1);
sig2 = zeros(window_size*5, 1);
sig3 = zeros(window_size*5, 1);
sig4 = zeros(window_size*5, 1);
sig5 = zeros(window_size*5, 1);
sig6 = zeros(window_size*5, 1);

sig1(1:window_size) = win';
gap = 0.25;
sig2( 1+window_size*gap : window_size*gap+window_size) = win';
sig3( 1+window_size*gap*2 : window_size*gap*2+window_size) = win';
sig4( 1+window_size*gap*3 : window_size*gap*3+window_size) = win';
sig5( 1+window_size*gap*4 : window_size*gap*4+window_size) = win';
sig6( 1+window_size*gap*5 : window_size*gap*5+window_size) = win';

% index_win2 = 0:1/(window_size-1):1;
% % win2 = (sin(pi*index_win2))';
% win2 = hann(window_size, 'periodic');
% gap = 0.25;
% % win2 = win2/(sqrt(0.5/gap));
% 
% sig1(1:window_size) = (win.*win2)';
% sig2( 1+window_size*gap : window_size*gap+window_size) = (win.*win2)';
% sig3( 1+window_size*gap*2 : window_size*gap*2+window_size) = (win.*win2)';
% sig4( 1+window_size*gap*3 : window_size*gap*3+window_size) = (win.*win2)';
% sig5( 1+window_size*gap*4 : window_size*gap*4+window_size) = (win.*win2)';
% sig6( 1+window_size*gap*5 : window_size*gap*5+window_size) = (win.*win2)';

figure, plot(index2, sig1); hold on;
plot(index2, sig2); hold on;
plot(index2, sig3); hold on;
plot(index2, sig4); hold on;
plot(index2, sig5); hold on;
plot(index2, sig6); hold on;
plot(index2, sig1+sig2+sig3+sig4+sig5+sig6);

% index3 = (1:10)/10; 
% win3 = sin(pi*index3);
% figure, plot(index3, win3);


% index_win2 = (0:1/(window_size-1):1)';
% win2 = (sin(pi*index_win2));
% win1 = (cos(2*pi*index_win2));
% figure, plot(index_win2, win2); hold on;
% plot(index_win2, win1); hold on;
% plot(index_win2, win1+win2); hold on;