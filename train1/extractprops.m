function extractproperties = extractprops(img, prop, show_conts) % TODO runn
    I = rgb2gray(img);

    % Laplacian edge detection
    threshed_edge = edge(I, 'log');                     % TODO threshed
    threshed_edge = bwareaopen(threshed_edge, 510);

    % Bounding box for card
    card_properties = conts(threshed_edge, show_conts);         % TODO out1
    card_regions = card_properties.prop;                       % TODO property      % TODO prop?
    [maxs max_index] = max([card_regions.Area], [], 2);           % TODO row?;  maxs not used
    main_box = card_regions(max_index).BoundingBox;                                           

    main_box(1) = main_box(1) + 5;
    main_box(2) = main_box(2) + 5;
    main_box(3) = main_box(3) - 9;
    main_box(4) = main_box(4) - 10;

    center.x = main_box(3) / 2.0;
    center.y = main_box(4) / 2.0;
    % tester1 = imcrop(img, main_box);            % TODO tester1
    card_crop = imcrop(img, main_box);               % TODO crop

    % figure
    % imshow(crop);

    % Binary threshold of grayscale image
    % Threshold of suits and number without noise removal
    threshed_feats = thresh_gray(card_crop);           % was tester1;   threshed2

    % Noise removal via majority
    threshed_feats = bwmorph(threshed_feats, 'majority', 300);

    % Additional noise removal within the card region
    noise_removed = conts(threshed_feats, 0);                 % TODO out2
    clear_image = noise_removed.bw;                              % TODO bwf

    % Detection of suits and number
    feature_properties = conts(clear_image, show_conts);              % TODO out3
    feature_regions = feature_properties.prop;                      % TODO property3
    [mins min_index] = min([feature_regions.Area], [], 2); % TODO row3
    smallest_feat = feature_regions(min_index).BoundingBox;      % TODO smallest
    smallest_feat = imcrop(card_crop, smallest_feat);

    % [maxs max_index2] = max(feature_properties.boxarea, [], 2);   % TODO row3m    maxes->maxs
    % biggest = property3(max_index2).BoundingBox;
    % biggest = imcrop(crop, biggest);

    % PROPERTIES

    % Red channel
    smallest_feat_norm = rgbnorm2(smallest_feat);                % TODO smallest_norm
    smallest_feat_norm_red = smallest_feat_norm(:, :, 1);          % TODO smallest_norm_red
    [h w] = size(smallest_feat_norm_red);
    red_vec_feat = reshape(smallest_feat_norm_red, 1, h*w);      % TODO red_vec
    % red_vec
    avg_red_val_feat = mean(red_vec_feat);                    % TODO red_val

    gray_crop = rgb2gray(card_crop);            % TODO rgbnorm NOT NECESSARY
                                                % TODO Icrop

    % Feature vector
    % fn = 3;                                     % TODO fn
    [N none] = size(feature_regions); 

    for i = 1 : N
        xx = feature_regions(i).Centroid(1) - center.x;
        yy = feature_regions(i).Centroid(2) - center.y;
        dist_vec(i) = sqrt(xx*xx + yy*yy);          % TODO vec6
    end

    [none dist_index] = sort(dist_vec);               % TODO indicesz -> indices

    if ~prop
        disp('#######################');

        for i = 1 : N - 2 
            feat_crop = feature_regions(dist_index(i)).BoundingBox; % TODO cropB
            feat_crop(1) = feat_crop(1) - 2;
            feat_crop(2) = feat_crop(2) - 2;
            feat_crop(3) = feat_crop(3) + 2;
            feat_crop(4) = feat_crop(4) + 2;

            threshed_feat_crop = imcrop(gray_crop, feat_crop);         % TODO seg ?

            gray_level = graythresh(threshed_feat_crop);              % TODO gts
            threshed_feat_crop = ~ im2bw(threshed_feat_crop, gray_level);

            % t_img = feature_regions(dist_index(i)).Image;   % TODO t_img

            feat_vec = getproperties(threshed_feat_crop);          % TODO tmpv
            [none prop_num] = size(feat_vec);

            for j = 1 : prop_num 
                feat_vec_matrix(i, j) = feat_vec(j);                     % TODO featureVec
            end

            feat_vec_matrix(i, prop_num + 1) = avg_red_val_feat;
        end

        extractproperties = feat_vec_matrix;
    else
        card_number = N - 4;                % TODO feat_vec_matrix
        extractproperties = card_number;
    end

    % extractproperties = feat_vec_matrix;
