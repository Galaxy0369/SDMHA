% Convert data to a 150x100 matrix
matrix_data = reshape(mahl, 100, 150)';

% Define patch size and step size
patch_num = 504;
block_size = 10;
step_size = 3; 

% Initialize the result matrix
result_matrix_l = zeros(block_size * block_size, patch_num);

block_means = [];

for i = 1:step_size:150 - block_size
    for j = 1:step_size:100 - block_size
        if i + block_size - 1 > 150 && j + block_size - 1 > 100
            block = matrix_data(i:i + block_size - 150 - 1, j:j + block_size - 100 - 1);
        elseif i + block_size - 1 > 150 && j + block_size - 1 <= 100
            block = matrix_data(i:i + block_size - 150 - 1, j:j + block_size - 1);
        elseif i + block_size - 1 <= 150 && j + block_size - 1 > 100
            block = matrix_data(i:i + block_size - 1, j:j + block_size - 100 - 1);
        else
            block = matrix_data(i:i + block_size - 1, j:j + block_size - 1);
        end
        
        mean_value = mean(block(:));
        block_means = [block_means, mean_value];
    end
end

% Find the indices of the top 500 largest mean values
[sorted_means, sorted_indices] = sort(block_means, 'descend');
top_500_indices = sorted_indices(1:patch_num);

% Construct the result matrix
for idx = 1:patch_num  % Calculate the row and column indices of the current patch
    
    row = floor(top_500_indices(idx) / (floor((100 - 1 - block_size) / step_size) + 1)) * step_size + 1;
    if mod(top_500_indices(idx), (floor((100 - 1 - block_size) / step_size) + 1)) == 0
        col = (floor((100 - 1 - block_size) / step_size) + 1) * step_size + 1;
        row = row - step_size;
    else
        col = mod(top_500_indices(idx), (floor((100 - 1 - block_size) / step_size) + 1)) * step_size + 1 - step_size;
    end
    
    row_indices = row:row + block_size - 1;
    col_indices = col:col + block_size - 1;
    
    % Check if row_indices and col_indices have values greater than 150 and 100
    
    row_greater_than_150 = any(row_indices > 150);
    col_greater_than_100 = any(col_indices > 100);

    % If there are values greater than 150, subtract 150
    if row_greater_than_150
        row_indices(row_indices > 150) = row_indices(row_indices > 150) - 150;
    end

    % If there are values greater than 100, subtract 100
    if col_greater_than_100
        col_indices(col_indices > 100) = col_indices(col_indices > 100) - 100;
    end

    temp_result = reshape((row_indices - 1) * 100 + col_indices', [], 1);
    
    result_matrix_l(:, idx) = temp_result;  
end

result_matrix_l = int16(result_matrix_l);


