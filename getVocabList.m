function vocabList = getVocabList()
%GETVOCABLIST reads the fixed vocabulary list in vocab.txt and returns a
%cell array of the words
%   vocabList = GETVOCABLIST() reads the fixed vocabulary list in vocab.txt 
%   and returns a cell array of the words in vocabList.


%% Read the fixed vocabulary list
% vocab.txt�O�w���ǳƦn���`�ε��J��(�@1899�ӳ�r)
fid = fopen('vocab.txt');

% Store all dictionary words in cell array vocab{}
n = 1899;  % Total number of words in the dictionary

% For ease of implementation, we use a struct to map the strings => integers
% In practice, you'll want to use some form of hashmap
% �إߤ@�_���}�C���x�s�`�ε��J
vocabList = cell(n, 1);
for i = 1:n
    % Word Index (can ignore since it will be = i)
    % �]���bvocab.txt����
    % ���J��O[�s�� ���J]���榡
    % ���L�]���O�Q�ΰj��Ӷ��Ǽg�J,�G�s���b�o�䤣�ݭn�Ψ�
    % fscanf�Ψ�Ū�J�榡�Ƹ��(��Ū�����O�Ĥ@���ܼ�fid�����e),%d�O��Ū�쪺����ର�ƭ�,�̫᪺1�O�j�p
    % fscanf(fid, '%d', 1);�����Ū�X�F�s��������,�]�����ݭn�Ψ�N���t���B�z
    fscanf(fid, '%d', 1);
    % Actual Word
    % %s�O��Ū�쪺����ର�r��
    % �ӵ�vocab.txt���榡,Ū���s����N�|Ū������J
    % �NŪ���쪺���J�s�ivocabList��
    vocabList{i} = fscanf(fid, '%s', 1);
end
fclose(fid);

end
