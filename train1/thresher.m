function thresh = threshold(value, ThreshHigh, ThreshLow)
[height, width,rgb] = size(value);
output = zeros(height, width);
for row = 1 : height
	for col = 1 : width
		for r=1 : rgb
			if value(row,col) < ThreshHigh ... % inside high bnd
			& value(row,col) > ThreshLow %low bnd
				output(row,col,r) = 1;
			else
				output(row,col,r) = 0;
			end
		end
	end
end
thresh = output;