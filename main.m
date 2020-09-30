%% clean up the workspace and getthe image sequence desired to track
close all 
clear all
clc

%open up the pathway to file and set as the input

[FileName, FilePath] = uigetfile('*');
input_image = imread(strcat(FilePath,FileName));
imshow(input_image);
trueSize = ([500,500]);
[height, width, numColors]=size(input_image);
cherrypick = 10;
%% Cherrypick the points that we will be tracking
pixels = zeros(cherrypick, 2);
for i=1:cherrypick
    [pixels(i,2), pixels(i,1)] = (ginput(1));
    pixels(i,1) = uint32(pixels(i,1));
    pixels(i,2) = uint32(pixels(i,2));
    
end

%% Now the image must be prepared to be ran through the Lucas Kanade

if( numColors == 1)
    gray_image = input_image;
    rgb_image = repmat(gray_image, [1 1 3]);
    rgb_image = cat(3, gray_image, gray_image, gray_image);
else
    rgb_image = input_image;
end

%% Now we want to display the markers for the user to see


[rgb_image] = place_markers(rgb_image, pixels);%%%Write place markers algorithm
figure;
imshow(rgb_image);
%title('Markers Placed')
truesize([500 500]);


tryimgs = 0;
imgnum = 0588;
I = double(input_image); %try rgb_image if not working
window = 11;
%% Call to the Lucas Kanade function will preform the tracking
[G, W] = Gaussian(.6);
while(1)
    Jin = imread(sprintf('statue_seq/img0%d.bmp', imgnum));
    J = Jin;
    %For better accuracy can try to smooth the image with a gaussian blur
    
    Jinter = convolve(I, G);
    J = convolve(I,G);
    Jinter = convolve(J, G);
    J = convolve(J,G);
    
    J = double(J);
    
    imshow(rgb_image);
    truesize([500,500]);
    title('I Frame');
    [rgb_image] = place_markers(rgb_image, pixels);
    h = msgbox('Next Frame?');
    waitfor(h);
        %now run the Lucas Kanade to update the pixels and loop through the
        %features
    [pixels] = Lucas_Kanade(I, J, pixels, window);
    %pixels = floor(pixels)
    gray_image = uint8(Jin);
    rgb_image = repmat(gray_image, [1 1 3]);
    rgb_image = cat(3, gray_image, gray_image, gray_image);
    I= J;
    imgnum = imgnum+1;

end


