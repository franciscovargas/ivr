% FOR NORMALIZED RGB ONE COLOR CHANNEL ONLY (SHOULD WORK IF NOT NORMALIZED)
% find a threshold from a histogram by smoothing with a gaussian with
% standard deviation sigma and find the low valley location
% sizeparam should be at least 4, with larger giving less smoothing
function thresh = findthresh(thehist, edges,sizeparam,show)

  [len,x] = size(thehist);

  % convolve with a gaussian smoothing window here
  filterlen = sizeparam;                               % filter length
  thefilter = fspecial('gaussian',[1,sizeparam],6);
  thefilter = thefilter/sum(thefilter);                  % normalize
  tmp2=conv(thefilter,thehist);   


  tmp2           
  tmp1=tmp2    % select corresponding portion
  if show > 0
     figure(show)
     clf
     plot(edges, tmp1(1:x))
  end

  % find largest peak
  max(tmp1)
  peak = find(tmp1 == max(tmp1));
  tmp1(peak)
  
  % find highest peak to left
  xmaxl = -1;
  pkl = -1;
  for i = 2 : peak-1
    if tmp1(i-1) < tmp1(i) & tmp1(i) >= tmp1(i+1)
      if tmp1(i) > xmaxl
        xmaxl = tmp1(i);
        pkl = i;
      end 
    end
  end
  if pkl == -1
    pkl = 1;
    xmaxl = 1;
  end
%    [pkl,xmaxl]

  % find deepest valley between peaks
  xminl = max(tmp1)+1;
  vall = -1;
  for i = pkl+1 : peak-1
    if tmp1(i-1) > tmp1(i) & tmp1(i) <= tmp1(i+1)
      if tmp1(i) < xminl
        xminl = tmp1(i);
        vall = i;
      end
    end
  end
  if vall == -1
    vall = 2;
    xminl = 2;
  end
%    [vall,xminl]

  % find highest peak to right
  xmaxr = -1;
  pkr = -1;
  for i = peak+1 : x-1
    if tmp1(i-1) < tmp1(i) & tmp1(i) >= tmp1(i+1)
      if tmp1(i) > xmaxr
        xmaxr = tmp1(i);
        pkr = i;
      end 
    end
  end
  if pkr == -1
    disp('FOUND');
    pkr = len;
    xmaxr = 1;
  end
%    [pkr,xmaxr]
  pkr
  peak

  % find deepest valley between peaks
  xminr = max(tmp1)+1;
  valr = -1;
  for i = peak+1 : pkr-1
    if tmp1(i-1) > tmp1(i) & tmp1(i) <= tmp1(i+1)
      if tmp1(i) < xminr
        xminr = tmp1(i);
        valr = i;
      end
    end
  end
  if valr == -1
    valr = len-1;
    xminr = 2;
  end
%    [valr,xminr]
  valr
  % find lowest point between peaks
  if xmaxr > xmaxl
      thresh = valr;
  else
      % thresh = vall;
      thresh = valr;
  end


  thresh = edges(thresh-1);    % subtract 1 as histogram bin 1 is for value 0
