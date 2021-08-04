%% 1st model, cVeg = a*MAP + b*MAT
% 2nd model, cVeg = a*MAP + b*MAT + c*P_amplitude + d*T_amplitude
% 3rd model, cVeg = a*MAP^c + b*MAT
clear,clc;
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR','Multimodel mean'};
load([path,'MAP_30yrmean_pattern.mat'])
climask = prannpic;

data_table = nan(12,4);
for it = 1 : 3
    if(it ==1)
        load([path,'MAP_30yrmean_pattern.mat'])
        prannpic = prannpic*365;
    elseif(it ==2)
        load([path,'MAP_30yramplitude_pattern.mat'])
        prannpic = pramppic*30;
    else
        load([path,'PRD_30yrmean_pattern.mat'])
        prannpic = prdpic*30;
    end
    
    for jt = 1 : 4
        if(jt == 1)
            load([path,'MAT_30yrmean_pattern.mat'])
            tasannpic = tasannpic-273.15;
        elseif(jt ==2)
            load([path,'MAT_30yramplitude_pattern.mat'])
            tasannpic = tasamppic;
        elseif(jt ==3)
            load([path,'MATmax_30yrmean_pattern.mat'])
            tasannpic = tasmaxannpic-273.15;
        else
            load([path,'VPD_30yrmean_pattern.mat'])
            tasannpic = vpdpic;
        end
        
        load([path,'Biomass_30yrmean_pattern_new.mat'])
        load([path,'treeFrac_30yrmean_pattern.mat'])
        
        
        prannpic(isnan(vegcannpic)) = nan;
        climask(isnan(vegcannpic)) = nan;
        tasannpic(isnan(vegcannpic)) = nan;
        vegcannpic = nanmean(vegcannpic,3);
        prannpicx = nanmean(prannpic,3);
        climaskx = nanmean(climask,3);
        tasannpic = nanmean(tasannpic,3);
        
        datac = vegcannpic(90-23:90+23, 1:360)*10;
        datax = prannpicx(90-23:90+23, 1:360);
        dataccc = climaskx(90-23:90+23, 1:360)*365;
        datay = tasannpic(90-23:90+23, 1:360);
        lmk = landmask(90-23:90+23,1:360);
        % datac(lmk ==0) = nan;
        % datax(lmk ==0) = nan;
        % datay(lmk ==0) = nan;
        datac(lmk <0.5) = nan;
        datax(lmk <0.5) = nan;
        datay(lmk <0.5) = nan;
        datax(isnan(datac)) = nan;
        datay(isnan(datac)) = nan;
        
        datax(dataccc<100) = nan;
        datay(isnan(datax)) = nan;
        datac(isnan(datax)) = nan;
        
        xx = datax(~isnan(datax));
        yy = datay(~isnan(datay));
        cc = datac(~isnan(datac));
        
        
        [b,bint,r,rint,stats] = regress(cc,[xx yy]);
        b,
        stats,
        b(1)*100/mean(cc)*100
        b(2)/mean(cc)*100
        sqrt(sum((b(1)*xx+b(2)*yy-cc).^2)/length(cc))
        
        data_table( (it-1)*4+jt, 1) = b(1);
        data_table( (it-1)*4+jt, 2) = b(2);
        data_table( (it-1)*4+jt, 3) = stats(1);
        data_table( (it-1)*4+jt, 4) = sqrt(sum((b(1)*xx+b(2)*yy-cc).^2)/length(cc));
    end
end

%% 2nd model, cVeg = a*MAP + b*MAT +c*MAP*MAT
% 2nd model, cVeg = a*MAP + b*MAT + c*P_amplitude + d*T_amplitude
% 3rd model, cVeg = a*MAP^c + b*MAT
clear,clc;
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
load([path,'treeFrac_30yrmean_pattern.mat'])
load([path,'Biomass_30yrmean_pattern.mat'])
load([path,'MAP_30yrmean_pattern.mat'])
load([path,'MAT_30yrmean_pattern.mat'])
modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR','Multimodel mean'};
prannpic(isnan(vegcannpic)) = nan;
tasannpic(isnan(vegcannpic)) = nan;
vegcannpic = nanmean(vegcannpic,3);
prannpic = nanmean(prannpic,3);
tasannpic = nanmean(tasannpic,3);

datac = vegcannpic(90-23:90+23, 1:360)*10;
datax = prannpic(90-23:90+23, 1:360)*365;
datay = tasannpic(90-23:90+23, 1:360)-273.15;
lmk = landmask(90-23:90+23,1:360);
% Experiments!!
% datac(lmk ==0) = nan;
% datax(lmk ==0) = nan;
% datay(lmk ==0) = nan;
datac(lmk <0.5) = nan;
datax(lmk <0.5) = nan;
datay(lmk <0.5) = nan;
datax(isnan(datac)) = nan;
datay(isnan(datac)) = nan;

datax(datax<100) = nan;
datay(isnan(datax)) = nan;
datac(isnan(datax)) = nan;

xx = datax(~isnan(datax));
yy = datay(~isnan(datay));
cc = datac(~isnan(datac));
xy = xx.*yy;

[b,bint,r,rint,stats] = regress(cc,[xx yy xy]);
b,
stats,
b(1)*100/mean(cc)*100
b(2)/mean(cc)*100
b(3)*100/mean(cc)*100
sqrt(sum((b(1)*xx+b(2)*yy+b(3)*xy-cc).^2)/length(cc))

save('regression_mode2.mmm.mat','b','stats');