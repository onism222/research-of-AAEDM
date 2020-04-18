function [kappa_result] = kappa_factor(C, delta) % i = 1,...,U

U = length(C); 
kappa_result = (1/U) * sum((C+1)./(delta+1));

end