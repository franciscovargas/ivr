gt_train = load('GT_training.mat');
gt_train_conts = gt_train.gt_training;
suits = gt_train_conts(:, 1);
[N none] = size(suits);

Dim = 4; % number of feature properties
modelfilename = 'training2.mat';
maxclasses = 4;
trainfilestem = 'train';

k = 1;
for imagenum = 1 : N
    currentimage = imread([trainfilestem, int2str(imagenum), '.jpg'], 'jpg');

    extr = extractprops(currentimage, 0, 0);
    [feat_num none] = size(extr);
    
    for i = 1 : feat_num
        vec(imagenum + i - 1 + (k - 1),:) = extr(i, :);
        class_vec(imagenum + i - 1 + (k - 1)) = suits(imagenum);
    end

    k = k + feat_num - 1;
end

[Means, Invcors, Aprioris] = buildmodel(Dim, vec, N, maxclasses, class_vec);
eval(['save ', modelfilename, ' maxclasses Means Invcors Aprioris'])