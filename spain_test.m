clear;
clc;
close all; 

real_delta = xlsread('\Covid19.xlsx',5, 'E26 : E55'); % real daily increase number
real_delta = reshape(real_delta, 1, length(real_delta));

real_C = xlsread('\Covid19.xlsx',5, 'G26 : G55'); % real daily cured number 
real_C = reshape(real_C, 1, length(real_C));

real_data = xlsread('\Covid19.xlsx',5, 'D56 : D65'); % real total infected number 
real_data = reshape(real_data, 1, length(real_data));

kappa = kappa_factor(real_C, real_delta); % cure factor
disp(['from the real data, the kappa (cure) factor is ', num2str(kappa)]);
zeta = zeta_factor(real_delta); % infect factor
disp(['from the real data, the zeta (infect) factor is ', num2str(zeta)]);

initial_infected = 26429; % N_0^0
first_day_infected = real_delta(end); % delta_1^0
disp(['============== kappa = ', num2str(kappa), ', zeta = ', num2str(zeta),', predict from 3.15 to 3.31 ==============']);

for i = 1 : length(real_data)
    pred_total_infected_number = total_infected(initial_infected, first_day_infected, i, kappa, zeta);
    disp(['===== the day ', num2str(i), '=====']);
    disp(['the PREDICTION of total infected number on the day ', num2str(i),  ' in Italy is ', num2str(pred_total_infected_number)]);
    disp(['the REAL of total infected number on the day ', num2str(i),  ' in Italy is ', num2str(real_data(i))]);
    pred_data(i) = pred_total_infected_number;
end

error = pred_data - real_data;
average_error_italy = abs(mean(error./real_data));

x = 1 : length(real_data); 
figure
plot(x, pred_data , 'r-x', 'LineWidth', 1.5, 'MarkerSize', 6);
hold on
plot(x, real_data , 'k-*', 'LineWidth', 1.5, 'MarkerSize', 6);
leg = legend('Prediction from 3.22 to 3.31', 'Real data from 3.22 to 3.31');
set(leg, 'Location', 'NorthWest') 
title('Spain Prediction from 3.22 to 3.31')
xlabel('Day Sequence [n-th Day]', 'FontSize', 12, 'FontName', 'Arial');
ylabel('Number of Infected People', 'FontSize', 12, 'FontName', 'Arial');
str = {'zeta = ', num2str(zeta), 'kappa = ', num2str(kappa), 'average error = ', num2str(average_error_italy)};
text(3,8e4,str)
set(gca, 'color',  [1, 0.9, 0.8]);
grid on;
















