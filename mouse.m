clear, clc, close all
% read the movie
mov=VideoReader('EYEBLINKSAMPLE.mp4');
vidFrames=read(mov);
nFrames=mov.NumberOfFrames;
% implay('EYEBLINKSAMPLE.mp4');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1st attempt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mov=VideoReader('EYEBLINKSAMPLE.mp4');
%%
darkMouse = rgb2gray(read(mov,13));

darkValue = 160; %fiddle around
frameHist = imextendedmax(darkMouse, darkValue);
complement = imcomplement(frameHist);

imshow(darkMouse)
figure, imshow(frameHist)
figure, imshow(complement)
%% Video with image manipulation
darkValue = 160;
for k = 1 : 1000
    singleframe = rgb2gray(read(mov,k));
    singleframe = imextendedmax(singleframe, 160);
    singleframe = imcomplement(singleframe);
    decimated(:,:,:,k) = singleframe;
end
framerate = get(mov, 'FrameRate');
implay(decimated, framerate);
%% with histogram equalization frame10 example
mouseFrame = rgb2gray(read(mov,10));
mouseHist = histeq(mouseFrame,128); %% 64 default grayscale levels
figure; imshow(mouseFrame);
figure; imshow(mouseHist);
figure; imhist(mouseFrame);
mHistogram = imhist(mouseHist)
figure; imhist(mouseHist)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Second Attempt, histogram eq
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
darkValue = 185; %% 
frameHist = imextendedmax(mouseHist, darkValue);
complement = imcomplement(frameHist);

imshow(darkMouse)
figure, imshow(complement)
%% Morphing
sedisk = strel('disk', 4);
noSmallStructures = imopen(complement, sedisk);

imshow(darkMouse)
subplot(211); imshow(frameHist)
subplot(212); imshow(noSmallStructures)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Video #2

darkValue = 200;
for k = 1 : 500
    singleframe = rgb2gray(read(mov,k));
    singleframe = histeq(singleframe);
    singleframe = imextendedmax(singleframe, darkValue);
    singleframe = imcomplement(singleframe);
    decimated_hist64(:,:,:,k) = singleframe;
end
framerate = get(mov, 'FrameRate');
implay(decimated_hist64, framerate);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Attempt 3 with morphing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

darkValue = 200;
sedisk = strel('disk', 4);

for k = 1 : 500
    singleframe = rgb2gray(read(mov,k));
    singleframe = histeq(singleframe);
    singleframe = imextendedmax(singleframe, darkValue);
    singleframe = imcomplement(singleframe);
    noSmallStructures = imopen(singleframe, sedisk);
    decimated_morph64(:,:,:,k) = noSmallStructures;
end
framerate = get(mov, 'FrameRate');
implay(decimated_morph64, framerate);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Attempt 4: lower threshold-190
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
darkValue = 190;
sedisk = strel('disk', 4);

for k = 1 : 500
    singleframe = rgb2gray(read(mov,k));
    singleframe = histeq(singleframe);
    singleframe = imextendedmax(singleframe, darkValue);
    singleframe = imcomplement(singleframe);
    noSmallStructures = imopen(singleframe, sedisk);
    decimated_t190(:,:,:,k) = noSmallStructures;
end
framerate = get(mov, 'FrameRate');
implay(decimated_t190, framerate);

%%Contrast issues - localize the frame.