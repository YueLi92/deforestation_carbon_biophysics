%% Treecover process
% treecover process
clear,clc;
ncdisp E:\Data\landcover\ESA_CCI\C3S-LC-L4-LCCS-Map-300m-P1Y-2017-v2.1.1.nc
filename = 'E:\Data\landcover\ESA_CCI\C3S-LC-L4-LCCS-Map-300m-P1Y-2017-v2.1.1.nc';
flag_meanings       = {'no_data', 'cropland_rainfed', 'cropland_rainfed_herbaceous_cover', ...
    'cropland_rainfed_tree_or_shrub_cover', 'cropland_irrigated', 'mosaic_cropland', ...
    'mosaic_natural_vegetation', 'tree_broadleaved_evergreen_closed_to_open',...
    'tree_broadleaved_deciduous_closed_to_open', 'tree_broadleaved_deciduous_closed', ...
    'tree_broadleaved_deciduous_open', 'tree_needleleaved_evergreen_closed_to_open',...
    'tree_needleleaved_evergreen_closed', 'tree_needleleaved_evergreen_open',...
    'tree_needleleaved_deciduous_closed_to_open', 'tree_needleleaved_deciduous_closed',...
    'tree_needleleaved_deciduous_open', 'tree_mixed', 'mosaic_tree_and_shrub',...
    'mosaic_herbaceous' ,'shrubland', 'shrubland_evergreen', 'shrubland_deciduous',...
    'grassland', 'lichens_and_mosses', 'sparse_vegetation', 'sparse_tree', 'sparse_shrub',...
    'sparse_herbaceous', 'tree_cover_flooded_fresh_or_brakish_water', 'tree_cover_flooded_saline_water',...
    'shrub_or_herbaceous_cover_flooded', 'urban', 'bare_areas', 'bare_areas_consolidated', ...
    'bare_areas_unconsolidated', 'water' ,'snow_and_ice'}';
flag_values         = [0   10   11   12   20   30   40   50   60   61   62   70   71   72   80   81   82   90  100  110  120  121  122  130  140  150  151  152  153  160  170  180  190  200  201  202  210  220]';
treeid = [8:19];
lat = ncread(filename, 'lat');
lon = ncread(filename, 'lon');

treecover = nan(46, 360); % 1deg
for i = 1 : 46
    i,
    tc = ncread(filename,'lccs_class',[1 360*67+360*(i-1)+1 1],[129600 360 1],[1 1 1]);
    for j = 1 : 360
        tmp = tc( (j-1)*360+1 : j*360,:);
        sz = size(tmp);
        treecover(i,j) = length(tmp(tmp >=flag_values(8) & tmp <=flag_values(18))) / (sz(1)*sz(2))*100;
    end
end

save treecover_tropics.mat treecover


%% MODIS VCF in 2017
clear,clc;
path = 'E:\Data\landcover\MODIS_VCF\';
filename = [path,'MOD44B.006_250m_aid0001.nc']; % 30oS-30oN, 250m, 1deg = 480 pixels * 480 pixels
ncdisp(filename)
lat = ncread(filename,'lat');
lon = ncread(filename,'lon');

treecover = nan(46, 360); % 1deg
for i = 1 : 46
    i,
    tc = ncread(filename,'Percent_Tree_Cover',[1 480*7+480*(i-1)+1 1],[172800 480 1],[1 1 1]);
    for j = 1 : 360
        tmp = tc( (j-1)*480+1 : j*480,:);
        tmp = double(tmp);
        tmp(tmp<0 | tmp>100) = nan;
        tmp = tmp(~isnan(tmp));
        if(isempty(tmp))
            continue;
        end
        treecover(i,j) = mean(tmp);
    end
end

save treecover_tropics_modis.mat treecover



%% Recognize tree cover - AGB relationship -Obs
% Please use MODIS VCF
clear,clc;
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
lmask = landmask;
landmask(:,1:180) = lmask(:,181:360);
landmask(:,181:360) = lmask(:,1:180);
landmask = landmask(68:67+46,:);
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\biomass_tropics_1deg.mat
load D:\Study\rainfall_deforestation\2021.01.13.AGB_ratio_treecover\treecover_tropics_modis.mat
biomass(landmask< 0.5) = nan;
treecover(landmask< 0.5) = nan;
biomass = biomass*0.5;
% figure,imagesc(biomass)
% figure,imagesc(treecover)

