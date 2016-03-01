% detectAndTrackFaces
% Automatically detects and tracks multiple faces in a webcam-acquired
% video stream.
%
% Copyright 2013-2014 The MathWorks, Inc 

% This is a simple system for detecting and tracking multiple faces from live 
% video. It uses the Computer Vision System Toolbox and the Webcam Support 
% Package. The system detects faces using the Viola-Jones algorithm, 
% detects min-eigen corners within each 
% face's bounding box, and tracks the corners using the Kanade-Lucas-Tomasi (KLT) 
% algorithm. It re-detects the faces every 10 frames in order to correct the tracker 
% and replenish the points.

close all
clear;
clc;

% Instantiate video device, face detector, and KLT object tracker
% vidObj = webcam;

addpath(genpath( '/Users/zijunwei/Dev/ZFunc'));

dataDir='/Users/zijunwei/Dev/CVPR2016Kiwon/data/msr_image';
listofVideos=z_getFileIdsfromDir(dataDir,[],true);


% this is a for loop
% for i=1:1:length(listofVideos)
%    imgDir=fullfile(dataDir,listofVideos{i});
%    imgs=z_getFileIdsfromDir(imgDir,'.png');
%    
%    if length(imgs)<5
%       continue; 
%    end
%    
%    detectAndTrackFaces_fun(imgDir,imgs,'.png');
%     
% end


   imgDir=fullfile(dataDir,'_sJ_09Mf1HY_49_72');
   imgs=z_getFileIdsfromDir(imgDir,'.png');
   

   detectAndTrackFaces_fun(imgDir,imgs,'.png');
    

