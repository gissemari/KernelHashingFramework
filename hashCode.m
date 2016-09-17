function H = hashCode(Kfunct, w, B)
    dim1 = size(Kfunct,1); %%% when we have a query, the size is just 1
    H = zeros(dim1,B);
    HashCode = zeros(dim1,B);
    for i=1:dim1
        for j=1:B
            hash = sum(w(j)*Kfunct(i,:));
            HashCode(i,j) = hash;
            if (hash < 0)
                H(i,j) = 0;
            else
                H(i,j) = 1;
            end
        end
    end
    HashCode
    H
end