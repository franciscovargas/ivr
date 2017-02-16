% computes the histogram of a given image into num bins.
% values less than 0 go into bin 1, values bigger than 255
% go into bin 255
% if show=0, then don't show. Otherwise show in figure(show)
function thehistrgb = dohist(theimage,show)

  % set up bin edges for histogram
  edges = linspace(0,1,255);
  % edges

  [R,C] = size(theimage);
  imagevec = reshape(theimage,1,R*C);      % turn image into long array
  % imagevec
  thehist = histc(imagevec,edges);        % do histogram
  % thehist
  if show > 0
      plot(edges,thehist)
  end
  thehistrgb = 1;
  pro.edges =edges;
  pro.hist = thehist;
  thehistrgb = pro;
