function dataset = readFiles(arrWords,rangeFolders, timeSteps)
    nTS = 1;
    for i=1:length(arrWords)
        currentWord=arrWords{i};
        for j=rangeFolders
            for k=1:3 % Just 3 instances per day
                myFileName = strcat('tctodd/tctodd',num2str(j),'/',currentWord,'-',num2str(k),'.tsd');
                t = load(myFileName);
                size(t);
                % Realize that TIME dimension could be less than the fixed one, so
                % add zeros
                columnZeros = timeSteps - size(t,1);
                matrixZeros = zeros(columnZeros,size(t,2));
                dataset(:,:,nTS) = [t;matrixZeros].';
                nTS = nTS + 1;
            end
        end
    end
    
end