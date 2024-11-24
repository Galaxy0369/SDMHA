% Calculate effect sizes for hippocampal vertices in the control group
clc;
clear;
%% Parameter settings
% Separately read the MMS of the left and right hippocampi for each group, 
% used to compute the average MMS for each vertex in the two groups
%{ %}
dir_L_conv = dir('G:\小宇的资料\纵向new\VVV\age\2\Adj_LH\HC\MMS\*.txt'); % Path to left hippocampus MMS files for the control group
dir_R_conv = dir('G:\小宇的资料\纵向new\VVV\age\2\Adj_RH\HC\MMS\*.txt'); % Path to right hippocampus MMS files for the control group
dir_L_noconv = dir('G:\小宇的资料\纵向new\VVV\age\2\Adj_LH\MCI\MMS\*.txt'); % Path to left hippocampus MMS files for the experimental group
dir_R_noconv = dir('G:\小宇的资料\纵向new\VVV\age\2\Adj_RH\MCI\MMS\*.txt'); % Path to right hippocampus MMS files for the experimental group

% Storage paths for the effect size vectors of left and right hippocampi
data_dir_l = ['G:\小宇的资料\纵向new\VVV\age\2\Mah_L(hip).mat'];
data_dir_r = ['G:\小宇的资料\纵向new\VVV\age\2\Mah_R(hip).mat'];

%% Compute the average MMS for each vertex in the two groups and save them
[data_l_conv, data_r_conv, data_l_noconv, data_r_noconv] = deal(zeros(15000, 4));
[dir_asc_l_conv, dir_asc_r_conv, dir_asc_l_noconv, dir_asc_r_noconv] = ...
    deal(sort_nat({dir_L_conv.name}), sort_nat({dir_R_conv.name}), sort_nat({dir_L_noconv.name}), sort_nat({dir_R_noconv.name})); 
% Sort the file names in ascending order and store as cell arrays

[i, j] = deal(length(dir_asc_l_conv), length(dir_asc_l_noconv)); 

for n = 1:i
    temp = load(dir_asc_l_conv{n});
    disp(dir_asc_l_conv{n} + " loaded");
    data_l_conv = data_l_conv + temp;

    temp = load(dir_asc_r_conv{n});
    disp(dir_asc_r_conv{n} + " loaded");
    data_r_conv = data_r_conv + temp;
end
data_l_conv = data_l_conv / n;
data_r_conv = data_r_conv / n;

for n = 1:j
    temp = load(dir_asc_l_noconv{n});
    disp(dir_asc_l_noconv{n} + " loaded");
    data_l_noconv = data_l_noconv + temp;

    temp = load(dir_asc_r_noconv{n});
    disp(dir_asc_r_noconv{n} + " loaded");
    data_r_noconv = data_r_noconv + temp;
end
data_l_noconv = data_l_noconv / n;
data_r_noconv = data_r_noconv / n;

%% Compute sample collections for covariance matrices
[Mix_sample_L_conv, Mix_sample_R_conv, Mix_sample_L_noconv, Mix_sample_R_noconv] = deal([]);
% Merge all samples for the control group into tensors
for n = 1:i
    temp = load(dir_asc_l_conv{n});
    Mix_sample_L_conv(:, :, n) = temp;

    temp = load(dir_asc_r_conv{n});
    Mix_sample_R_conv(:, :, n) = temp;
end
disp("All control group samples merged");

% Merge all samples for the experimental group into tensors
for n = 1:j
    temp = load(dir_asc_l_noconv{n});
    Mix_sample_L_noconv(:, :, n) = temp;

    temp = load(dir_asc_r_noconv{n});
    Mix_sample_R_noconv(:, :, n) = temp;
end
disp("All experimental group samples merged");

% Combine left and right hippocampus samples for both groups
Mix_sample_L = cat(3, Mix_sample_L_conv, Mix_sample_L_noconv);
Mix_sample_R = cat(3, Mix_sample_R_conv, Mix_sample_R_noconv);

%% Calculate effect sizes (Mahalanobis distance) and save them for visualization
for i = 1:15000
    Y = data_l_conv(i, :);
    X = data_l_noconv(i, :);
    dif_avg = Y - X; % Compute the mean vector difference
    ver_cov = cov(squeeze(Mix_sample_L(i, :, :))'); % Compute covariance matrix for vertex i
    d = dif_avg * inv(ver_cov) * dif_avg'; % Calculate Mahalanobis distance for vertex i
    mahl(i) = d; % Store the effect size
end

for i = 1:15000
    Y = data_r_conv(i, :);
    X = data_r_noconv(i, :);
    dif_avg = Y - X;
    ver_cov = cov(squeeze(Mix_sample_R(i, :, :))');
    d = dif_avg * inv(ver_cov) * dif_avg';
    mahr(i) = d;
end

save(data_dir_l, 'mahl'); % Save effect sizes for the left hippocampus
save(data_dir_r, 'mahr'); % Save effect sizes for the right hippocampus