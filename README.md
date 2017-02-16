# Computer Vision Pocker Card Classifier.

Computer vision algorithm suite for classifying pictures of cards.

The algorithms perform segmentation via filtering, adaptive thresholding and morphological transformations:

![](https://github.com/franciscovargas/ivr/blob/master/train1/histograms/rotate_works.jpg)

The adaptive thresholding is carried out by localizing global maximas in the gaussian filtered intensity histogram:

![](https://github.com/franciscovargas/ivr/blob/master/train1/histograms/red_crop_hist.jpg)

Then performing standard blob detection methodolgy to extract meaningful features such as curvature, principal components, convec hull , complex moments etc.

![](https://github.com/franciscovargas/ivr/blob/master/train1/histograms/fail_in%20action.jpg)

the train.m file trains the model on the images in train1 and the test.m tests them on the images in test1. Card is classified as suit and color
