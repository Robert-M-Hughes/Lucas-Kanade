function [rgb_image] = place_markers(rgb_image, pixels)
%PLACE_MARKERS will be used to place the markers that were chosen/being
%tracked to be marked on the image

[height, width] = size(pixels);
%rgb_image = insertMarker(RGB,pos,'x','color',color,'size',10);  would use
%but it requires the Computer Vision Toolbox not sure of availability

for i = 1: height

    hold on
    x = pixels(i,1);
    y = pixels(i,2);
    plot(y,x, 'r*')
end
%{
figure;
imshow(rgb_image);
title('Marker Locations')
%}
end

