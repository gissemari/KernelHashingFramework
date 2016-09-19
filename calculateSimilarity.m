% Generates the kernel matrix K that  should be square
function [K newSigma] = calculateSimilarity(TSdatasetX, TSdatasetY, timeSteps, sigma)
    
    m1 = size(TSdatasetX,3);
    m2 = size(TSdatasetY,3);
    K = zeros(m1,m2);
    
    %%%%%%%%% Normalize
    distanceMeasure = 0;
    
    for i=1:m1
        for j=1:m2
            %%% what about i=j diagonals 0, do they have inverse?
            itera = strcat(num2str(i),'-',num2str(j));
            Xorig = TSdatasetX(:,:,i);
            Yorig = TSdatasetY(:,:,j);
            %X = zscore(Xorig',1);
            %Y = zscore(Yorig',1);
            %%%%%%%%%%%% NORMALIZING
            minVec = repmat(min(Xorig,[],2),1,size(Xorig,2));
            divVec1 = max(Xorig,[],2) - min(Xorig,[],2);
            
            divVec1(divVec1==0)=1;
            
            divVec = repmat(divVec1,1, size(Xorig,2)) ;
            
            X = (Xorig-minVec)./(divVec);
            
            minVec = repmat(min(Yorig,[],2),1,size(Yorig,2));
            divVec1 = max(Yorig,[],2) - min(Yorig,[],2);
            
            divVec1(divVec1==0)=1;
            divVec = repmat(divVec1,1, size(Yorig,2)) ;
            Y = (Yorig-minVec)./(divVec);

            %X = (X-mean(X))./std(X,1);%zscore(TSdataset(:,:,i));
            %Y = (Y-mean(Y))./std(Y,1);%zscore(TSdataset(:,:,j));
            switch distanceMeasure
                case 0 
                    K(i,j) = MDWT(X,Y, timeSteps);
                    
                case 1 
                    K(i,j) = GAK(X,Y,timeSteps);
            end
            %disp(strcat(itera,':',num2str(K(i,j))));
        end
       % K(i,:)
    end
    %%%%%% take into account the zeros added and should't be averaged or
%%%%%% included in the median
% wrong: allDistances = reshape(K,1,m1*m2); sigma = median(allDistances);
% sigma is calculated per row

    if  (sigma ==0)
        allDistances = reshape(K,1,m1*m2);
        %sigma = median(K,2); %%%%%%% ?? or VARIANCE or dimension 2  
        sigma = median(allDistances);
    end
    disp('sigma');
    size(sigma)
    sigma
    size(K);
    %K = -K./repmat(2*sigma,m1,m2);
    K = -K./sigma;
    K = exp(K);
    newSigma = sigma;
end