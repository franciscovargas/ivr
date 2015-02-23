gtf = load('GT_training.mat');
gtf_conts = gtf.gt_training;
suits = gtf_conts(:,1);
[N none] = size(suits);
N

Dim = 3; % number of feature properties
modelfilename = input('Model file name (filename)\n?','s');
maxclasses = input('Number of classes (int)\n?');
trainfilestem = input('Training image file stem (filestem)\n?', 's');
% N = input('Number of training images (int)\n?');

for imagenum = 1 : N
    currentimagergb = imread([trainfilestem, int2str(imagenum), '.jpg'], 'jpg');
    
    extrr = extractprops(currentimagergb,0);
        % red channel
    reds(imagenum) = mean(extrr(:,Dim+1));
end
[reds sort_indexes] = sort(reds);

disp('THE LINE ############################################################');

ss=1;
'black max'
reds(N/2) 
for imagenum = N/2 + 1: N
    currentimagergb2 = imread([trainfilestem, int2str(sort_indexes(imagenum)), '.jpg'], 'jpg');
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
        vec(imagenum + i - 1 + (ss-1),:) = extr(i,1:3);
        if suits(sort_indexes(imagenum)) == 4
            class_vec(imagenum + i - 1 + (ss-1)) = 2;
        else
            class_vec(imagenum + i - 1 + (ss-1)) = 1;
        end
    end
    % trueclasses(imagenum) = input(['Train image ', int2str(imagenum), ...
    %                                 ' true class (1..', int2str(maxclasses), ')\n?']);
    imagenum
    ss = ss + s - 1;
    trueclasses(imagenum) = suits(sort_indexes(imagenum));
    if trueclasses(imagenum) == 4
        trueclasses(imagenum) = 2;
    else
        trueclasses(imagenum) = 1;
    end

end
size(vec)
trueclasses
[Meansr, Invcorsr, Apriorisr] = buildmodel(Dim, vec, N, maxclasses, class_vec);
eval(['save ', modelfilename, ' maxclasses Meansr Invcorsr Apriorisr'])