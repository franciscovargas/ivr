% Capture 3 frames of a new sequene 
% (Note: this is v4-ell-2, not v4-one-2, as in video-for-linux)
% unix('killall mplayer');
% unix('mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -frames 3 -vo jpeg');

liveimagejpg('test0');

% from lab
I = imread('test0.jpg'); 

% test('00003.jpg');

test(I, 1);
