% 定义斑块的大小和步进大小
patch_num=504;
block_size = 10;
step_size = 3; 

matrix1 = all_data1; % 假设你的变量名为 all_data
matrix2 = all_data2; % 假设你的变量名为 all_data

% 获取每个 mat 文件的列数
columns1 = size(matrix1, 2);
columns2 = size(matrix2, 2);

% 计算总的列数
total_columns = columns1 + columns2;

% 初始化矩阵
all_data = zeros(block_size*block_size*4, total_columns);

for iteration = 1:148
    startc = (iteration - 1) * patch_num + 1;
    endc = startc + (patch_num-1);

    % 处理第一个 mat 文件的数据
    start_col = (iteration - 1) * patch_num *2 + 1;
    end_col = start_col + (patch_num-1);
    all_data(:, start_col:end_col) = matrix1(:, startc:endc);

    % 处理第二个 mat 文件的数据
    start_col = (iteration - 1) * patch_num *2 + patch_num + 1;
    end_col = start_col + (patch_num-1);
    all_data(:, start_col:end_col) = matrix2(:, startc:endc);
end

% 将最终的矩阵保存为文本文件
save_path = 'G:\小宇的资料\COBRE\new\156\MMS\hip';  % 替换为实际的保存文件夹路径
file_name = '1010504.txt';

% 拼接完整的保存路径
full_save_path = fullfile(save_path, file_name);

% 使用 dlmwrite 将矩阵保存为文本文件
dlmwrite(full_save_path, all_data, 'delimiter', ' ', 'precision', 5);
