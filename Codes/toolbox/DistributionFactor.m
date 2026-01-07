function Distribution_Factor = DistributionFactor(mean, dev)
% The function is based normrnd function from Statistics and Machine
% Learning Toolbox
% 
% Generate a size distribution factor for rescaling the particle, 
% the factor is generated following normal distribution,
% the default mean value is set to 1 and deviation is set to 0.2,
% while the lower boundary is 0.5 and upper boundary is 1.5
% -------------------------
% INPUTS
%  mean: [double] Mean of the size distribution factor
%  dev: [double] deviation of the size distribution factor
% OUTPUTS
%  Distribution_Factor: [double] 
% -------------------------
% Developed by Weijia Gong under the supervision of 
% Prof. Williams Agyei Appiah
% University of Agder, 2025

mean_value = mean; % Mean value of the distribution
std_dev = dev;     % Standard deviation of the distribution

lower_bound = 0.5;
upper_bound = 1.5;

% Generate random numbers until one falls within the desired range

while true
    random_value = normrnd(mean_value, std_dev);
    if random_value >= lower_bound && random_value <= upper_bound
        break; % Exit the loop when a valid value is found
    end
end

Distribution_Factor = random_value;

end