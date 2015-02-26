% FOR NORMALIZED RGB ONE COLOR CHANNEL ONLY (SHOULD WORK IF NOT NORMALIZED)
% find a threshold from a histogram by smoothing with a gaussian with
% standard deviation sigma and find the low valley location
% sizeparam should be at least 4, with larger giving less smoothing

function thresh = findthresh(thehist, edges,sizeparam,show)

    [none, len] = size(thehist);

    % Convolve with a gaussian smoothing window here
    filterlen = sizeparam;                                % Filter length
    thefilter = fspecial('gaussian', [1, sizeparam], 6);
    thefilter = thefilter / sum(thefilter);               % Normalise
    tmp2 = conv(thefilter, thehist);

    tmp1 = tmp2;    % Select corresponding portion
    if show > 0
        figure
        clf
        plot(edges, tmp1(1 : len))
    end

    % Find largest peak
    max(tmp1);
    peak = find(tmp1 == max(tmp1));
    tmp1(peak);
    
    % Find first peak to the left
    xmaxl = -1;
    pkl = -1;
    for i = 2 : peak - 1
        if tmp1(i-1) < tmp1(i) & tmp1(i) >= tmp1(i+1) & tmp1(i) > 100
            xmaxl = tmp1(i);
            pkl = i;
            break;
        end
    end
    if pkl == -1
        pkl = 1;
        xmaxl = 1;
    end

    % Find deepest valley between peaks
    xminl = max(tmp1) + 1;
    vall = -1;
    for i = pkl + 1 : peak - 1
        if tmp1(i-1) > tmp1(i) & tmp1(i) <= tmp1(i+1)
            xminl = tmp1(i);
            vall = i;
            break;
        end
    end
    if vall == -1
        vall = 2;
        xminl = 2;
    end

    % Lowest point between peaks    `   % TODO Remove
    % thresh = vall;

    % Return intensity value for the deepest valley
    thresh = edges(vall);
