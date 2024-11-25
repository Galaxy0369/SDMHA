% Calculate effect sizes for hippocampal vertices in the control group
clc;
clear;
%% Parameter settings
% Separately read the MMS of the left and right hippocampi for each group, 
% used to compute the average MMS for each vertex in the two groups
%{ %}
dir_L_conv = dir('C:\Users\Admin\Desktop\SDMHA\Features\MMS\group1\*.txt'); % Path to left hippocampus MMS files for the control group
dir_L_noconv = dir('C:\Users\Admin\Desktop\SDMHA\Features\MMS\group2\*.txt'); % Path to left hippocampus MMS files for the experimental group

% Storage paths for the effect size vectors of left and right hippocampi
data_dir_l = ['C:\Users\Admin\Desktop\SDMHA\Features\Mah_L(hip).mat'];

%% Compute the average MMS for each vertex in the two groups and save them
[data_l_conv, data_r_conv, data_l_noconv, data_r_noconv] = deal(zeros(15000, 4));
[dir_asc_l_conv, dir_asc_l_noconv] = ...
deal(sort_nat({dir_L_conv.name}), sort_nat({dir_L_noconv.name})); 
% Sort the file names in ascending order and store as cell arrays

[i, j] = deal(length(dir_asc_l_conv), length(dir_asc_l_noconv)); 

for n = 1:i
    temp = load(dir_asc_l_conv{n});
    disp(dir_asc_l_conv{n} + " loaded");
    data_l_conv = data_l_conv + temp;
end
data_l_conv = data_l_conv / n;

for n = 1:j
    temp = load(dir_asc_l_noconv{n});
    disp(dir_asc_l_noconv{n} + " loaded");
    data_l_noconv = data_l_noconv + temp;
end
data_l_noconv = data_l_noconv / n;

%% Compute sample collections for covariance matrices
[Mix_sample_L_conv, Mix_sample_L_noconv] = deal([]);
% Merge all samples for the control group into tensors
for n = 1:i
    temp = load(dir_asc_l_conv{n});
    Mix_sample_L_conv(:, :, n) = temp;

end
disp("All control group samples merged");

% Merge all samples for the experimental group into tensors
for n = 1:j
    temp = load(dir_asc_l_noconv{n});
    Mix_sample_L_noconv(:, :, n) = temp;
end
disp("All experimental group samples merged");

% Combine left and right hippocampus samples for both groups
Mix_sample_L = cat(3, Mix_sample_L_conv, Mix_sample_L_noconv);

%% Calculate effect sizes (Mahalanobis distance) and save them for visualization
for i = 1:15000
    Y = data_l_conv(i, :);
    X = data_l_noconv(i, :);
    dif_avg = Y - X; % Compute the mean vector difference
    ver_cov = cov(squeeze(Mix_sample_L(i, :, :))'); % Compute covariance matrix for vertex i
    d = dif_avg * inv(ver_cov) * dif_avg'; % Calculate Mahalanobis distance for vertex i
    mahl(i) = d; % Store the effect size
end


save(data_dir_l, 'mahl'); % Save effect sizes for the left hippocampus