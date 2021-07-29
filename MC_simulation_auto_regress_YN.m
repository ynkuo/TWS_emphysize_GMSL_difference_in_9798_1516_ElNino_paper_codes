function [MC_sample y NOISE] = MC_simulation_auto_regress_YN(data_length,a,var_noise,gm,irr_time)
%% ---------------------------------------------------
%  Monte Carlo simulation for the uncertainty in figure 1a, 
%  the difference of 97/98 and 15/16 GMSL and TWS difference
%  in text.
%% ---------------------------------------------------
MC_sample = zeros(data_length,irr_time);
y = zeros(data_length,irr_time);
NOISE = zeros(data_length,irr_time);
for t = 1:irr_time
    MC_sample(:,t) = normrnd(gm(1),gm(2),[data_length,1]);%random(gm,data_length);
    noise = normrnd(var_noise(1),var_noise(2),[data_length,1]);

    y(:,t) = MC_sample(:,t);
    y(1,t) = y(1,t);
    y(2,t) = a(1)*y(1,t);
    y(3,t) = a(1)*y(2,t)+a(2)*y(1,t);
    for tt = 4:data_length
        y(tt,t) = a(1)*y(tt-1,t)+a(2)*y(tt-2,t)+a(3)*y(tt-3,t);
    end
    y(:,t) = y(:,t)+noise;
    NOISE(:,t) = noise;
end