eval(['load ', 'training2.mat', ' maxclasses Means Invcors Aprioris']);

gt_testing = load('GT_testing.mat');
gt_test_conts = gt_testing.gt_test;
suits = gt_test_conts(:, 1);

imagestem = 'test';

run = 1;
N = 32;
Dim = 4;

imagenum = 0;
k = 1;

while ~(run == 0)
    imagenum = imagenum + 1;
    currentimage = imread([imagestem, ...
                           int2str(imagenum), '.jpg'], ...
                           'jpg');

    vec = extractprops(currentimage, 0, 1);
    num = extractprops(currentimage, 1, 0);
    [feat_num none] = size(vec);
    [none Dim] = size(Means);
    class = [];

    for i = 1 : feat_num
        feat_class = classify(vec(i, :), ...
                              maxclasses, ...
                              Means, ...
                              Invcors, ...
                              Dim, ...
                              Aprioris);
        class(i) = feat_class.class;
        probl(i) = feat_class.prob;

        pred_all_feats(i + k - 1, 1) = feat_class.class;
        exp_all_feats(i + k - 1, 1) = suits(imagenum);
    end

    k = k + feat_num;

    best_class_index = find(probl == max(probl));

    disp(['Suit: ', int2str(mode(class))]);
    disp(['Number: ', int2str(num)]);

    out_vec(imagenum, 1) = mode(class);
    out_vec(imagenum, 2) = num;

    if imagenum + 1 == 33
        break;
    end

    run = input(['Want to process another image', ...
                int2str(imagenum + 1), ' (0,1)\n?']);
end

class_vec.suits = out_vec(:, 1);
class_vec.num = out_vec(:, 2);
save('predicted.mat', 'class_vec');
