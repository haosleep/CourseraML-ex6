function word_indices = processEmail(email_contents)
%PROCESSEMAIL preprocesses a the body of an email and
%returns a list of word_indices 
%   word_indices = PROCESSEMAIL(email_contents) preprocesses 
%   the body of an email and returns a list of indices of the 
%   words contained in the email. 
%

% Load Vocabulary
% ����getVocabList.mŪ�X�`�ε��J��
% �榡�|�O1899x1,�@1899�ӱ`�ε��J
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
% lower�O�N�^��r���ର�p�g
% �o�ˤ��N���|�Q�j�p�g�v�T
email_contents = lower(email_contents);

% Strip all HTML
% Looks for any expression that starts with < and ends with > and replace
% and does not have any < or > in the tag it with a space
% refexprep��ƥΪk�Oregexprep (str, pattern, repstr, options)
% �bstr�����O�_���ŦXpattern�������r��,�����ܴN�N��אּrepstr
% �o��ھڱоǻ����O�Nhtml���y�k���h��
email_contents = regexprep(email_contents, '<[^<>]+>', ' ');

% Handle Numbers
% Look for one or more characters between 0-9
% �o��O��0~9������������number,�ΥH�h���Ʀr
email_contents = regexprep(email_contents, '[0-9]+', 'number');

% Handle URLS
% Look for strings starting with http:// or https://
% �o��O�h�����}
email_contents = regexprep(email_contents, ...
                           '(http|https)://[^\s]*', 'httpaddr');

% Handle Email Addresses
% Look for strings with @ in the middle
% �o��O�h��email
email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr');

% Handle $ sign
% �o��O�N$�Ÿ��אּdollar
email_contents = regexprep(email_contents, '[$]+', 'dollar');


% ========================== Tokenize Email ===========================

% Output the email to screen as well
fprintf('\n==== Processed Email ====\n\n');

% Process file
l = 0;

% �o��Q��while�j��N���v�r��X
while ~isempty(email_contents)

    % Tokenize and also get rid of any punctuation
    % strtok��ƥΪk�O[tok, rem] = strtok (str, delim)
    % ��Xstr���Ĥ@�ӥX�{delim���r������m
    % �b�o�r�����e�������s��tok,����Ѿl�������s�brem��
    % �ΨӨ��X��󤤪���r��
    [str, email_contents] = ...
       strtok(email_contents, ...
              [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);
   
    % Remove any non alphanumeric characters
    % �Y���O�r���μƦr�h�h��
    str = regexprep(str, '[^a-zA-Z0-9]', '');

    % Stem the word 
    % (the porterStemmer sometimes has issues, so we use a try catch block)
    % strtrim�O�Ω�h���}�Y�M�������ťճ���
    % �A�Q�Τw�g�ǳƦn��porterStemmer.m���r�i��B�z
    % �ھ�porterStemmer.m�̪����e,�򥻴N�O���ʬ������B�z(�Ƽ�,�L�h��,�i�榡��������r�i��ϧO����)
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

    
    % �o��O�@�~�����e
    % �n��W���w�g�B�z������r,�M�w�g�ǳƦn���`�ε��J��i����
    % �N��󪺳�r�ഫ�����J��������s���A�s��}�C��
    for i = 1 : length(vocabList)
      % strcmp�O�Ω�����r�ꪺ,���r��۵��ɷ|return 1,�Ϥ�return 0
      if (strcmp(str,vocabList(i)))
        % �]���W��getVocabList()�O�ӽs���s��,�G����ɴN�Ni�s��}�C�Y�i(���ǹ����s��)
        word_indices = [word_indices; i];
        % �`�ε��J��z���O�S�����Ƶ��J��
        % �G�����쪺�ɭԴN�i�H���Xfor�j�餣�ΦA�~����U�h
        % �i�H�٤U����ɶ�
        break
      end
    endfor







    % =============================================================


    % Print to screen, ensuring that the output lines are not too long
    % �N�B�z�᪺��󤺮eprint�X
    % �Yprint�X�����(���r��)�Ӫ���print'\n'����
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
