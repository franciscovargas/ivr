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

% img = imread('train14.jpg');
% dimensions of the image
[height width channels] = size(value);
% normalize rgb
normed = rgbnorm(value);
% 
normed = rgb2gray(normed);
% find edges
edges = linspace(0,255,256);

% value = normed;

% flatten values in redscale the two
% last parameters of reshape
% define the new dimensions of vecr
vecr = reshape(normed,1,width*height);
% same for green


% find histograms
histr = histc(vecr, edges);


% use findtnorm to find threshold values
sizeparam = 13;
% ftnr = findtfeat(histr,edges,sizeparam,1);
ftnr = findtfeat(histr,edges,sizeparam,0);

[height, width, color] = size(normed);
output = zeros(height, width);
for row = 1 : height
    for col = 1 : width
        if normed(row,col) < ftnr ... % inside high bnd
        & normed(row,col) >  0.0 % optional low bnd
            output(row,col) = 1;
        else
            output(row,col) = 0;
        end
    end
end
figure
imshow(output)

thresh = output;