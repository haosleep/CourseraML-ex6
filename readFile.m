function file_contents = readFile(filename)
%READFILE reads a file and returns its entire contents 
%   file_contents = READFILE(filename) reads a file and returns its entire
%   contents in file_contents
%

% Load File
fid = fopen(filename);
% 當fid非空時(前面fopen成功開啟檔案時)
if fid
    % fscanf讀取格式化資料,%c是讀到的資料轉為字元
    % inf代表讀取全部資料,會轉為行向量的形式
    file_contents = fscanf(fid, '%c', inf);
    fclose(fid);
% 如果fid為空則進行else處理
else
    file_contents = '';
    fprintf('Unable to open %s\n', filename);
end

end

