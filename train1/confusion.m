pred = load('predicted.mat');
expe = load('GT_testing.mat');

pred_class = pred.class_vecf;
pred_suits = pred_class.suits;
pred_nums = pred_class.num;

exp_class = expe.gt_test;
exp_suits = exp_class(:, 1);
exp_nums = exp_class(:, 2);

pred_all_suits = pred_all_s(:, 1);
exp_all_suits = exp_all_s(:, 1);

[confusion_suits, order_s] = confusionmat(exp_suits, pred_suits);
[confusion_nums, order_n] = confusionmat(exp_nums, pred_nums);
[confusion_all_suits, order_as] = confusionmat(exp_all_suits, pred_all_suits);

disp('Cards Grouped by Suits');
confusion_suits
save('confusion_suits.mat', 'confusion_suits');

disp('Cards Grouped by Value');
confusion_nums
save('confusion_nums.mat', 'confusion_nums');

disp('All Suits in Cards Grouped by Suits');
confusion_all_suits
save('confusion_all_suits.mat', 'confusion_all_suits');