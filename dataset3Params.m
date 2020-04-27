function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

% 使用的C和sigma的組合是根據教學所提供的8種參數
listC = [0.01 0.03 0.1 0.3 1 3 10 30];
listSigma = [0.01 0.03 0.1 0.3 1 3 10 30];
% 用於紀錄誤差量
listError = zeros(8,8);

for i = 1 : length(listC)
  for j = 1 : length(listSigma)
    % 將part5示範的高斯核SVM訓練的程式碼如法炮製過來
    model= svmTrain(X, y, listC(i), @(x1, x2) gaussianKernel(x1, x2, listSigma(j)));
    % 利用svmPredict.m,將訓練完的結果和驗證集進行處理取得驗證集的預測結果
    predictions = svmPredict(model, Xval);
    % 將預測結果和驗證集的實際結果進行比對得出此次C和sigma組合下的誤差量
    listError(i,j) = mean(double(predictions ~= yval));
  endfor
endfor

% 找出誤差量最低的情況下的C和sigma的值
[idxC, idxSigma] = find(listError == min(min(listError)));
C = listC(idxC);
sigma = listSigma(idxSigma);



% =========================================================================

end
