%The actual way to define size of 3D array. Change??
%   1st dimension: row=#of dimensions
%   2nd dimension: T = # of steps or time points
%   3rd dimension: training set size


dim1 = 22;
dim2 = 100;
dim3 = 30;
TSdataset = zeros(dim1,dim2,dim3);

arrWords = {'alive', 'all','answer','boy','building'};
rangeFolders = [1 2];
B = 10;

TSdataset = readFiles(arrWords, rangeFolders, dim2);

nTS = size(TSdataset,3) % Remember the range of the indes from 1 to nTS
%%%%%%% Also remember thatit might need to me sorted randomly %%%%%%%
[TStraining, TStest] = separateDataset(TSdataset);

m = dim3; %%%%%%% Really sqrt of N or number of TS

Kinv = calculateWeight(nTS, TSdataset,dim2, m); %%%%%% PASS TRAINING LATER

w = zeros(B,m);
for j=1:B
    ej = randi([0 1],m,1);
    w(j,:) =  Kinv*ej ;
end
w
%%%Kinv is the kernel matrix
H= hashCode(Kinv, w, B);
H; %% sth weir is happening because H always get positive or negatives in the same positions
%%%% for test build a new Kinv of dimensions 1xM

