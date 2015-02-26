function extractproperties = extractprops(img, suit_or_num, show_conts)

    I = rgb2gray(img);

    % Laplacian edge detection
    threshed_edge = edge(I, 'log');
    threshed_edge = bwareaopen(threshed_edge, 510);

    % Bounding box for card
    card_properties = conts(threshed_edge, show_conts);
    card_regions = card_properties.prop;
    [maxs max_index] = max([card_regions.Area], [], 2);
    main_box = card_regions(max_index).BoundingBox;                                           

    % Scaling down bounding box dimensions
    main_box(1) = main_box(1) + 5;
    main_box(2) = main_box(2) + 5;
    main_box(3) = main_box(3) - 9;
    main_box(4) = main_box(4) - 10;

    % Center of bounding box (approx center of the card)
    center.x = main_box(3) / 2.0;
    center.y = main_box(4) / 2.0;

    % Approximate cropping of the card
    card_crop = imcrop(img, main_box);

    % Binary threshold of grayscale image
    % Threshold of suits and number without noise removal
    threshed_feats = thresh_gray(card_crop);

    % Noise removal via majority
    threshed_feats = bwmorph(threshed_feats, 'majority', 300);

    % Additional noise removal within the card region
    noise_removed = conts(threshed_feats, 0);
    clear_image = noise_removed.bw;

    % Detection of suits and number
    feature_properties = conts(clear_image, show_conts);
    feature_regions = feature_properties.prop;

    % Smallest region used to find average in red channel
    [mins min_index] = min([feature_regions.Area], [], 2);
    smallest_feat = feature_regions(min_index).BoundingBox;
    smallest_feat = imcrop(card_crop, smallest_feat);

    % Finding average of red channel in smallest feature
    smallest_feat_norm = rgbnorm(smallest_feat);
    smallest_feat_norm_red = smallest_feat_norm(:, :, 1);
    [h w] = size(smallest_feat_norm_red);
    red_vec_feat = reshape(smallest_feat_norm_red, 1, h*w);
    avg_red_val_feat = mean(red_vec_feat);

    % Gray scale of approx card cropping
    gray_crop = rgb2gray(card_crop);

    % Size of feature vector
    [N none] = size(feature_regions); 

    % Approx distance between center of mass of each region and card center
    for i = 1 : N
        xx = feature_regions(i).Centroid(1) - center.x;
        yy = feature_regions(i).Centroid(2) - center.y;
        dist_vec(i) = sqrt(xx*xx + yy*yy);
    end

    % Sorting the above distances
    [none dist_index] = sort(dist_vec);

    % S
    if ~suit_or_num                                                          % TODO prop
        disp('#######################');
        fprintf('\n');

        % Outer loop for N-2 closest regions to the center (suits)
        for i = 1 : N - 2 
            % Using dist_index to insure iteration over sorted regions
            feat_crop = feature_regions(dist_index(i)).BoundingBox;

            % Scaling up of suit regions
            feat_crop(1) = feat_crop(1) - 2;
            feat_crop(2) = feat_crop(2) - 2;
            feat_crop(3) = feat_crop(3) + 2;
            feat_crop(4) = feat_crop(4) + 2;

            % Cropping and threshing of suit region on a non threshed gray scale card
            threshed_feat_crop = imcrop(gray_crop, feat_crop);
            gray_level = graythresh(threshed_feat_crop);
            threshed_feat_crop = ~ im2bw(threshed_feat_crop, gray_level);

            % Feature vectors for classification or training
            feat_vec = getproperties(threshed_feat_crop);
            [none prop_num] = size(feat_vec);

            % Inner loop building matrix of rows as feature vector
            for j = 1 : prop_num 
                feat_vec_matrix(i, j) = feat_vec(j);
            end

            % Adding mean red channel value of card to feature vectors
            feat_vec_matrix(i, prop_num + 1) = avg_red_val_feat;
        end

        % Return value of the function
        extractproperties = feat_vec_matrix;
    else
        % Card number prediction (counting)
        card_number = N - 4;

        % Return value of the function       
        extractproperties = card_number;
    end
