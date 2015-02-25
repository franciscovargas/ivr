pred = load('predicted.mat');
expec = load('gt_testing2.mat');

pred_class = pred.class_vec;
pred_suits = pred_class.suits;
pred_nums = pred_class.num;

exp_class = expec.test2;
exp_suits = exp_class(:, 1);
exp_nums = exp_class(:, 2);

pred_all_feats = pred_all_feats(:, 1);
exp_all_feats = exp_all_feats(:, 1);

[confusion_suits, none] = confusionmat(exp_suits, pred_suits);
[confusion_nums, none] = confusionmat(exp_nums, pred_nums);
[confusion_all_feats, none] = confusionmat(exp_all_feats, pred_all_feats);

disp('Cards Grouped by Suits');
confusion_suits
save('confusion_suits_extra.mat', 'confusion_suits');

disp('Cards Grouped by Value');
confusion_nums
save('confusion_nums_extra.mat', 'confusion_nums');

disp('Individual Suit Symbols');
confusion_all_feats
save('confusion_all_feats_extra.mat', 'confusion_all_feats');
