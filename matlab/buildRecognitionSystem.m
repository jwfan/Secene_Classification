function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');
    
	% TODO create train_features
    train_matnames=strrep(train_imagenames,'.jpg','.mat');
    T=length(train_matnames);
    K=length(dictionary);
    L=2;
    Row=K*(power(4,L+1)-1)/3;
    train_features=zeros(Row,T);
    for i=1:T
        load(train_matnames{i});
        train_features(:,i)=getImageFeaturesSPM(L+1,wordMap,K);
    end
	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end