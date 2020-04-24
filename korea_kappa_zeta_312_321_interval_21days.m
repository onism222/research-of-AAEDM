clear;
clc;
close all; 

real_delta = xlsread('Covid19.xlsx',1, 'E27 : E57'); % real daily increase number 2.20 - 3.21
real_delta = reshape(real_delta, 1, length(real_delta));

real_C = xlsread('Covid19.xlsx',1, 'G27 : G57'); % real daily cured number 2.20 - 3.21
real_C = reshape(real_C, 1, length(real_C));

n = 10; % we just want to obtain the kappa and zeta from 3.12 to 3.21
kappa_seq = zeros(1, n);
zeta_seq = zeros(1, n);

for k = 1 :  n
    
kappa = kappa_factor(real_C(k : 20 + k), real_delta(k : 20+k)); % equation (2.5)
kappa_seq(k) = kappa;
disp(['In the ', num2str(k),' th day, the kappa factor is ', num2str(kappa)]);
zeta = zeta_factor(real_delta(k : 20+k)); % equation (2.7)
zeta_seq(k) = zeta;
disp(['In the ', num2str(k),' th day, the zeta factor is ', num2str(zeta)]);
end
disp(['============== kappa = ', num2str(kappa_seq), ', zeta = ', num2str(zeta_seq),' ==============']);

x = 1 : n; 
figure
plot(x, kappa_seq , 'r-x', 'LineWidth', 1.5, 'MarkerSize', 6);
hold on
plot(x, zeta_seq , 'k-*', 'LineWidth', 1.5, 'MarkerSize', 6);
leg = legend('kappa from 3.12 to 3.21', 'zeta from 3.12 to 3.21');
set(leg, 'Location', 'SouthEast') 
title('Korea kappa and zeta from 3.12 to 3.21, fixed interval = 21 days ')
xlabel('Day Sequence [n-th Day]', 'FontSize', 12, 'FontName', 'Arial');
set(gca, 'color',  [0.94118, 1, 1]);
grid on; 
















