mean_value = 1; % Mean (mu) of the distribution
std_dev = 0.2;    % Standard deviation (sigma) of the distribution



num_samples = 600;
random_values = normrnd(mean_value, std_dev, num_samples, 1);

histogram(random_values, 50); % 50 bins
title('Histogram of Random Values from Normal Distribution');
xlabel('Value');
ylabel('Frequency');

% Check the mean and standard deviation of the generated data.
mean(random_values)
std(random_values)
