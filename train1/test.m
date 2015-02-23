eval(['load ','train.mat',' maxclasses Means Invcors Aprioris'])
imagestem = 'test';
run=1;
N =32
Dim=4;
% for imagenum = 1 : N
%     currentimagergb = imread([imagestem, int2str(imagenum), '.jpg'], 'jpg');
    
%     extrr = extractprops(currentimagergb,0);
%         % red channel
%     reds(imagenum) = mean(extrr(:,Dim+1));
% end
% [reds sort_indexes] = sort(reds);

imagenum=0;
while ~(run == 0)
    imagenum = imagenum + 1;
    currentimagergb = imread([imagestem, ...
    int2str(imagenum),'.jpg'],'jpg');
    currentimage = currentimagergb;
    imshow(currentimage)
    vec = extractprops(currentimage,0);
    num = extractprops(currentimage,1);
    [s none] = size(vec)
    [naN Dim] = size(Means)
    class = []
    for k=1:s
        % vec
        classi = classify(vec(k,:),maxclasses,Means,Invcors,Dim,Aprioris);
        class(k)= classi.class;
        probl(k) = classi.proba;
    end
    class
    probl
    best_class_index = find(probl == max(probl));
    disp('class: ');
    mode(class)
    num
    run = input(['Want to process another image',...
    int2str(imagenum+1),' (0,1)\n?']);
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

%{
maxclasses = 2
imagenum=0;
while ~(run == 0)
    imagenum = imagenum + 1;
    currentimagergb = imread([imagestem, ...
    int2str(imagenum),'.jpg'],'jpg');
    currentimage = currentimagergb;
    imshow(currentimage)
    vec = extractprops(currentimage,0);
    [s none] = size(vec)
    [naN Dim] = size(Means)
    class = [];
    for k=1:s
        % vec
        % class = []
        if vec(k,4) > 0.5
            classi = classify(vec(k,:),maxclasses,Means([2 4],:),Invcors([2 4],:,:),Dim,Aprioris);
            if classi.class == 1
                class(k)= 2;
                probl(k) = classi.proba;
            else
                class(k)= 4;
                probl(k) = classi.proba;
            end
            disp('RED')
        else
            classi = classify(vec(k,:),maxclasses,Means([1 3],:),Invcors([1 3],:,:),Dim,Aprioris);
            if classi.class == 1
                disp('FFS')
                class(k)= 1;
                probl(k) = classi.proba;
            else
                disp('HERE')
                class(k)= 3;
                probl(k) = classi.proba;
            end
            disp('BLACK')
        end
    end
    class
    probl
    best_class_index = find(probl == max(probl));
    disp('class: ');
    mode(class)
    run = input(['Want to process another image',...
    int2str(imagenum+1),' (0,1)\n?']);
end

%}