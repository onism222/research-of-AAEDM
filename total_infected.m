function [total_infected_result] = total_infected(initial_infected, first_day_infected, d, kappa, zeta)

total_infected_result = initial_infected + first_day_infected * ((((1 - kappa) * zeta).^(d+1) - 1)/(((1 - kappa) * zeta) - 1));

end