function Kinv = calculateWeight(nTS,TSdataset, timeSteps , m)
    
    K = zeros(m,m);
    
    %%%%%%%%% Normalize
    distanceMeasure = 0;
    
    for i=1:m
        for j=1:m
            %%% what about i=j diagonals 0, do they have inverse?
            itera = strcat(num2str(i),'-',num2str(j));
            Xorig = TSdataset(:,:,i);
            Yorig = TSdataset(:,:,j);
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
    K
    %%%%%% take into account the zeros added and should't be averaged or
    %%%%%% included in the median
    allDistances = reshape(K,1,m*m);
    %sigma = median(allDistances);
    sigma = median(K,2); %%%%%%% ?? or VARIANCE
    K = -K./repmat(2*sigma,1,size(K,1))
    K = exp(K)
    Kinv = mpower(inv(K),0.5)
    %Kinv2 = mpower(K,-0.5)
end