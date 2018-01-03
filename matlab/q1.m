clc;
clear all;
%Q1.1
[filterBank] = createFilterBank();
image=imread('data/auditorium/sun_ahcmaddzrcfxzuuz.jpg');
if(length(size(image))<3)
    image=repmat(image,1,1,3);
end
[filterResponses] = extractFilterResponses(image,filterBank);
m=cat(4,filterResponses{:});
montage(m,'Size',[4 5]);

%Q1.2
