% Load predicted classes
pred = load('predicted.mat');

% Load expected classes 
expec = load('gt_testing2.mat');

% Load expected and predicted classes for all features
feats = load('all_feats.mat');
all_feats = feats.all_feats;

% Setting up the predicted classes
pred_class = pred.class_vec;
pred_suits = pred_class.suits;
pred_nums = pred_class.num;
pred_all_feats = all_feats.pred;

% Setting up the expected classes
exp_class = expec.test2;
exp_suits = exp_class(:, 1);
exp_nums = exp_class(:, 2);
exp_all_feats = all_feats.exp;

% Creating the three confusion matrices
[confusion_suits, none] = confusionmat(exp_suits, pred_suits);
[confusion_nums, none] = confusionmat(exp_nums, pred_nums);
[confusion_all_feats, none] = confusionmat(exp_all_feats, pred_all_feats);

% Displaying the confusion matrices
disp('Cards Grouped by Suits');
confusion_suits
save('confusion_suits_extra.mat', 'confusion_suits');

disp('Cards Grouped by Value');
confusion_nums
save('confusion_nums_extra.mat', 'confusion_nums');

disp('Individual Suit Symbols');
confusion_all_feats
save('confusion_all_feats_extra.mat', 'confusion_all_feats');
