% Load expected classes for suits
gt_train = load('GT_training.mat');
gt_train_conts = gt_train.gt_training;
suits = gt_train_conts(:, 1);
[N none] = size(suits);

% Number of feature properties
Dim = 4;

% Number of suits
maxclasses = 4;

modelfilename = 'training4.mat';
trainfilestem = 'train';

% Index used for keeping track of the features in each card
k = 1;

% Outer loop for iteration through cards
for imagenum = 1 : N
    currentimage = imread([trainfilestem, int2str(imagenum), '.jpg'], 'jpg');

    % Feature vectors of card
    properties = extractprops(currentimage, 0, 0);
    [feat_num none] = size(properties);
    
    % Inner loop for iteration through card features
    for i = 1 : feat_num
        % Adding feature vectors for build model (240x4 matrix)
        vec(imagenum + i - 1 + (k - 1), :) = properties(i, :);

        % Keeping track of the classes of each feature to be used in build model
        class_vec(imagenum + i - 1 + (k - 1)) = suits(imagenum);
    end

    % Incrementing start of the matrices filled in the inner loop
    k = k + feat_num - 1;
end

% Naive Bayes Gaussian trained parameters
[Means, Invcors, Aprioris] = buildmodel(Dim, vec, N, maxclasses, class_vec);
eval(['save ', modelfilename, ' maxclasses Means Invcors Aprioris'])
