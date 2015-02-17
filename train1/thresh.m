function thresh = threshold(value)
[height, width, color] = size(value);
output = zeros(height, width,3);
for row = 1 : height
	for col = 1 : width
		if value(row,col,1) < 164 ... % inside high bnd
		& value(row,col,1) > 128 % optional low bnd
			output(row,col,1) = 1;
		else
			output(row,col,1) = 0;
		end
	end
end

for row = 1 : height
	for col = 1 : width
		if value(row,col,2) < 164 ... % inside high bnd
		& value(row,col,2) > 150 % optional low bnd
			output(row,col,2) = 1;
		else
			output(row,col,2) = 0;
		end
	end
end


for row = 1 : height
	for col = 1 : width
		if value(row,col,3) < 164 ... % inside high bnd
		& value(row,col,3) > 150 % optional low bnd
			output(row,col,3) = 1;
		else
			output(row,col,3) = 0;
		end
	end
end
thresh = output(:,:,3) | output(:,:,1) | output(:,:,2);