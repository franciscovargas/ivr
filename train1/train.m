gtf = load('GT_training.mat');
gtf_conts = gtf.gt_training;
suits = gtf_conts(:, 1);
[N none] = size(suits);

Dim = 4; % number of feature properties
modelfilename = 'training2.mat';
maxclasses = 4;
trainfilestem = 'train';

ss = 1;
for imagenum = 1 : N
    currentimage = imread([trainfilestem, int2str(imagenum), '.jpg'], 'jpg');

    extr = extractprops(currentimage, 0, 0);
    [s none] = size(extr);
    
    for i = 1 : s
        vec(imagenum + i - 1 + (ss - 1),:) = extr(i, :);
        class_vec(imagenum + i - 1 + (ss - 1)) = suits(imagenum);
    end

    ss = ss + s - 1;
end

[Means, Invcors, Aprioris] = buildmodel(Dim, vec, N, maxclasses, class_vec);
eval(['save ', modelfilename, ' maxclasses Means Invcors Aprioris'])