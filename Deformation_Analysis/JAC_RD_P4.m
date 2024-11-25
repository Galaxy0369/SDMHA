folder_path1 = 'C:\Users\Admin\Desktop\SDMHA\Features\RD\group1\';  % Replace with your folder path
folder_path2 = 'C:\Users\Admin\Desktop\SDMHA\Features\RD\group2\';  % Replace with your folder path
fn_pmap = 'C:\Users\Admin\Desktop\SDMHA\Features\MADMTBM_mvgd_pmap.m'; % Load a right hippocampus template
fn_dm = 'C:\Users\Admin\Desktop\SDMHA\Features\RD_E_atrophy.m'; % Save right hippocampus visualization file

mah = mahl;  % Set 'mahl' variable

% Get all txt files in the folder
txt_files = dir(fullfile(folder_path1, '*.txt'));

% Initialize total sum matrix
total_sum = zeros(15000, 2);

% Loop through each txt file
for i = 1:length(txt_files)
    file_path = fullfile(folder_path1, txt_files(i).name);
    
    % Accumulate matrix data
    matrix_data = dlmread(file_path);
    total_sum = total_sum + matrix_data;
end

% Calculate the average
average_matrix1 = total_sum / length(txt_files);

% Get all txt files in the second folder
txt_files = dir(fullfile(folder_path2, '*.txt'));

% Initialize total sum matrix
total_sum = zeros(15000, 1);

% Loop through each txt file
for i = 1:length(txt_files)
    file_path = fullfile(folder_path2, txt_files(i).name);
    
    % Accumulate matrix data
    matrix_data = dlmread(file_path);
    total_sum = total_sum + matrix_data;
end

% Calculate the average
average_matrix2 = total_sum / length(txt_files);

% Compute the result
result = average_matrix2 - average_matrix1;

mah1 = result(:, 1);

fid_read = fopen(fn_pmap, 'r');  % Read the p_map file
fid_write = fopen(fn_dm, 'w'); % Save the modified file
data = textscan(fid_read, '%s%s%s%s%s%s%s%s%s'); % Read p_map file data

% Modify colors
for i = 1:15000 % Loop through each row of the p_map file
    str = data{1, 6}{i, 1}; % {prob=(0.0818) rgb=(0 1 0)} ————> Extract the prob value
    rem = str(strfind(str, '(')+1:strfind(str, ')')-1);  % Extract prob value (rem)
    p_value = str2num(rem); 
    disp(mah1(i));  % Display variable value
    
    if p_value <= 0.05
        if mah1(i) <= 0
            if 0 <= mah(i) && mah(i) < 0.20
                data{1, 7}{i, 1} = strrep(data{1, 7}{i, 1}, data{1, 7}{i, 1}, 'rgb=(0.4');
                data{1, 8}{i, 1} = strrep(data{1, 8}{i, 1}, data{1, 8}{i, 1}, '0.8');
                data{1, 9}{i, 1} = strrep(data{1, 9}{i, 1}, data{1, 9}{i, 1}, '0.4)}');
            elseif 0.20 <= mah(i) && mah(i) < 0.4
                data{1, 7}{i, 1} = strrep(data{1, 7}{i, 1}, data{1, 7}{i, 1}, 'rgb=(0');
                data{1, 8}{i, 1} = strrep(data{1, 8}{i, 1}, data{1, 8}{i, 1}, '0.6');
                data{1, 9}{i, 1} = strrep(data{1, 9}{i, 1}, data{1, 9}{i, 1}, '0)}');
            elseif mah(i) >= 0.4
                data{1, 7}{i, 1} = strrep(data{1, 7}{i, 1}, data{1, 7}{i, 1}, 'rgb=(0');
                data{1, 8}{i, 1} = strrep(data{1, 8}{i, 1}, data{1, 8}{i, 1}, '0.1');
                data{1, 9}{i, 1} = strrep(data{1, 9}{i, 1}, data{1, 9}{i, 1}, '0.1)}');
            end
        end
    end

    if p_value <= 0.05       
        if mah1(i) > 0
            if 0.0 <= mah(i) && mah(i) < 0.2
                data{1, 7}{i, 1} = strrep(data{1, 7}{i, 1}, data{1, 7}{i, 1}, 'rgb=(0.8');
                data{1, 8}{i, 1} = strrep(data{1, 8}{i, 1}, data{1, 8}{i, 1}, '0');
                data{1, 9}{i, 1} = strrep(data{1, 9}{i, 1}, data{1, 9}{i, 1}, '0)}');
            elseif 0.2 <= mah(i) && mah(i) < 0.4
                data{1, 7}{i, 1} = strrep(data{1, 7}{i, 1}, data{1, 7}{i, 1}, 'rgb=(0.4');
                data{1, 8}{i, 1} = strrep(data{1, 8}{i, 1}, data{1, 8}{i, 1}, '0');
                data{1, 9}{i, 1} = strrep(data{1, 9}{i, 1}, data{1, 9}{i, 1}, '0)}');
            elseif mah(i) > 0.4
                data{1, 7}{i, 1} = strrep(data{1, 7}{i, 1}, data{1, 7}{i, 1}, 'rgb=(0.2');
                data{1, 8}{i, 1} = strrep(data{1, 8}{i, 1}, data{1, 8}{i, 1}, '0');
                data{1, 9}{i, 1} = strrep(data{1, 9}{i, 1}, data{1, 9}{i, 1}, '0)}');
            end
        end
    elseif p_value > 0.05
        data{1, 7}{i, 1} = strrep(data{1, 7}{i, 1}, data{1, 7}{i, 1}, 'rgb=(0');
        data{1, 8}{i, 1} = strrep(data{1, 8}{i, 1}, data{1, 8}{i, 1}, '0');
        data{1, 9}{i, 1} = strrep(data{1, 9}{i, 1}, data{1, 9}{i, 1}, '1)}');
    end
end

for j = 1:44502  % Save all modified data, including color data and visualization face data
    fprintf(fid_write, '%s %s %s %s %s %s %s %s %s\n', data{1, 1}{j, 1}, data{1, 2}{j, 1}, data{1, 3}{j, 1}, data{1, 4}{j, 1}, data{1, 5}{j, 1}, data{1, 6}{j, 1}, data{1, 7}{j, 1}, data{1, 8}{j, 1}, data{1, 9}{j, 1});
end

fclose(fid_read);
fclose(fid_write);
