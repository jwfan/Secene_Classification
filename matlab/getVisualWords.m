function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
    if(length(size(img))<3)
            img=repmat(img,1,1,3);
    end
    [m,n,~]=size(img);
    lab=rgb2lab(img);
    temp=reshape(lab,m*n,3);
    [~,I]=pdist2(dictionary',temp,'Euclidean','Smallest',1);
    wordMap=reshape(I,m,n);
   
