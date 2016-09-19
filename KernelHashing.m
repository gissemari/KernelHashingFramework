%The actual way to define size of 3D array. Change??
%   1st dimension: row=#of dimensions
%   2nd dimension: T = # of steps or time points
%   3rd dimension: training set size


dim1 = 22;
dim2 = 100;
%dim3 = 42;
%TSdataset = zeros(dim1,dim2,dim3);

arrWords = {'alive', 'all','answer','boy','building','buy','cold'
    };
rangeFolders = [4 2];

B = 15;

TSdataset = readFiles(arrWords, rangeFolders, dim2);
dim3 = size(TSdataset,3);

for i=[1,7,13]
    figure();
    plot(TSdataset(:,:,i)');
end

nTS = size(TSdataset,3); % Remember the range of the indes from 1 to nTS
%%%%%%% Also remember thatit might need to me sorted randomly %%%%%%%
[TStraining, TStest] = separateDataset(TSdataset);

m = dim3; %%%%%%% Really sqrt of N or number of TS
sigma = 0;
[K sigma] = calculateSimilarity(TSdataset, TSdataset,dim2,sigma); %%%%%% PASS TRAINING LATER
sigma
K
Kinv = mpower(inv(K),0.5);
%Kinv2 = mpower(K,-0.5)
ej = randi([0 1],m,1);
size(Kinv)
size(ej)
w = zeros(B,m);
for j=1:B
    ej = randi([0 1],m,1);
    w(j,:) = Kinv*ej ; %%%%%%%%%%% . or .*
end
%%%Kinv is the kernel matrix

H= hashCode(K, w, B)
 %% sth weir is happening because H always get positive or negatives in the same positions
%%%% for test build a new Kinv of dimensions 1xM

rangeFolders = 1;
arrWords = {'alive'};
TSdatasetTest = readFiles(arrWords, rangeFolders, dim2);

for i=1:2
    figure();
    plot(TSdataset(:,:,i)');
end

[Ktest sigma] = calculateSimilarity(TSdatasetTest, TSdataset, dim2,sigma);
Ktest
Htest = hashCode (Ktest,w,B);
Htest
size(H)
size(Htest)
[val IDX] = knnsearch(H, Htest)


