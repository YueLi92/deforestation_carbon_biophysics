%% absolute values
clear,clc;
cVeg_Ama = ncread('../cVeg_curve_defor_glob.nc','cVeg_Ama');
cVeg_Con = ncread('../cVeg_curve_defor_glob.nc','cVeg_Con');
cVeg_Asa = ncread('../cVeg_curve_defor_glob.nc','cVeg_Asa');
vegc = cat(3,cVeg_Ama,cVeg_Con,cVeg_Asa)*2; % *2 to offset the *0.5 to generate the data

treecover_Ama = ncread('../treecover_curve_defor_glob.nc','treecover_Ama');
treecover_Con = ncread('../treecover_curve_defor_glob.nc','treecover_Con');
treecover_Asa = ncread('../treecover_curve_defor_glob.nc','treecover_Asa');
tcc = cat(3,treecover_Ama,treecover_Con,treecover_Asa);
vegc = tcc*0.01.*vegc*0.8 + (1-tcc*0.01).*vegc*0.4;

for vi = 1 : 3
    vegc_crv = vegc(:,:,vi);
    nanmean(mean(vegc_crv(51:80,:),1) - vegc_crv(1,:))
    % plot
    figure('position',[ 337          95        1235         420]),
    subplot(1,2,1),
    modelname = {'BCC-CSM2-MR','CanESM2','CESM2','CNRM-ESM2-1','IPSL-CM6A-LR','GISS-E2-1-G','UKESM1-0-LL','MPI-ESM1-2-LR'};
%     yy1 = cat(2,vegc_crv(:,1:5),vegc_crv(:,7:8));
    yy1 = vegc_crv;
    p1 = plot(yy1,'LineWidth',1.5);
    box on
%     legend(modelname{:})
    xlabel('Years')
    ylabel('AGB (Mg C ha^{-1})')
    if(vi == 1)
        set(gca,'YLim',[0 140])
    else
        set(gca,'YLim',[0 120])
    end
    
    subplot(1,2,2),
    tcc_crv = tcc(:,:,vi);
    yy2 = tcc_crv;
    p2 = plot(yy2,'LineWidth',1.5);
    box on
%     legend(modelname{:})
    xlabel('Years')
    ylabel('Tree cover (%)')
    set(gca,'YLim',[0 100])


end

