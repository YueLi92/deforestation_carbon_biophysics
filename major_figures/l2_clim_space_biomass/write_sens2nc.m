%% write sens to nc
clear,clc;
ncdisp sensitivity_obs_mod.nc
load obs_sens_para.mat
ncwrite('sensitivity_obs_mod.nc','bsens_obs',bsens);

load mod_sens_para.mat
ncwrite('sensitivity_obs_mod.nc','bsens_mod',bsens);