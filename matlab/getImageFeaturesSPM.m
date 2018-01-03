function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
    [m,n]=size(wordMap);
    len=power(2,layerNum-1);
    pyramid=cell(layerNum,1);
    pyramid{1}=zeros(len,len,dictionarySize);
    % Compute the finest histogram
    for i=1:len
        for j=1:len
            x_lo=floor(m/len*(i-1))+1;
            x_hi=floor(m/len*i);
            y_lo=floor(n/len*(j-1))+1;
            y_hi=floor(n/len*j);
            cells=wordMap(x_lo:x_hi,y_lo:y_hi);
            pyramid{1}(i,j,:)=sum(hist(cells,1:dictionarySize),2)./(m*n);
        end
    end
    
    % Compute the coarse levels histogram from finest level
    len=len/2;
    for l=2:layerNum
        pyramid{l}=zeros(len,len,dictionarySize);
        for i=1:len
            for j=1:len
            pyramid{l}(i,j,:)=pyramid{l-1}(2*i-1,2*j-1,:)+pyramid{l-1}(2*i,2*j-1,:)+pyramid{l-1}(2*i-1,2*j,:)+pyramid{l-1}(2*i,2*j,:);
            end
        end
        len=len/2;
    end
    
    % Weight all the histogram
    h=[];
    for i=1:layerNum-1
        h=[h pyramid{i}(:)' .* power(2,-i)];
    end
    h=[h pyramid{layerNum}(:)' .* power(2,-(layerNum-1))]';
end