function test = testc(image, cam_read)
    % Load train parameters
    eval(['load ', 'training3.mat', ' maxclasses Means Invcors Aprioris']);

    % Load expected classes
    gt_testing = load('gt_testing2.mat');
    gt_test_conts = gt_testing.test2;
    suits = gt_test_conts(:, 1);

    if ~cam_read
        imagestem = 'test';
    end

    % Number of features in feature vector
    Dim = 4;

    % Number of test cards
    N = 40;

    % Card number
    imagenum = 0;

    % Index used for keeping track of the features in each card
    k = 1;

    run = 1;

    % Outer loop for iteration through cards
    while ~(run == 0)
        imagenum = imagenum + 1;
        if ~cam_read
            currentimage = imread([imagestem, ...
                                  int2str(imagenum), '.jpg'], ...
                                  'jpg');
        else
            currentimage = image;
        end

        % Card feature vectors for suit classification
        vec = extractprops(currentimage, 0, 1);

        % Estimated card number by counting
        num = extractprops(currentimage, 1, 0);

        [feat_num none] = size(vec);
        [none Dim] = size(Means);

        % Vector yielding classifications for each feature
        class = [];

        % Inner loop for iteration through card features
        for i = 1 : feat_num
            % Naive Bayes classification
            feat_class = classify(vec(i, :), ...
                                  maxclasses, ...
                                  Means, ...
                                  Invcors, ...
                                  Dim, ...
                                  Aprioris);
            class(i) = feat_class;

            % Setting up parameters for third confusion matrix
            pred_all_feats(i + k - 1, 1) = feat_class;
            exp_all_feats(i + k - 1, 1) = suits(imagenum);
        end

        % Incrementing start of the matrices filled in the inner loop
        k = k + feat_num;

        % Displaying predicted class of each feature
        disp(['Class per feature: ', int2str(class)]);
        fprintf('\n');

        % Displaying number and suit classification results
        if mode(class) == 1
            suit_class = 'Spades';
        elseif mode(class) == 2
            suit_class = 'Hearts';
        elseif mode(class) == 3
            suit_class = 'Clubs';
        else
            suit_class = 'Diamonds';
        end

        disp(['Number: ', int2str(num), ' of ', suit_class]);
        fprintf('\n');

        % Setting up parameters for first and second confusion matrices
        out_vec(imagenum, 1) = mode(class);
        out_vec(imagenum, 2) = num;

        % End loop
        if imagenum + 1 == N + 1
            break;
        end

        if cam_read == 1
            break;
        end

        run = input(['Want to process another image', ...
                    int2str(imagenum + 1), ' (0,1)\n?']);
    end

    % Saving output for confusion matrices
    class_vec.suits = out_vec(:, 1);
    class_vec.num = out_vec(:, 2);
    save('predicted.mat', 'class_vec');

    all_feats.pred = pred_all_feats;
    all_feats.exp = exp_all_feats;
    save('all_feats.mat', 'all_feats');
