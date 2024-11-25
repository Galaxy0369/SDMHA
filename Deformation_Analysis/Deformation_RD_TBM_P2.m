% Calculate hippocampal vertex deformation between control groups
clc;
clear;

%% Inter-group hippocampal deformation calculation
% Store deformation analysis matrices for two groups for visualization
dir_def = ['C:\Users\Admin\Desktop\SDMHA\Features\'];

% Read RD + Jacobian
dir_L_conv = dir('C:\Users\Admin\Desktop\SDMHA\Features\RD\group1\*.txt'); % 
%dir_R_conv = dir(''); % 
dir_L_noconv = dir('C:\Users\Admin\Desktop\SDMHA\Features\RD\group2\*.txt'); % 
%dir_R_noconv = dir(''); % 

%% Calculate the average RD + Jacobian for each vertex of the two groups and save to [data_l_conv, data_l_noconv]
[data_l_conv, data_l_noconv] = deal(zeros(15000,2)); % Initialize all four variables to zeros (15000x2)
[dir_asc_l_conv,dir_asc_l_noconv] = deal(sort_nat({dir_L_conv.name}), sort_nat({dir_L_noconv.name})); % Sort all txt file names in ascending order and store them; dir_asc_l_conv is a cell array
[i, j] = deal(length(dir_asc_l_conv), length(dir_asc_l_noconv)); %
temp = zeros(15000,2);

for n = 1:i
    temp = load(dir_asc_l_conv{n}); % Load RD + Jacobian data matrix for each sample
    disp(dir_asc_l_conv{n} + " has been loaded");
    data_l_conv = data_l_conv + temp;
    
end

data_l_conv = data_l_conv / n;

for n = 1:j
    temp = load(dir_asc_l_noconv{n}); % Load RD + Jacobian data matrix for each sample
    disp(dir_asc_l_noconv{n} + " has been loaded");
    data_l_noconv = data_l_noconv + temp;
end

data_l_noconv = data_l_noconv / n;

%% Perform deformation analysis between the two groups using the average RD + Jacobian
% JAC
JAC_conv_noconv_L = data_l_conv(:,2) - data_l_noconv(:,2);
save(fullfile(dir_def, 'JAC_hip_L.mat'), 'JAC_conv_noconv_L');

% RD
RD_conv_noconv_L = data_l_conv(:,1) - data_l_noconv(:,1);
save(fullfile(dir_def, 'RD_hip_L.mat'), 'RD_conv_noconv_L');
