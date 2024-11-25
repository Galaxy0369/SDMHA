%% Visualize the effect size of the left and right hippocampi based on the computed inter-group effect size vectors

% Right hippocampus
fn_pmap = ('C:\Users\Admin\Desktop\SDMHA\Features\MADMTBM_mvgd_pmap.m'); % Load a template for the right hippocampus
fn_dm = ('C:\Users\Admin\Desktop\SDMHA\Features\patch_select_t.m'); % Save the visualization file for the right hippocampus

%%
fid_read = fopen(fn_pmap, 'r');  % Open the p_map file for reading
fid_write = fopen(fn_dm, 'w');  % Open a file to store the modified data
data = textscan(fid_read, '%s%s%s%s%s%s%s%s%s'); % Read the data from the p_map file

for i = 1:15000
    data{1,7}{i,1} = strrep(data{1,7}{i,1}, data{1,7}{i,1}, 'rgb=(0');
    data{1,8}{i,1} = strrep(data{1,8}{i,1}, data{1,8}{i,1}, '0');
    data{1,9}{i,1} = strrep(data{1,9}{i,1}, data{1,9}{i,1}, '1)}');
end

for col = 1:504
    random_number1 = rand(); % Generate a random number between 0 and 1
    random_number2 = rand();
    random_number3 = rand();
    for row = 1:100
        i = result_matrix_l(row, col);
        data{1,7}{i,1} = strrep(data{1,7}{i,1}, data{1,7}{i,1}, 'rgb=(1');
        data{1,7}{i,1} = [data{1,7}{i,1} num2str(random_number1)];
        data{1,8}{i,1} = strrep(data{1,8}{i,1}, data{1,8}{i,1}, '0');
        data{1,8}{i,1} = [data{1,8}{i,1} num2str(random_number2)];
        data{1,9}{i,1} = strrep(data{1,9}{i,1}, data{1,9}{i,1}, '0)}');
        data{1,9}{i,1} = [data{1,9}{i,1} num2str(random_number3)];
    end
end

for j = 1:44502  % Save all modified data, including color data and visualization face data
    fprintf(fid_write, '%s %s %s %s %s %s %s %s %s\n', data{1,1}{j,1}, data{1,2}{j,1}, data{1,3}{j,1}, data{1,4}{j,1}, data{1,5}{j,1}, data{1,6}{j,1}, data{1,7}{j,1}, data{1,8}{j,1}, data{1,9}{j,1});
end

fclose(fid_read);
fclose(fid_write);