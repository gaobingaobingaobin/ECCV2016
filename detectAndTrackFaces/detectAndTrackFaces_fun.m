function detectAndTrackFaces_fun(imgDir, imgList,imgFmt)


faceDetector = vision.CascadeObjectDetector(); % Finds faces by default
tracker = MultiObjectTrackerKLT;

% Get a frame for frame-size information
frame = imread(fullfile(imgDir,[imgList{1},imgFmt]));
frameSize = size(frame);

% Create a video player instance
videoPlayer  = vision.VideoPlayer('Position',[200 100 fliplr(frameSize(1:2)+30)]);

% Iterate until we have successfully detected a face
bboxes = [];
for idx=1:1:length(imgList);
    
    framergb = imread(fullfile(imgDir,[imgList{idx},imgFmt]));
    frame = rgb2gray(framergb);
    bboxes = faceDetector.step(frame);
    if ~isempty(bboxes)
        break;
    end
end

tracker.addDetections(frame, bboxes);

% And loop until the player is closed
frameNumber = 0;
% keepRunning = true;
disp('Press Ctrl-C to exit...');
% while keepRunning
for idx=idx:1:length(imgList)
    framergb =imread(fullfile(imgDir,[imgList{idx},imgFmt]));
    frame = rgb2gray(framergb);
    
    if mod(frameNumber, 10) == 0
        % (Re)detect faces.
        %
        % NOTE: face detection is more expensive than imresize; we can
        % speed up the implementation by reacquiring faces using a
        % downsampled frame:
        % bboxes = faceDetector.step(frame);
%         bboxes = 2 * faceDetector.step(imresize(frame, 0.5));
                bboxes = faceDetector.step((frame));

        if ~isempty(bboxes)
            tracker.addDetections(frame, bboxes);
        end
    else
        % Track faces
        tracker.track(frame);
    end
    
    % Display bounding boxes and tracked points.
    displayFrame = insertObjectAnnotation(framergb, 'rectangle',...
        tracker.Bboxes, tracker.BoxIds);
    displayFrame = insertMarker(displayFrame, tracker.Points);
    videoPlayer.step(displayFrame);
    
    frameNumber = frameNumber + 1;
end

% Clean up
release(videoPlayer);