%% Machine Learning Online Class
%  Exercise 6 | Support Vector Machines
%
%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  exercise. You will need to complete the following functions:
%
%     gaussianKernel.m
%     dataset3Params.m
%     processEmail.m
%     emailFeatures.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc

%% =============== Part 1: Loading and Visualizing Data ================
%  We start the exercise by first loading and visualizing the dataset. 
%  The following code will load the dataset into your environment and plot
%  the data.
%

% 這次作業要練習的是支援向量機(SVM)
fprintf('Loading and Visualizing Data ...\n')

% Load from ex6data1: 
% You will have X, y in your environment
% 先載入第一項訓練資料
% 共51筆兩個特徵值的二分類資料
% X格式為51x2
% y格式為51x1
load('ex6data1.mat');

% Plot training data
% 將ex6data1.mat的資料用二維圖表示出來
plotData(X, y);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ==================== Part 2: Training Linear SVM ====================
%  The following code will train a linear SVM on the dataset and plot the
%  decision boundary learned.
%

% Load from ex6data1: 
% You will have X, y in your environment
load('ex6data1.mat');

fprintf('\nTraining Linear SVM ...\n')

% You should try to change the C value below and see how the decision
% boundary varies (e.g., try C = 1000)
% 接著利用SVM的方式來取得ex6data1.mat資料的決策邊界
% svmTrain.m是已經準備好的SVM訓練函數
% visualizeBoundaryLinear.m則會把訓練所得出的決策邊界表示在二維圖上
C = 1;
model = svmTrain(X, y, C, @linearKernel, 1e-3, 20);
visualizeBoundaryLinear(X, y, model);

fprintf('Program paused. Press enter to continue.\n');
pause;

% part2額外練習
% 值得注意的是ex6data1.mat的資料中,有一筆較為極端的資料(圖片中左方(0.1,4.1)的正例)
% 照著part2的說明嘗試將C設為極大值1000
% 可以看見得出來的決策邊界會變得過於擬合資料
% (可參考公式)因為C等同於前面所學的正規化拉格朗日參數的倒數(1/λ)
% λ的用處是為了調降整體θ使其影響不至於太大
% 當C設為一極大值,對應的就是λ變成了極小值
% θ幾近不受限的狀況下就會根據訓練資料,在機器學習下得到了分類最完全的決策邊界
% 但也就出現了過擬合的問題
C = 1000;
model = svmTrain(X, y, C, @linearKernel, 1e-3, 20);
visualizeBoundaryLinear(X, y, model);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =============== Part 3: Implementing Gaussian Kernel ===============
%  You will now implement the Gaussian kernel to use
%  with the SVM. You should complete the code in gaussianKernel.m
%

% 接著練習的是高斯核SVM
% 在gaussianKernel.m中完成兩個樣本間的高斯核函數(part3作業)
fprintf('\nEvaluating the Gaussian Kernel ...\n')

x1 = [1 2 1]; x2 = [0 4 -1]; sigma = 2;
sim = gaussianKernel(x1, x2, sigma);

% 先利用x1,x2測試gaussianKernel.m是否正確
fprintf(['Gaussian Kernel between x1 = [1; 2; 1], x2 = [0; 4; -1], sigma = %f :' ...
         '\n\t%f\n(for sigma = 2, this value should be about 0.324652)\n'], sigma, sim);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =============== Part 4: Visualizing Dataset 2 ================
%  The following code will load the next dataset into your environment and 
%  plot the data. 
%

fprintf('Loading and Visualizing Data ...\n')

% Load from ex6data2: 
% You will have X, y in your environment
% 接著讀取ex6data2.mat的訓練資料
% 共有863筆的二分類資料
load('ex6data2.mat');

% Plot training data
% 將ex6data2.mat的資料在二維圖上顯示出來
% 從圖中可清楚看出,跟ex6data1.mat不同,此資料沒辦法用線性決策邊界處理
plotData(X, y);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ========== Part 5: Training SVM with RBF Kernel (Dataset 2) ==========
%  After you have implemented the kernel, we can now use it to train the 
%  SVM classifier.
% 
fprintf('\nTraining SVM with RBF Kernel (this may take 1 to 2 minutes) ...\n');

% Load from ex6data2: 
% You will have X, y in your environment
load('ex6data2.mat');

% SVM Parameters
C = 1; sigma = 0.1;

% We set the tolerance and max_passes lower here so that the code will run
% faster. However, in practice, you will want to run the training to
% convergence.
% 利用part3完成的gaussianKernel.m和svmTrain.m進行訓練找出決策邊界
% 同樣再由visualizeBoundary.m表示在二維圖上
model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma)); 
visualizeBoundary(X, y, model);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =============== Part 6: Visualizing Dataset 3 ================
%  The following code will load the next dataset into your environment and 
%  plot the data. 
%

fprintf('Loading and Visualizing Data ...\n')

% Load from ex6data3: 
% You will have X, y in your environment
% 接著是讀取ex6data3.mat的訓練資料
% 含有211筆的二分類資料的訓練集X,y
% 另有200筆二分類資料的驗證集Xval,yval
load('ex6data3.mat');

% Plot training data
plotData(X, y);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ========== Part 7: Training SVM with RBF Kernel (Dataset 3) ==========

%  This is a different dataset that you can use to experiment with. Try
%  different values of C and sigma here.
% 

% Load from ex6data3: 
% You will have X, y in your environment
load('ex6data3.mat');

% Try different SVM Parameters here
% 這次要利用dataset3Params.m,以不同的C和sigma參數組合進行多次的SVM訓練
% 再運用驗證集來找出結果最佳的C和sigma參數(part7作業)
[C, sigma] = dataset3Params(X, y, Xval, yval);

% Train the SVM
model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
visualizeBoundary(X, y, model);

fprintf('Program paused. Press enter to continue.\n');
pause;

