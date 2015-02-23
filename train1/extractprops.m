function runn = extractprops(img, prop, show_conts)
    I = rgb2gray(img);

    % Laplacian edge detection
    threshed = edge(I, 'log');
    threshed = bwareaopen(threshed, 510);

    % Bounding box for card
    out1 = conts(threshed, show_conts);
    property = out1.prop;
    [maxs row] = max([property.Area], [], 2);
    main_box = property(row).BoundingBox;

    [th tw ch] = size(img);

    main_box(1) = main_box(1) + 5;
    main_box(2) = main_box(2) + 5;
    main_box(3) = main_box(3) - 9;
    main_box(4) = main_box(4) - 10;
    center.x = main_box(3) / 2.0;
    center.y = main_box(4) / 2.0;
    tester1 = imcrop(img, main_box);
    crop = imcrop(img, main_box);

    % Binary threshold of grayscale image
    threshed2 = thresh_gray(tester1);

    % Noise removal via majority
    threshed2 = bwmorph(threshed2, 'majority', 300);

    % Noise removal within the card region
    out2 = conts(threshed2, 0);
    bwf = out2.bw;

    % Detection of suits and number
    out3 = conts(bwf, show_conts);
    property3 = out3.prop;
    [mins row3] = min([property3.Area], [], 2);
    smallest = property3(row3).BoundingBox;
    smallest = imcrop(crop, smallest);

    [maxes row3m] = max(out3.boxarea, [], 2);
    biggest = property3(row3m).BoundingBox;
    biggest = imcrop(crop, biggest);

    % PROPERTIES

    % Red channel
    smallest_norm = rgbnorm2(smallest);
    smallest_norm_red = smallest_norm(:, :, 1);
    [h w] = size(smallest_norm_red);
    red_vec = reshape(smallest_norm_red, 1, w*h);
    red_val = mean(red_vec);

    Icrop = rgb2gray(rgbnorm(crop));

    % Feature vector
    fn = 3;
    [N none] = size(property3); 

    for i = 1 : N
        xx = property3(i).Centroid(1) - center.x;
        yy = property3(i).Centroid(2) - center.y;
        vec6(i) = sqrt(xx*xx + yy*yy);
    end

    [none indicesz] = sort(vec6);

    if ~prop
        disp('#######################');

        for i = 1 : N-2 
            cropB = property3(indicesz(i)).BoundingBox;
            cropB(1) = cropB(1) - 2;
            cropB(2) = cropB(2) - 2;
            cropB(3) = cropB(3) + 2;
            cropB(4) = cropB(4) + 2;

            seg = imcrop(Icrop, cropB);

            gts = graythresh(seg);
            seg = ~ im2bw(seg, gts);

            t_img = property3(indicesz(i)).Image;

            tmpv = getproperties(seg);

            for j = 1 : fn 
                featureVec(i, j) = tmpv(j); 
            end

            featureVec(i, fn + 1) = red_val;
        end
    else
        featureVec = N - 4;
    end

    runn = featureVec;
