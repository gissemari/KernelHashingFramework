function result = MDWT(X,Y,t)
    D = zeros(t+1,t+1);
    D(1,:) = 100000; %%%%%%%% INFINITE. Verify min and max somehow
    D(:,1) = 100000;
    %% verify 
    D(1,1) = 0;
    X(:,1);
    Y(:,1);
    for i=2:t+1
        for j=2:t+1
            dist = norm(X(:,i-1)-Y(:,j-1)); %% Euclidean distance of the features of time i or j (dim2)
            %%%%%5 if (i==1)
            if (D(i-1,j-1) < D(i,j-1)) && (D(i-1,j-1) < D(i-1,j))
                mindist = D(i-1,j-1);
            elseif (D(i,j-1) < D(i-1,j-1)) && (D(i,j-1) < D(i-1,j))
                mindist = D(i,j-1);
            else
                mindist = D(i-1,j);
            end
            D(i,j) = dist + mindist;
        end
    end
    result = D(t+1,t+1);
end