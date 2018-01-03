function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    % TODO Implement your code here
    % Generate filterBank
    filterBank  = createFilterBank();
    l=length(filterBank);
    % ¦Á random pixels
    a=100;
    % K clustering center
    K=150;
    T=length(imPaths);
    frsample=zeros(a*l,3);
    X=[];
    for i=1:1:T
        im=imread(imPaths{i});
        if(length(size(im))<3)
            im=repmat(im,1,1,3);
        end
        % Calculate filter responses
        [fr] = extractFilterResponses(im,filterBank);
        [m,n,~]=size(im);
        % Pick ¦Á random pixels
        row=randperm(m,a);
        col=randperm(n,a);
        for j=1:1:l
            for x=1:1:a
            frsample(x+(j-1)*a,:)=fr{j}(row(x),col(x),:);
            end
        end
        X=[X;frsample];
    end
    
    [~,dictionary]=kmeans(X,K,'EmptyAction','drop');
    dictionary=dictionary';
end
