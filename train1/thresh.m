function thresh = threshold(value)
%{
The following parameters were
extracted by inspecting the
gray scale hist (this is silly)
and playing around with values
None norm good params:
	red: 128, 164
	green: 150, 164
	blue: 150, 164

Following settings were extracted
by examining the histogram of each 
collor channel and choosing values
accordingly
Normed good params:
	red: 0.513, 0.572
	green: 0.549, 0.612
	blue: 0.525. 0.529
	
%}
[height, width, color] = size(value);
output = zeros(height, width,3);
for row = 1 : height
	for col = 1 : width
		if value(row,col,1) < 1 ... % inside high bnd
		& value(row,col,1) > 0.505 % optional low bnd
			output(row,col,1) = 1;
		else
			output(row,col,1) = 0;
		end
	end
end

for row = 1 : height
	for col = 1 : width
		if value(row,col,2) < 1 ... % inside high bnd
		& value(row,col,2) > 0.549% optional low bnd
			output(row,col,2) = 1;
		else
			output(row,col,2) = 0;
		end
	end
end


for row = 1 : height
	for col = 1 : width
		if value(row,col,3) < 1 ... % inside high bnd
		& value(row,col,3) > 0.525 % optional low bnd
			output(row,col,3) = 1;
		else
			output(row,col,3) = 0;
		end
	end
end
thresh = output(:,:,3) | output(:,:,1) | output(:,:,2);