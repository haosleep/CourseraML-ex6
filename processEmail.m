function word_indices = processEmail(email_contents)
%PROCESSEMAIL preprocesses a the body of an email and
%returns a list of word_indices 
%   word_indices = PROCESSEMAIL(email_contents) preprocesses 
%   the body of an email and returns a list of indices of the 
%   words contained in the email. 
%

% Load Vocabulary
% 先用getVocabList.m讀出常用詞彙表
% 格式會是1899x1,共1899個常用詞彙
vocabList = getVocabList();

% Init return value
word_indices = [];

% ========================== Preprocess Email ===========================

% Find the Headers ( \n\n and remove )
% Uncomment the following lines if you are working with raw emails with the
% full headers

% hdrstart = strfind(email_contents, ([char(10) char(10)]));
% email_contents = email_contents(hdrstart(1):end);

% Lower case
% lower是將英文字全轉為小寫
% 這樣文件就不會被大小寫影響
email_contents = lower(email_contents);

% Strip all HTML
% Looks for any expression that starts with < and ends with > and replace
% and does not have any < or > in the tag it with a space
% refexprep函數用法是regexprep (str, pattern, repstr, options)
% 在str中比對是否有符合pattern型式的字串,有的話就將其改為repstr
% 這行根據教學說明是將html的語法給去除
email_contents = regexprep(email_contents, '<[^<>]+>', ' ');

% Handle Numbers
% Look for one or more characters between 0-9
% 這行是把0~9的部分替換為number,用以去除數字
email_contents = regexprep(email_contents, '[0-9]+', 'number');

% Handle URLS
% Look for strings starting with http:// or https://
% 這行是去除網址
email_contents = regexprep(email_contents, ...
                           '(http|https)://[^\s]*', 'httpaddr');

% Handle Email Addresses
% Look for strings with @ in the middle
% 這行是去除email
email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr');

% Handle $ sign
% 這行是將$符號改為dollar
email_contents = regexprep(email_contents, '[$]+', 'dollar');


% ========================== Tokenize Email ===========================

% Output the email to screen as well
fprintf('\n==== Processed Email ====\n\n');

% Process file
l = 0;

% 這邊利用while迴圈將文件逐字拆出
while ~isempty(email_contents)

    % Tokenize and also get rid of any punctuation
    % strtok函數用法是[tok, rem] = strtok (str, delim)
    % 找出str中第一個出現delim中字元的位置
    % 在這字元之前的部分存於tok,之後剩餘的部分存在rem裡
    % 用來取出文件中的單字的
    [str, email_contents] = ...
       strtok(email_contents, ...
              [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);
   
    % Remove any non alphanumeric characters
    % 若不是字母或數字則去除
    str = regexprep(str, '[^a-zA-Z0-9]', '');

    % Stem the word 
    % (the porterStemmer sometimes has issues, so we use a try catch block)
    % strtrim是用於去除開頭和結尾的空白部分
    % 再利用已經準備好的porterStemmer.m對單字進行處理
    % 根據porterStemmer.m裡的內容,基本就是詞性相關的處理(複數,過去式,進行式等等的單字進行區別劃分)
    try str = porterStemmer(strtrim(str)); 
    catch str = ''; continue;
    end;

    % Skip the word if it is too short
    if length(str) < 1
       continue;
    end

    % Look up the word in the dictionary and add to word_indices if
    % found
    % ====================== YOUR CODE HERE ======================
    % Instructions: Fill in this function to add the index of str to
    %               word_indices if it is in the vocabulary. At this point
    %               of the code, you have a stemmed word from the email in
    %               the variable str. You should look up str in the
    %               vocabulary list (vocabList). If a match exists, you
    %               should add the index of the word to the word_indices
    %               vector. Concretely, if str = 'action', then you should
    %               look up the vocabulary list to find where in vocabList
    %               'action' appears. For example, if vocabList{18} =
    %               'action', then, you should add 18 to the word_indices 
    %               vector (e.g., word_indices = [word_indices ; 18]; ).
    % 
    % Note: vocabList{idx} returns a the word with index idx in the
    %       vocabulary list.
    % 
    % Note: You can use strcmp(str1, str2) to compare two strings (str1 and
    %       str2). It will return 1 only if the two strings are equivalent.
    %

    
    % 這邊是作業的內容
    % 要把上面已經處理完的單字,和已經準備好的常用詞彙表進行比對
    % 將文件的單字轉換成詞彙表對應的編號再存於陣列中
    for i = 1 : length(vocabList)
      % strcmp是用於比較兩字串的,當兩字串相等時會return 1,反之return 0
      if (strcmp(str,vocabList(i)))
        % 因為上面getVocabList()是照編號存的,故比對到時就將i存於陣列即可(順序對應編號)
        word_indices = [word_indices; i];
        % 常用詞彙表理應是沒有重複詞彙的
        % 故當有比對到的時候就可以跳出for迴圈不用再繼續比對下去
        % 可以省下執行時間
        break
      end
    endfor







    % =============================================================


    % Print to screen, ensuring that the output lines are not too long
    % 將處理後的文件內容print出
    % 若print出的文件(單行字數)太長時print'\n'換行
    if (l + length(str) + 1) > 78
        fprintf('\n');
        l = 0;
    end
    fprintf('%s ', str);
    l = l + length(str) + 1;

end

% Print footer
fprintf('\n\n=========================\n');

end
