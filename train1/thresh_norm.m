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
% find edges
edges = linspace(0,1,255);

% value = normed;

% flatten values in redscale the two
% last parameters of reshape
% define the new dimensions of vecr
vecr = reshape(normed(:,:,1),1,width*height);
% same for green
vecg = reshape(normed(:,:,2),1,width*height);
% same for blue
vecb = reshape(normed(:,:,3),1,width*height);

% find histograms
histr = histc(vecr, edges);
histg = histc(vecg, edges);
histb = histc(vecb, edges);

% use findtnorm to find threshold values
sizeparam = 10;
ftnr = findtnorm(histr,edges,sizeparam,1);
ftng = findtnorm(histg,edges,sizeparam,1);
ftnb = findtnorm(histb,edges,sizeparam,1);

[height, width, color] = size(normed);
output = zeros(height, width,3);
for row = 1 : height
    for col = 1 : width
        if normed(row,col,1) < 1 ... % inside high bnd
        & normed(row,col,1) > ftnr % optional low bnd
            output(row,col,1) = 1;
        else
            output(row,col,1) = 0;
        end
    end
end

for row = 1 : height
    for col = 1 : width
        if normed(row,col,2) < 1 ... % inside high bnd
        & normed(row,col,2) > ftng % optional low bnd
            output(row,col,2) = 1;
        else
            output(row,col,2) = 0;
        end
    end
end


for row = 1 : height
    for col = 1 : width
        if normed(row,col,3) < 1 ... % inside high bnd
        & normed(row,col,3) > ftnb % optional low bnd
            output(row,col,3) = 1;
        else
            output(row,col,3) = 0;
        end
    end
end
thresh = output(:,:,3) | output(:,:,1) | output(:,:,2);