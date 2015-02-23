gtf = load('GT_training.mat');
gtf_conts = gtf.gt_training;
suits = gtf_conts(:,1);
[N none] = size(suits);
N

Dim = 4; % number of feature properties
modelfilename ='training.mat';
maxclasses = 4;
trainfilestem = 'train';
% N = input('Number of training images (int)\n?');

% for imagenum = 1 : N
%     currentimagergb = imread([trainfilestem, int2str(imagenum), '.jpg'], 'jpg');
    
%     extrr = extractprops(currentimagergb,0);
%         % red channel
%     reds(imagenum) = mean(extrr(:,Dim+1));
% end
% [reds sort_indexes] = sort(reds);

disp('THE LINE ############################################################');

ss=1;
% ind = 1;
for imagenum = 1 : N
    currentimagergb2 = imread([trainfilestem, int2str(imagenum), '.jpg'], 'jpg');
    % currentimage = rgb2gray(currentimagergb);
    currentimage = currentimagergb2;

    % figure
    % imshow(currentimage);

    extr = extractprops(currentimage,0);
    [s non] = size(extr);
    
    % ss = s;
    s
    non
    for i=1:s
        vec(imagenum + i - 1 + (ss-1),:) = extr(i,:);
        class_vec(imagenum + i - 1 + (ss-1)) = suits(imagenum);
    end
    % trueclasses(imagenum) = input(['Train image ', int2str(imagenum), ...
    %                                 ' true class (1..', int2str(maxclasses), ')\n?']);
    ss = ss + s - 1;
    % ind = ind + s;
    % trueclasses(imagenum) = suits(imagenum);
    % if trueclasses(imagenum) == 3
    %     trueclasses(imagenum) = 2;
    % else
    %     trueclasses(imagenum) = 1;
    % end
imagenum
end
size(vec)
% trueclasses
[Means, Invcors, Aprioris] = buildmodel(Dim, vec, N, maxclasses, class_vec);
eval(['save ', modelfilename, ' maxclasses Means Invcors Aprioris'])