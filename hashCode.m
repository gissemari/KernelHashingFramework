function H = hashCode(Kfunct, w, B)
    dim1 = size(Kfunct,1); %%% when we have a query, the size is just 1
    H = zeros(dim1,B);
    HashCode = zeros(dim1,B);
    cont = 0;
    for i=1:dim1
        for j=1:B
            hash = sum(w(j,:).*Kfunct(i,:));
            if (cont==0)
                disp('w * K');
                w(j,:)
                Kfunct(i,:)
                hash;
            end
            HashCode(i,j) = hash;
            if (hash < 0)
                H(i,j) = 0;
            else
                H(i,j) = 1;
            end
            cont=cont+1;
        end
    end
    real(HashCode)
end