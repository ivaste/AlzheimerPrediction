%Training CN vc MCIc
% This code is for ONE FOLD ONLY and has to be modified to perfom 20-fold Validation and Data Augmentation

%{ 
- Define the network
- Set training parameters
- Load the Dataset:
    - Load .mat files
    - Concatenate CN_training, CN_testing,... in a single cell array
    - Transform the 238 MRI images into 23800 227x227x3 images (~30GB)
    - Data Augmentation (!!!TODO!!!)
- Cross Fold Validation (for 20 folds):
    - Find patterns to use for Testing (index==fold) and Training (index!=fold)
      Split the dataset in Training and Testing for this fold
    - Shuffle the trainingImages (and  their labels, respectively)
    - Train
    - Save the trained model
    - Validate on test set
    - Compute Metrics
%}

clear all
warning off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Define the network
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

siz=[227 227]; % input size of the CNN (AlexNet)

net = alexnet;
layers=net.Layers; % saving layers
layers(end-2)=fullyConnectedLayer(2,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20);
layers(end-1)=softmaxLayer;
layers(end)=classificationLayer;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Set training parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
miniBatchSize = 30;
learningRate = 1e-4;
optimizer='sgdm';
options=trainingOptions(optimizer,...
    "MiniBatchSize",miniBatchSize,...
    "InitialLearnRate",learningRate,...
    'MaxEpochs',30,...
    "Verbose",false,...
    "Plots","training-progress");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Load the Dataset %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load CN.mat and MCIc.mat
%Concatenate CN_training, CN_testing, MCIc_training, MCIc_testing in a single cell array
load CN.mat
load MCIc.mat
dataset=cat(1,CN_training,CN_testing,MCIc_training,MCIc_testing);

% Create label array
lengthClass1=(length(CN_training)+length(CN_testing));
lengthClass2=(length(MCIc_training)+length(MCIc_testing));
trainingLabel(1:lengthClass1)=1; %Cognitive Normal = 1
trainingLabel(lengthClass1:lengthClass1+lengthClass2)=2;

clear CN_training CN_testing MCIc_training MCIc_testing lengthClass1 lengthClass2

% Transform the 238 MRI images into 23800 227x227x3 images
Images=[];
label=[]; % labels of classes 
labelID=[]; % labels of ID
tmpTR=1;
for i=1:length(dataset)
    % Extract single MRI
    IMG=trainingData{i};

    % Transform MRI picture into one hundred 227x227x3 images 
    IMG=mriToCNN(IMG,siz);
    Images(:,:,:,tmpTR:tmpTR+size(IMG,4)-1)=IMG;

    % Return label vector with labels of the new 100 pictures
    class=trainingLabel(i);
    label(tmpTR:tmpTR+size(IMG,4)-1)=class;

    % Saving single person's ID
    labelID(tmpTR:tmpTR+size(IMG,4)-1)=i;

    tmpTR=tmpTR+size(IMG,4); %Increasing counter by 100

    clear IMG;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Cross fold validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%for fold=1:20
    %the whole code below will be executed inside here
%end

fold=3; %just for now we train on 1 single fold

% Find patterns we will use for Testing (Indices==fold) and Training (Indices!=fold)
% Split the dataset in Training and Testing for this fold
load indices_CN-vs-MCIc.mat

trainingImages=Images(Indices~=fold);
trainingLabel=label(Indices~=fold);
trainingID=labelID(Indices~=fold);

testImages=Images(Indices==fold);
testLabel=label(Indices==fold);
testID=labelID(Indices==fold);

% Shuffle the trainingImages: because we have a long series of image of class 1
% followed by a long series of images of class 2.
indicesVector=[1:length(trainingImages)]; % Containg indices from 1 to trainingImages length (~22800)
indicesVector=indicesVector(randperm(length(indicesVector))); % Shuffle vector of indices

trainingImages=trainingImages(indicesVector);
trainingLabel=trainingLabel(indicesVector);
trainingID=trainingID(indicesVector);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Train
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
valueset = [1:2];
Y=categorical(trainingLabel',valueset);

[trainedNet,info]=trainNetwork(trainingImages,Y,layers,options);

% Save the trained model
save("trainedModel"+fold+".mat", "trainedNet");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

predictions = classify(trainedNet,testImages);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Metrics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
predictions=double(predictions);

TP= sum(and((predictions==2)',testLabel==2))
TN= sum(and((predictions==1)',testLabel==1))
FP= sum(and((predictions==2)',testLabel==1))
FN= sum(and((predictions==1)',testLabel==2))

precision(fold)= TP/(TP+FP)
recall(fold)=TP/(TP+FN)
f1(fold)=2*(precision*recall)/(precision+recall)
specificity(fold)=FP/(FP+TN)
accuracy(fold)=(TP+TN)/(TP+TN+FP+FN)

%accuracy = sum(predictions' == testLabel)/numel(testLabel)

confusionchart(testLabel,predictions)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Function that Transform 1 MRI image in 100 227x227x3 pictures
function [IMG]=mriToCNN(IMG,siz) 
    % Removing NaN values
    IMG(find(isnan(IMG)))=0;
    
    % Creating 100 227x227x3 pictures
    % Resizing each 121x145 slice to 227x227
    % Excluding the first and the last 10 layers because are almost completely made up of zeroes
    clear RID
    for livello=11:110
        RID(:,:,1,livello-10)=imresize(IMG(:,:,livello),[siz(1) siz(2)]);
        RID(:,:,2,livello-10)=imresize(IMG(:,:,livello),[siz(1) siz(2)]);
        RID(:,:,3,livello-10)=imresize(IMG(:,:,livello),[siz(1) siz(2)]);
    end
    
    clear IMG
    
    % Normalizing values <--------------------------------- TODO: find a better normalization
    M=max(RID(:));
    IMG=floor(RID.*(255/M));
end