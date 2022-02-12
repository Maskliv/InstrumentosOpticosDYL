function Siemens_star()
% Matlab source code for creating your own star
% Siemens Star
% Hans Strasburger, June 2018

number_of_spikes = 40;					% fill in as you wish
radius = 10;							% Siemens star radius

axis equal								% 1:1 aspect ratio
axis off								% but no frame
hold on                     			% fill graph one by one

% Define points along the circumference

theta=-pi:2*pi/number_of_spikes:pi;		% theta is a vector of angles
x = radius * cos(theta);				% a vector of points along the outer circumference
y = radius * sin(theta);				%       "

% Draw triangular spikes; leave every 2nd spike white
for k = 1 : (number_of_spikes/2)		% k goes from 1 to the number of endpoints along the circle

% A spike has 4 vertices, the first and last one ix`n the center, so the vectors X, Y, have length 4

X = [0 x(2*k-1) x(2*k) 0]
Y = [0 y(2*k-1) y(2*k) 0]
C = 'black'

p = patch(X, Y, C, 'EdgeColor','none')  % draws the spike (with no edge), using the 'patch' function

end                                 	% end of for loop

% Save the resulting Siemens star in vector graphics format to work properly (svg, eps, etc.)
% To do so, export figure from the pop-up menu appropriately
saveas(gcf,'myfigure.pdf')
% End of script