%Exhaustive search, think about other method if TIME is compared
function [val IDX] = knnsearch(X,Y)
    for i=1:size(Y,1)
        for j=1:size(X,1)
            sum = 0;
            for k=1:size(X,2)
                sum = sum + (Y(i,k)-X(j,k))^2;
            end
            allDistances(i,j) = sum;
        end
    end
    allDistances
    [val IDX] = min(allDistances,[],2);
end