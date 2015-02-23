pred = load('predicted.mat');
expe = load('GT_testing.mat');

pred_cl = pred.class_vecf;
pred_suits = pred_cl.suits;
pred_nums = pred_cl.numbe;

exp_cl = expe.gt_test;
exp_suits = exp_cl(:,1);
exp_nums = exp_cl(:,2);

pred_all_suits = pred_all_s(:,1);
exp_all_suits = exp_all_s(:,1);

[confusion_suits, order_s] = confusionmat(exp_suits, pred_suits);
[confusion_nums, order_n] = confusionmat(exp_nums, pred_nums);
[confusion_all_suits, order_as] = confusionmat(exp_all_suits, pred_all_suits);

disp('Cards Grouped by Suits');
confusion_suits
[dim_s none] = size(order_s);
dim_s
save('confusion_suits.mat','confusion_suits');

disp('Cards Grouped by Value');
confusion_nums
[dim_n none] = size(order_n);
dim_n
save('confusion_nums.mat','confusion_nums');

disp('All Suits in Cards Grouped by Suits');
confusion_all_suits
[dim_as none] = size(order_as);
dim_as
save('confusion_all_suits.mat','confusion_nums');