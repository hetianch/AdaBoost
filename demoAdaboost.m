addpath 'Stump';
addpath 'Boost';
addpath 'Data';
addpath 'CV';

% Load data
load data_boost.mat;

% Test decision stump
% stump = buildStump(X, Y);

% 
nfold = 10;
iter = 300;
tstError = zeros(nfold, iter);
trnError = zeros(nfold, iter);
[trnM, tstM] = buildCVMatrix(size(X, 1), nfold);
for n = 1:nfold
    fprintf('\tFold %d\n', n);
    idx_trn = logical(trnM(:, n) == 1);
    trnX = X(idx_trn, :);
    tstX = X(~idx_trn, :);
    trnY = Y(idx_trn);
    tstY = Y(~idx_trn);
    abClassifier = buildAdaBoost(trnX, trnY, iter, tstX, tstY);
    trnError(n, :) = abClassifier.trnErr;
    tstError(n, :) = abClassifier.tstErr;
end

plot(1:iter, mean(trnError, 1));
hold on;
plot(1:iter, mean(tstError, 1));
