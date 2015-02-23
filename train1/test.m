eval(['load ','blackmodel.mat',' maxclasses Means Invcors Aprioris'])
eval(['load ','redmodel.mat',' maxclasses Meansr Invcorsr Apriorisr'])
imagestem = input('Test image file stem (filestem)\n?','s');
run=1;
N =32
Dim=3;
max_black = 0.4653
for imagenum = 1 : N
    currentimagergb = imread([imagestem, int2str(imagenum), '.jpg'], 'jpg');
    
    extrr = extractprops(currentimagergb,0);
        % red channel
    reds(imagenum) = mean(extrr(:,Dim+1));
end
[reds sort_indexes] = sort(reds);

imagenum=0;
while ~(run == 0)
    imagenum = imagenum + 1;
    currentimagergb = imread([imagestem, ...
    int2str(sort_indexes(imagenum)),'.jpg'],'jpg');
    currentimage = currentimagergb;
    imshow(currentimage)
    vec = extractprops(currentimage,0);
    [s none] = size(vec)
    [naN Dim] = size(Means)
    for k=1:s
        vec
        if imagenum > N/2
            classi = classify(vec(k,1:3),maxclasses,Meansr,Invcorsr,Dim,Apriorisr);
            class(k)= classi.class +2;
            probl(k) = classi.proba;
            disp('RED')
        else
            classi = classify(vec(k,1:3),maxclasses,Means,Invcors,Dim,Aprioris);
            class(k)= classi.class;
            probl(k) = classi.proba;
            disp('BLACK')
        end
    end
    class
    probl
    best_class_index = find(probl == max(probl));
    disp('class: ');
    mode(class)
    run = input(['Want to process another image',...
    int2str(sort_indexes(imagenum+1)),' (0,1)\n?']);
end

% gtf = load('GT_training.mat');
% gtf_conts = gtf.gt_training;
% suits = gtf_conts(:,1);
% [N none] = size(suits);
% N

% Dim = 3; % number of feature properties
% modelfilename = input('Model file name (filename)\n?','s');
% maxclasses = input('Number of classes (int)\n?');
% trainfilestem = input('Training image file stem (filestem)\n?', 's');
% % N = input('Number of training images (int)\n?');
% for imagenum = 1 : N
%     currentimagergb = imread([trainfilestem, int2str(imagenum), '.jpg'], 'jpg');
%     % currentimage = rgb2gray(currentimagergb);
%     currentimage = currentimagergb;
%     vec(imagenum,:) = extractprops(currentimage);
%     % trueclasses(imagenum) = input(['Train image ', int2str(imagenum), ...
%     %                                 ' true class (1..', int2str(maxclasses), ')\n?']);
%     trueclasses(imagenum) = suits(imagenum);
% end