xx = treecover(~isnan(treecover));
yy = biomass(~isnan(biomass));
% figure,imagesc(landmask)
%only consider pixels within Amazon, Congo and Asia
amabasin = rot90(ncread('D:\Study\rainfall_deforestation\basin_map1deg.nc','cell_area'));
amabass = amabasin;
amabasin(:,1:180) = amabass(:,181:360);
amabasin(:,181:360) = amabass(:,1:180);
amabasin = amabasin(68:67+46,:);
% figure,imagesc(amabasin)
color = [1 0.6 0.2; 0.6 1 0.2; 0.2 0.6 1];
x = [];
y = [];
xx = treecover(amabasin ==259);
yy = biomass(amabasin ==259);
x = xx;
y = yy;
figure,
reg1 = regstats(yy,xx);
p1 = scatter(xx,yy,20,'MarkerFaceColor',color(1,:),'MarkerEdgeColor','none');
%     line([0 0],[-400 400],'LineStyle',':','Color','k')
%     line([-400 400],[0 0],'LineStyle',':','Color','k')
    box on
    
xx = treecover(amabasin ==243);
yy = biomass(amabasin ==243);
x = [x; xx];
y = [y; yy];
hold on,
reg2 = regstats(yy,xx);
p2 = scatter(xx,yy,20,'MarkerFaceColor',color(2,:),'MarkerEdgeColor','none');


treecover(:,1:180+95) = nan;
treecover(:,180+155:end) = nan;
treecover(1:13,:) = nan;
treecover(34:end,:) = nan;

biomass(:,1:180+95) = nan;
biomass(:,180+155:end) = nan;
biomass(1:13,:) = nan;
biomass(34:end,:) = nan;

xx = treecover(~isnan(treecover));
yy = biomass(~isnan(biomass));
x = [x; xx];
y = [y; yy];
hold on,
reg3 = regstats(yy,xx);
p3 = scatter(xx,yy,20,'MarkerFaceColor',color(3,:),'MarkerEdgeColor','none');
reg = regstats(y,x);

set(gca,'YLim',[0 170],'XLim',[0 90],'FontSize',13,'LineWidth',1.2);
xxx = [5 : 85]';
yy1 = xxx*reg1.beta(2)+reg1.beta(1);
yy2 = xxx*reg2.beta(2)+reg2.beta(1);
yy3 = xxx*reg3.beta(2)+reg3.beta(1);
yyy = xxx*reg.beta(2)+reg.beta(1);
hold on,
% fp1 = plot(xxx,yy1,'--','Color',color(1,:),'LineWidth',3.5);
% hold on,
% fp2 = plot(xxx,yy2,'--','Color',color(2,:),'LineWidth',3.5);
% hold on,
% fp3 = plot(xxx,yy3,'--','Color',color(3,:),'LineWidth',3.5);
% hold on,
fp = plot(xxx,yyy,'k--','LineWidth',2.5);
text(5,160,['Amazon: ',num2str(round(reg1.beta(2)*10)),'Mg C ha^{-1} /10%'],'Color',color(1,:),'FontSize',13)
text(5,148,['Congo : ',num2str(round(reg2.beta(2)*10)),'Mg C ha^{-1} /10%'],'Color',color(2,:),'FontSize',13)
text(5,136,['TropAsia: ',num2str(round(reg3.beta(2)*10)),'Mg C ha^{-1} /10%'],'Color',color(3,:),'FontSize',13)
text(5,124,['Tropics: ',num2str(round(reg.beta(2)*10)),'Mg C ha^{-1} /10%'],'Color','k','FontSize',13)
xlabel('Tree cover fraction (%)','FontSize',13);
ylabel('AGB (Mg C ha^{-1})','FontSize',13);
%%
load D:\Study\rainfall_deforestation\2020.06.15.obs_biomass_process\biomass_tropics_1deg.mat
load D:\Study\rainfall_deforestation\2021.01.13.AGB_ratio_treecover\treecover_tropics_modis.mat
biomass(landmask==0) = nan;
treecover(landmask==0) = nan;

tcprdct = treecover*regs.beta(1)+regs.beta(2);
% figure,imagesc(biomass - tcprdct)
% colorbar



