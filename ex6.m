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

% �o���@�~�n�m�ߪ��O�䴩�V�q��(SVM)
fprintf('Loading and Visualizing Data ...\n')

% Load from ex6data1: 
% You will have X, y in your environment
% �����J�Ĥ@���V�m���
% �@51����ӯS�x�Ȫ��G�������
% X�榡��51x2
% y�榡��51x1
load('ex6data1.mat');

% Plot training data
% �Nex6data1.mat����ƥΤG���Ϫ�ܥX��
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
% ���ۧQ��SVM���覡�Ө��oex6data1.mat��ƪ��M�����
% svmTrain.m�O�w�g�ǳƦn��SVM�V�m���
% visualizeBoundaryLinear.m�h�|��V�m�ұo�X���M����ɪ�ܦb�G���ϤW
C = 1;
model = svmTrain(X, y, C, @linearKernel, 1e-3, 20);
visualizeBoundaryLinear(X, y, model);

fprintf('Program paused. Press enter to continue.\n');
pause;

% part2�B�~�m��
% �ȱo�`�N���Oex6data1.mat����Ƥ�,���@���������ݪ����(�Ϥ�������(0.1,4.1)������)
% �ӵ�part2���������ձNC�]�����j��1000
% �i�H�ݨ��o�X�Ӫ��M����ɷ|�ܱo�L�����X���
% (�i�ѦҤ���)�]��C���P��e���ҾǪ����W�ƩԮ�Ԥ�Ѽƪ��˼�(1/�f)
% �f���γB�O���F�խ�����c�Ϩ�v�T���ܩ�Ӥj
% ��C�]���@���j��,�������N�O�f�ܦ��F���p��
% �c�X�񤣨��������p�U�N�|�ھڰV�m���,�b�����ǲߤU�o��F�����̧������M�����
% ���]�N�X�{�F�L���X�����D
C = 1000;
model = svmTrain(X, y, C, @linearKernel, 1e-3, 20);
visualizeBoundaryLinear(X, y, model);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =============== Part 3: Implementing Gaussian Kernel ===============
%  You will now implement the Gaussian kernel to use
%  with the SVM. You should complete the code in gaussianKernel.m
%

% ���۽m�ߪ��O������SVM
% �bgaussianKernel.m��������Ӽ˥����������֨��(part3�@�~)
fprintf('\nEvaluating the Gaussian Kernel ...\n')

x1 = [1 2 1]; x2 = [0 4 -1]; sigma = 2;
sim = gaussianKernel(x1, x2, sigma);

% ���Q��x1,x2����gaussianKernel.m�O�_���T
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
% ����Ū��ex6data2.mat���V�m���
% �@��863�����G�������
load('ex6data2.mat');

% Plot training data
% �Nex6data2.mat����Ʀb�G���ϤW��ܥX��
% �q�Ϥ��i�M���ݥX,��ex6data1.mat���P,����ƨS��k�νu�ʨM����ɳB�z
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
% �Q��part3������gaussianKernel.m�MsvmTrain.m�i��V�m��X�M�����
% �P�˦A��visualizeBoundary.m��ܦb�G���ϤW
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
% ���۬OŪ��ex6data3.mat���V�m���
% �t��211�����G������ƪ��V�m��X,y
% �t��200���G������ƪ����Ҷ�Xval,yval
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
% �o���n�Q��dataset3Params.m,�H���P��C�Msigma�ѼƲզX�i��h����SVM�V�m
% �A�B�����Ҷ��ӧ�X���G�̨Ϊ�C�Msigma�Ѽ�(part7�@�~)
[C, sigma] = dataset3Params(X, y, Xval, yval);

% Train the SVM
model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
visualizeBoundary(X, y, model);

fprintf('Program paused. Press enter to continue.\n');
pause;

