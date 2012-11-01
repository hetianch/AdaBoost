function [trnM, tstM] = buildCVMatrix(N, nfold)
blockSize = floor(N/nfold);
trnM = zeros(N, nfold);
tstM = zeros(N, nfold);

for i = 1:(nfold-1)
    index = repmat(false, N, 1);
    index(((i-1)*blockSize+1):(i*blockSize)) = true;
    tstM(index, i) = true;
    trnM(~index, i) = true;
end
index = repmat(false, N, 1);
index( ((nfold-1)*blockSize+1):N ) = true;
tstM(index, nfold) = true;
trnM(~index, nfold) = true;
end