%% Recognize tree cover - AGB relationship - CMIP6
% Please use MODIS VCF
clear,clc;
path = ['D:\Study\rainfall_deforestation\2020.05.23.biomass_pr_relation\l1.prepare_data\'];
load([path,'landmask.mat'])
load([path,'treeFrac_30yrmean_pattern.mat'])
load([path,'Biomass_30yrmean_pattern_new.mat'])
biomass = nanmean(vegcannpic,3);
treecover = nanmean(treeFracpic,3);
landmask = landmask(68:67+46,:);
biomass = biomass(68:67+46,:);
treecover = treecover(68:67+46,:);

biomass(landmask< 0.5) = nan;
treecover(landmask< 0.5) = nan;
biomass = biomass*10;
% figure,imagesc(biomass)
% figure,imagesc(treecover)
% figure,imagesc(landmask)
%

xx = treecover(~isnan(treecover));
yy = biomass(~isnan(biomass));
% figure,imagesc(landmask)
%only consider pixels within Amazon, Congo and Asia
amabasin = rot90(ncread('D:\Study\rainfall_deforestation\basin_map1deg.nc','cell_area'));
amabass = amabasin;
% amabasin(:,1:180) = amabass(:,181:360);
% amabasin(:,181:360) = amabass(:,1:180);
amabasin = amabasin(68:67+46,:);
%
% figure,imagesc(amabasin)
color = [1 0.6 0.2; 0.6 1 0.2; 0.2 0.6 1];
x = [];
y = [];
xx = treecover(amabasin ==259);
yy = biomass(amabasin ==259);
x = xx;
y = yy;
figure,
reg1 = regstats(yy,xx);
p1 = scatter(xx,yy,20,'MarkerFaceColor',color(1,:),'MarkerEdgeColor','none');
%     line([0 0],[-400 400],'LineStyle',':','Color','k')
%     line([-400 400],[0 0],'LineStyle',':','Color','k')
    box on
    
xx = treecover(amabasin ==243);
yy = biomass(amabasin ==243);
x = [x; xx];
y = [y; yy];
hold on,
reg2 = regstats(yy,xx);
p2 = scatter(xx,yy,20,'MarkerFaceColor',color(2,:),'MarkerEdgeColor','none');


treecover(:,1:95) = nan;
treecover(:,155:end) = nan;
treecover(1:13,:) = nan;
treecover(34:end,:) = nan;

biomass(:,1:95) = nan;
biomass(:,155:end) = nan;
biomass(1:13,:) = nan;
biomass(34:end,:) = nan;

xx = treecover(~isnan(treecover));
yy = biomass(~isnan(biomass));
x = [x; xx];
y = [y; yy];
hold on,
reg3 = regstats(yy,xx);
p3 = scatter(xx,yy,20,'MarkerFaceColor',color(3,:),'MarkerEdgeColor','none');
reg = regstats(y,x);

set(gca,'YLim',[0 170],'XLim',[0 100],'FontSize',13,'LineWidth',1.2);
xxx = [5 : 85]';
yy1 = xxx*reg1.beta(2)+reg1.beta(1);
yy2 = xxx*reg2.beta(2)+reg2.beta(1);
yy3 = xxx*reg3.beta(2)+reg3.beta(1);
yyy = xxx*reg.beta(2)+reg.beta(1);
hold on,
% fp1 = plot(xxx,yy1,'--','Color',color(1,:),'LineWidth',3.5);
% hold on,
% fp2 = plot(xxx,yy2,'--','Color',color(2,:),'LineWidth',3.5);
% hold on,
% fp3 = plot(xxx,yy3,'--','Color',color(3,:),'LineWidth',3.5);
% hold on,
fp = plot(xxx,yyy,'k--','LineWidth',2.5);
text(5,160,['Amazon: ',num2str(round(reg1.beta(2)*10)),'Mg C ha^{-1} /10%'],'Color',color(1,:),'FontSize',13)
text(5,148,['Congo : ',num2str(round(reg2.beta(2)*10)),'Mg C ha^{-1} /10%'],'Color',color(2,:),'FontSize',13)
text(5,136,['TropAsia: ',num2str(round(reg3.beta(2)*10)),'Mg C ha^{-1} /10%'],'Color',color(3,:),'FontSize',13)
text(5,124,['Tropics: ',num2str(round(reg.beta(2)*10)),'Mg C ha^{-1} /10%'],'Color','k','FontSize',13)
xlabel('Tree cover fraction (%)','FontSize',13);
ylabel('AGB (Mg C ha^{-1})','FontSize',13);