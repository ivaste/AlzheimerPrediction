clear all
warning off

siz=[224 224]; %size chiesta in input da CNN

%problema: (CN-vs-MCIc)
load indices_CN-vs-MCIc.mat
load CN.mat
tmpTR=1;
ID=1;
labelID=[];%memorizzo id di ogni persona
label=[];%memorizzo classe di ogni pattern
DATA=[];%salvo i vari pattern

%per tutte le risonanze
classe=1;
for mri=1:length(CN_training)
    IMG=CN_training{mri};%estraggo la singola risonanza
    [DATA,tmpTR,label,labelID,ID]=CreoInputPerCNN(IMG,DATA,tmpTR,classe,label,labelID,ID,siz);%funzione per creare dataset per addestrare CNN
end
clear CN_training
for fold=1:length(CN_testing)
    IMG=CN_testing{fold};
    [DATA,tmpTR,label,labelID,ID]=CreoInputPerCNN(IMG,DATA,tmpTR,classe,label,labelID,ID,siz);%funzione per creare dataset per addestrare CNN
end
clear CN_testing

load MCIc.mat
classe=2;
for fold=1:length(MCIc_training)
    IMG=MCIc_training{fold};
    [DATA,tmpTR,label,labelID,ID]=CreoInputPerCNN(IMG,DATA,tmpTR,classe,label,labelID,ID,siz);%funzione per creare dataset per addestrare CNN
end
clear MCIc_training
for fold=1:length(MCIc_testing)
    IMG=MCIc_testing{fold};
    [DATA,tmpTR,label,labelID,ID]=CreoInputPerCNN(IMG,DATA,tmpTR,classe,label,labelID,ID,siz);%funzione per creare dataset per addestrare CNN
end
clear MCIc_testing


