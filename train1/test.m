eval(['load ', 'training2.mat', ' maxclasses Means Invcors Aprioris']);

gt_t = load('GT_testing.mat');
gtt_conts = gt_t.gt_test;
suits_s = gtt_conts(:, 1);

imagestem = 'test';

run = 1;
N = 32;
Dim = 4;

imagenum = 0;
ind = 1;

while ~(run == 0)
    imagenum = imagenum + 1;
    currentimage = imread([imagestem, int2str(imagenum), '.jpg'], 'jpg');

    vec = extractprops(currentimage, 0, 1);
    num = extractprops(currentimage, 1, 0);
    [s none] = size(vec);
    [none Dim] = size(Means);
    class = [];

    for k = 1 : s
        classi = classify(vec(k, :), maxclasses, Means, Invcors, Dim, Aprioris);
        class(k) = classi.class;
        probl(k) = classi.proba;

        pred_all_s(ind + k - 1, 1) = classi.class;
        exp_all_s(k + ind - 1, 1) = suits_s(imagenum);
    end

    ind = ind + s;

    best_class_index = find(probl == max(probl));

    disp(['Suit: ', int2str(mode(class))]);
    disp(['Number: ', int2str(num)]);

    out_vec(imagenum, 1) = mode(class);
    out_vec(imagenum, 2) = num;

    if imagenum + 1 == 33
        break;
    end

    run = input(['Want to process another image', int2str(imagenum + 1), ' (0,1)\n?']);
end

class_vecf.suits = out_vec(:, 1);
class_vecf.num = out_vec(:, 2);
save('predicted.mat', 'class_vecf');
