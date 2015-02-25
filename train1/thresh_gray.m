function thresh = threshold(value)
%{
The following parameters were
extracted by inspecting the
gray scale hist (this is silly)
and playing around with values
None norm good params:
    red: 128, 164
    green: 150, 164
    blue: 150, 164

Following settings were extracted
by examining the histogram of each 
collor channel and choosing values
accordingly
Normed good params:
    red: 0.513, 0.572
    green: 0.549, 0.612
    blue: 0.525. 0.529


smothed histograms are kinda shit
updated upper bounds:
    r: 0.6026
    g: 0.6096
    b: 0.616
%}

% Dimensions of the image
[height width channels] = size(value);

% Normalize rgb
normed = rgbnorm(value);

normed = rgb2gray(normed);

% Find edges
edges = linspace(0, 255, 256);

% Flatten values in redscale the two
% last parameters of reshape
% define the new dimensions of vecr
vecr = reshape(normed, 1, width*height);

% Find histograms
histr = histc(vecr, edges);                     % TODO histc not recommended in MathWorks

% Use findtnorm to find threshold values
sizeparam = 40;
upper_thresh = findtfeat(histr, edges, sizeparam, 0);   % TODO ftnr

[height, width, color] = size(normed);
threshed_img = zeros(height, width);                  % TODO output?
for row = 1 : height
    for col = 1 : width
        if normed(row, col) < upper_thresh...   % inside high boundary       % TODO bnd->bound
        & normed(row, col) >= 0                 % optional low boundary
            threshed_img(row, col) = 1;
        else
            % output(row, col)
            threshed_img(row, col) = 0;
        end
    end
end

thresh = threshed_img;