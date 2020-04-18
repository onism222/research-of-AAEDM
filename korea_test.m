clear;
close all; 
% Input data
% =================== read excel, 2.21 - 3.14 =================== 
real_delta_korea = xlsread('\AAEDM_new\Covid19.xlsx',1, 'E28 : E50'); % real daily increase number
real_delta_korea = reshape(real_delta_korea, 1, length(real_delta_korea));

real_C_korea = xlsread('\AAEDM_new\Covid19.xlsx',1, 'G28 : G50'); % real daily cured number 
real_C_korea = reshape(real_C_korea, 1, length(real_C_korea));
% =================== end =================== 

% =================== read excel, 3.15 - 3.31 =================== 
real_data_koera = xlsread('\AAEDM_new\Covid19.xlsx',1, 'D51 : D67'); % real total infected number 
real_data_koera = reshape(real_data_koera, 1, length(real_data_koera));
% =================== end =================== 

% Obtain parameters
% =================== obain zeta and kappa =================== 
kappa_korea = kappa_factor(real_C_korea, real_delta_korea); % cure factor, equation (2.5)
disp(['from the real data, the kappa (cure) factor is ', num2str(kappa_korea)]);
zeta_korea = zeta_factor(real_delta_korea); % infect factor, equation (2.7)
disp(['from the real data, the zeta (infect) factor is ', num2str(zeta_korea)]);
% =================== end =================== 
initial_infected_korea = 8086; %  the N_0^0 in equation (2.10)
first_day_infected_korea = real_delta_korea(end); %  the delta_1^0 in equation (2.10)

disp(['============== kappa = ', num2str(kappa_korea), ', zeta = ', num2str(zeta_korea),', let us predict from 3.15 to 3.31 ==============']);


% Predicting 
for i = 1 : length(real_data_koera)
    pred_total_infected_number_korea = total_infected(initial_infected_korea, first_day_infected_korea, i, kappa_korea, zeta_korea);
    disp(['===== the day ', num2str(i), '=====']);
    disp(['the PREDICTION of total infected number on the day ', num2str(i),  ' in Korea is ', num2str(floor(pred_total_infected_number_korea))]);
    disp(['the REAL of total infected number on the day ', num2str(i),  ' in Korea is ', num2str(real_data_koera(i))]);
    pred_data_korea(i) = pred_total_infected_number_korea;
end


% ======================= Average Error =======================
error_korea = pred_data_korea - real_data_koera;
average_error_korea = abs(mean(error_korea./real_data_koera));
%disp(['in Korea, if kappa = ', num2str(kappa_korea),  ', and zeta = ', num2str(zeta_korea), ', the Average Error is ', num2str(average_error_korea)]);
%======================= end =======================


%======================= NMSE =======================
%NMSE: Normalized Mean Square Error, NMSE
% NMSE_korea = norm(pred_data_korea - real_data_koera, 2)^2 / norm(real_data_koera, 2)^2;
% NMSE_dB_korea = 10 * log10(NMSE_korea);
% disp(['in Korea, if kappa = ', num2str(kappa_korea),  ', and zeta = ', num2str(zeta_korea), ', then the Average Error is ',...
%     num2str(average_error_korea), ' and the NMSE is ', num2str(NMSE_korea)]);
%======================= end =======================


% ======================= plot =======================
x_korea = 1 : length(real_data_koera); 
figure
plot(x_korea, pred_data_korea , 'r-x', 'LineWidth', 1.5, 'MarkerSize', 6);
hold on
plot(x_korea, real_data_koera , 'k-*', 'LineWidth', 1.5, 'MarkerSize', 6);
leg = legend('Prediction from 3.15 to 3.31', 'Real data from 3.15 to 3.31');
set(leg, 'Location', 'NorthWest') 
title('Korea Prediction from 3.15 to 3.31')
xlabel('Day Sequence [n-th Day]', 'FontSize', 12, 'FontName', 'Arial');
ylabel('Number of Infected People', 'FontSize', 12, 'FontName', 'Arial');
str = {'zeta = ', num2str(zeta_korea), 'kappa = ', num2str(kappa_korea), 'average error = ', num2str(average_error_korea)};
text(4,10000,str)
set(gca, 'color',  [1, 0.9, 0.8]);
grid on;
%======================= end =======================















