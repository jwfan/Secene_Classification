function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


% TODO Implement your code here
image_d=im2double(img);
il=RGB2Lab(image_d);
% Generate filter response
N=length(filterBank);
filterResponses=cell(N,1);
idx=0;
for i=1:1:N
    idx=idx+1;
    filterResponses{idx}=imfilter(il,filterBank{i},'replicate','same','conv');
end
