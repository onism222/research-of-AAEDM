function [zeta_result] =zeta_factor(delta)

U = length(delta); 
delta_before = delta(1 : end-1); 
delta_now = delta(2 : end);
zeta_result = (1/(U-1)) * sum((delta_now+1)./(delta_before+1));

end
