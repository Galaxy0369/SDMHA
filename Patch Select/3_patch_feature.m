% 指定包含txt文件的文件夹路径
folder_path = 'G:\小宇的资料\COBRE\new\156\MMS\hip\left\'; % 替换为实际文件夹路径

patch_num=504;
block_size=10;

% 获取文件夹中所有txt文件的列表
file_list = dir(fullfile(folder_path, '*.txt'));

% 初始化一个空矩阵，用于存储所有文件的数据
all_data1 = zeros(4 * block_size * block_size, patch_num* numel(file_list));

% 循环遍历每个txt文件
for i = 1:numel(file_list)
    % 构建完整的文件路径
    file_path = fullfile(folder_path, file_list(i).name);
    
    % 使用适当的函数（例如load、textscan）加载文本文件并将其转换为矩阵
    % 假设文本文件中的数据以空格分隔，并且每列的浮点数之间用一个空格隔开
    matrix_data = load(file_path);
   
    % 创建一个包含400行的空矩阵
    result = zeros(4 * block_size * block_size, patch_num);

    % 循环遍历matrix1的每一列
    for j = 1:patch_num
    % 获取matrix1第i列的值（100个值）
    column_values = result_matrix_l(:, j);
    
    % 初始化一个空的数组，用于存储从matrix2中提取的400个数
    extracted_values = zeros(block_size * block_size, 1);
    
    % !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!gaigaigiagai
    for k = 1:block_size * block_size
        row_index = column_values(k); % 获取行索引
        extracted_values((k-1)*4+1:k*4) = matrix_data(row_index, :);
    end
    
    % 将extracted_values添加到result_matrix的第i列
    result(:, j) = extracted_values;
    
        % 将 matrix_data 添加到 all_data 中的相应位置
    start_col = (i - 1) * patch_num + 1;
    end_col = i * patch_num;
    all_data1(:, start_col:end_col) = result;
    
end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 指定包含txt文件的文件夹路径
folder_path = 'G:\小宇的资料\COBRE\new\156\MMS\hip\right\'; % 替换为实际文件夹路径

patch_num=504;
block_size=10;

% 获取文件夹中所有txt文件的列表
file_list = dir(fullfile(folder_path, '*.txt'));

% 初始化一个空矩阵，用于存储所有文件的数据
all_data2 = zeros(4 * block_size * block_size, patch_num* numel(file_list));

% 循环遍历每个txt文件
for i = 1:numel(file_list)
    % 构建完整的文件路径
    file_path = fullfile(folder_path, file_list(i).name);
    
    % 使用适当的函数（例如load、textscan）加载文本文件并将其转换为矩阵
    % 假设文本文件中的数据以空格分隔，并且每列的浮点数之间用一个空格隔开
    matrix_data = load(file_path);
   
    % 创建一个包含400行的空矩阵
    result = zeros(4 * block_size * block_size, patch_num);

    % 循环遍历matrix1的每一列
    for j = 1:patch_num
    % 获取matrix1第i列的值（100个值）
    column_values = result_matrix_r(:, j);
    
    % 初始化一个空的数组，用于存储从matrix2中提取的400个数
    extracted_values = zeros(block_size * block_size, 1);
    
    % !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!gaigaigiagai
    for k = 1:block_size * block_size
        row_index = column_values(k); % 获取行索引
        extracted_values((k-1)*4+1:k*4) = matrix_data(row_index, :);
    end
    
    % 将extracted_values添加到result_matrix的第i列
    result(:, j) = extracted_values;
    
        % 将 matrix_data 添加到 all_data 中的相应位置
    start_col = (i - 1) * patch_num + 1;
    end_col = i * patch_num;
    all_data2(:, start_col:end_col) = result;
    
end
    
end

