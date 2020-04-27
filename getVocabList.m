function vocabList = getVocabList()
%GETVOCABLIST reads the fixed vocabulary list in vocab.txt and returns a
%cell array of the words
%   vocabList = GETVOCABLIST() reads the fixed vocabulary list in vocab.txt 
%   and returns a cell array of the words in vocabList.


%% Read the fixed vocabulary list
% vocab.txt是預先準備好的常用詞彙表(共1899個單字)
fid = fopen('vocab.txt');

% Store all dictionary words in cell array vocab{}
n = 1899;  % Total number of words in the dictionary

% For ease of implementation, we use a struct to map the strings => integers
% In practice, you'll want to use some form of hashmap
% 建立一巢狀陣列來儲存常用詞彙
vocabList = cell(n, 1);
for i = 1:n
    % Word Index (can ignore since it will be = i)
    % 因為在vocab.txt之中
    % 詞彙表是[編號 詞彙]的格式
    % 不過因為是利用迴圈照順序寫入,故編號在這邊不需要用到
    % fscanf用來讀入格式化資料(所讀取的是第一項變數fid的內容),%d是把讀到的資料轉為數值,最後的1是大小
    % fscanf(fid, '%d', 1);此行先讀出了編號的部分,因為不需要用到就不另做處理
    fscanf(fid, '%d', 1);
    % Actual Word
    % %s是把讀到的資料轉為字串
    % 照著vocab.txt的格式,讀完編號後就會讀取到詞彙
    % 將讀取到的詞彙存進vocabList裡
    vocabList{i} = fscanf(fid, '%s', 1);
end
fclose(fid);

end
