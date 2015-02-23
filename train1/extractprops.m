function runn = extractprops(img, prop)
    I = rgb2gray(img);

    % laplacian edge detection
    threshed = edge(I, 'log');
    threshed = bwareaopen(threshed,510);

    % bounding box for card
    out1 = conts(threshed);
    property = out1.prop;
    [maxs row] = max([property.Area], [], 2);
    main_box = property(row).BoundingBox;
    % convex_box = property(row).ConvexHull;
    % cx = convex_box(:,1);
    % cy = convex_box(:,2);
    [th tw ch] = size(img);

    main_box(1) = main_box(1) + 5;
    main_box(2) = main_box(2) + 5;
    main_box(3) = main_box(3) - 9;
    main_box(4) = main_box(4) - 10;
    center.x = main_box(3) / 2.0;
    center.y = main_box(4) / 2.0;
    tester1 = imcrop(img, main_box);
    crop = imcrop(img, main_box);

    % binary threshold of grayscale image
    threshed2 = thresh_gray(tester1);

    % noise removal via majority
    threshed2 = bwmorph(threshed2, 'majority', 300);

    % noise removal within the card region
    out2 = conts(threshed2);
    bwf = out2.bw;

    % detection of suits and number
    out3 = conts(bwf);
    property3 = out3.prop;
    [mins row3] = min([property3.Area], [], 2);
    smallest = property3(row3).BoundingBox;
    smallest = imcrop(crop, smallest);

    [maxes row3m] = max(out3.boxarea, [], 2);
    biggest = property3(row3m).BoundingBox;
    biggest = imcrop(crop, biggest);

    % PROPERTIES

    % red channel
    smallest_norm = rgbnorm(smallest);
    % smallest_norm = smallest;
    smallest_norm_red = smallest_norm(:,:,1);
    [h w] = size(smallest_norm_red);
    red_vec = reshape(smallest_norm_red,1,w*h);
    red_val = mean(red_vec);
    Icrop = rgb2gray(rgbnorm(crop));


    % feature vector
    fn = 3;
    [no N] = size(property3); 
    % no = 1;
    % featureVec = zeros(1,no*fn+1);
    for i=1:no
        xx = property3(i).Centroid(1) - center.x;
        yy = property3(i).Centroid(2) - center.y;
        vec6(i) = sqrt(xx*xx +yy*yy) ;
        % vec6(i).im = property3(i).Image;
    end
    [nope indicesz] = sort(vec6);

    % vec6
    if ~ prop
        disp('noooooooooooooooooo');
        no
        for i=1:no-2 
            cropB = property3(indicesz(i)).BoundingBox;
            cropB(1) = cropB(1)-3;
            cropB(2) = cropB(2)-3;
            cropB(3) = cropB(3)+ 3;
            cropB(4) = cropB(4)+ 3;
            seg = imcrop(Icrop, cropB);

            gts = graythresh(seg);
            seg = ~ im2bw(seg, gts);

            % figure
            % imshow(seg)
            t_img = property3(indicesz(i)).Image;

                        % bbbb
            tmpv = getproperties(seg);
            % size(tmpv)
            % tmpv = getproperties(property3(row3).Image);
            for j=1:fn 
                featureVec(i,j) = tmpv(j); 
            end
            featureVec(i,fn+1) = red_val;
        end
    else
        for i=1:2
            t_img = property3(i).Image;
            tmpv = getproperties(t_img);
            for j=1:fn 
                featureVec(i-2,j) = tmpv(j); 
            end
            featureVec(i-2,fn+1) = red_val;
        end
    end
    % featureVec(no*fn+1) = red_val;
    % featureVec(end) = red_val;
    % featureVec

    runn = featureVec;