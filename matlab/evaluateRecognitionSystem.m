function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix
% TODO Implement your code here
	load('vision.mat');
	load('../data/traintest.mat');
    C=zeros(8,8);
    testnum=length(test_imagenames);
    for i=1:testnum
        image = im2double(imread(['../data/',test_imagenames{i}]));
        wordMap = getVisualWords(image, filterBank, dictionary);
        h = getImageFeaturesSPM(3, wordMap, size(dictionary,2));
        distances = distanceToSet(h, train_features);
        [~,nnI] = max(distances);
        C(test_labels(i),train_labels(nnI))=C(test_labels(i),train_labels(nnI))+1;
    end
    conf=trace(C)/sum(C(:));

end