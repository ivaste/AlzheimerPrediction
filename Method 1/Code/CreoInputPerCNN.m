function [DATA,tmpTR,label,labelID,ID]=CreoInputPerCNN(IMG,DATA,tmpTR,classe,label,labelID,ID,siz)

IMG(find(isnan(IMG)))=0;%elimino i NaN
clear RID
%creo immagine prendendo 3 livelli della risonanza, escludiamo i primi
%e gli ultimi (livelli pressochè con tutti valori ==0)
for livello=11:110
    RID(:,:,1,livello-10)=imresize(IMG(:,:,livello),[siz(1) siz(2)]);
    RID(:,:,2,livello-10)=imresize(IMG(:,:,livello),[siz(1) siz(2)]);
    RID(:,:,3,livello-10)=imresize(IMG(:,:,livello),[siz(1) siz(2)]);
end
%semplice normalizzazione valori
M=max(RID(:));
RID=floor(RID.*(255/M));

DATA(:,:,:,tmpTR:tmpTR+size(RID,4)-1)=uint8(RID); %inserisco il tutto in DATA
label(tmpTR:tmpTR+size(RID,4)-1)=classe;%etichetta - classe della risonanza
labelID(tmpTR:tmpTR+size(RID,4)-1)=ID; %id dell'individuo
ID=ID+1;
tmpTR=tmpTR+size(RID,4);