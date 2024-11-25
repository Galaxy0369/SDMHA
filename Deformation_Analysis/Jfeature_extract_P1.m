dir_L_m = dir('C:\Users\Admin\Desktop\SDMHA\Features\Images\*.m');
%dir_R_m = dir('');
fn_dm_l = 'C:\Users\Admin\Desktop\SDMHA\Features\MMS';
%fn_dm_r = '';
req = 1;

% Function to extract MMS or RD+Jacobian features from Jfeature.m and save them to text files
%{
Inputs:
    dir_L_m: Directory containing left hippocampus `.m` files
    dir_R_m: Directory containing right hippocampus `.m` files
    fn_dm_l: Directory to save output left hippocampus feature `.txt` files
    fn_dm_r: Directory to save output right hippocampus feature `.txt` files
    req: Mode selection
         1 - Extract MMS features
         2 - Extract RD+Jacobian features
Outputs:
    Saves filtered data from `Jfeature.m` files of left and right hippocampi 
    into two respective text file folders.
%}

%% -------------------- Left Hippocampus --------------------
dir_L_asc = sort_nat({dir_L_m.name}); % Sort the names of all `.m` files in ascending order
num_files = length(dir_L_asc); % Number of `.m` files
for n = 1:num_files
    % Remove the '.m' extension from the file name
    base_filename = erase(dir_L_asc{n}, '.m'); % 或 strrep(dir_L_asc{n}, '.m', '')
    output_filename = [base_filename, '.txt']; % 生成新的文件名
    fn_dm = fullfile(fn_dm_l, output_filename); % 创建完整的输出路径
    disp(fn_dm);
    disp(dir_L_asc{n});
    
    % Open and read the current left hippocampus Jfeature `.m` file
    fid_read = fopen(fullfile(dir_L_m(n).folder, dir_L_asc{n}), 'r'); % 注意需加完整路径
    fid_write = fopen(fn_dm, 'w'); % Open output file for writing the processed data
    
    % Read the data from the `.m` file, assuming 12 fields separated by spaces
    data = textscan(fid_read, '%s%s%s%s%s%s%s%s%s%s%s%s');
    
    %% Filter and write data based on the `req` mode
    if req == 1
        % Extract MMS features
        for j = 1:15000
            str = data{1, 6}{j, 1}; % Extract the string from column 6
            rem = str(strfind(str, '(')+1:end); % Get the value after '('
            fprintf(fid_write, '%s %s %s %s\n', rem, data{1, 7}{j, 1}, data{1, 8}{j, 1}, data{1, 9}{j, 1});
        end
    elseif req == 2
        % Extract RD+Jacobian features
        for j = 1:15000
            str = data{1, 6}{j, 1}; % Extract the string from column 6
            rem = str(strfind(str, '(')+1:end); % Get the value after '('
            fprintf(fid_write, '%s %s\n', rem, data{1, 10}{j, 1});
        end
    end
    
    fclose(fid_read); % Close the input file
    fclose(fid_write); % Close the output file
end

