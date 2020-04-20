clear;
clc;
close all; 

real_delta = xlsread('Covid19.xlsx',3, 'E27 : E56'); % real daily increase number 2.21 - 3.21
real_delta = reshape(real_delta, 1, length(real_delta));

real_C = xlsread('Covid19.xlsx',3, 'G27 : G56'); % real daily cured number 2.21 - 3.21
real_C = reshape(real_C, 1, length(real_C));

n = length(real_delta); % length(real_delta) == length(real_C)
kappa_seq = zeros(1, n);
zeta_seq = zeros(1, n);

for k = 1 :  n
kappa = kappa_factor(real_C(1 : k), real_delta(1 : k)); % equation (2.5)
kappa_seq(k) = kappa;
disp(['In the ', num2str(k),' th day, the kappa factor is ', num2str(kappa)]);
zeta = zeta_factor(real_delta(1 : k)); % equation (2.7)
zeta_seq(k) = zeta;
disp(['In the ', num2str(k),' th day, the zeta factor is ', num2str(zeta)]);
end
disp(['============== kappa = ', num2str(kappa_seq), ', zeta = ', num2str(zeta_seq),' ==============']);

x = 1 : n; 
figure
plot(x, kappa_seq , 'r-x', 'LineWidth', 1.5, 'MarkerSize', 6);
hold on
plot(x, zeta_seq , 'k-*', 'LineWidth', 1.5, 'MarkerSize', 6);
leg = legend('kappa from 2.21 to 3.21', 'zeta from 2.21 to 3.21');
set(leg, 'Location', 'NorthEast') 
title('UK kappa and zeta from 2.21 to 3.21')
xlabel('Day Sequence [n-th Day]', 'FontSize', 12, 'FontName', 'Arial');
% ylabel('Number of Infected People', 'FontSize', 12, 'FontName', 'Arial');
% str = {'zeta = ', num2str(zeta), 'kappa = ', num2str(kappa), 'average error = ', num2str(average_error_italy)};
% text(3, 2e4, str);
set(gca, 'color',  [1, 0.9, 0.8]);
grid on; 
















