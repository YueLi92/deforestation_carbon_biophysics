;***************************************
;* Code to draw the precipitation & circulation
;* over the Amazon & Sahel regions
;* by Yue Li 2019.10.10
;***************************************
;---Load the NCL file that contains the gsn_* functions used below.
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

;------ 1st functionto calculate the sum of water variable
undef("water_sum")
function water_sum (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric,area:numeric, filename1:string, scaleFactor:numeric)
begin
  
  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  dimz = dimsizes(area)
  var_mth = new((/30,dimz(0),dimz(1)/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    tmp!0 = "lat"
    tmp!1 = "lon"
    tmp&lat = var&lat
    tmp&lon = var&lon
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end
;-------------------------------------------------------------

;------ 1st functionto calculate the sum of water variable
undef("water_sum_cru")
function water_sum_cru (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  var_mth = new((/30,360,720/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end
;-------------------------------------------------------------
;------ 1st functionto calculate the sum of water variable
undef("water_sum_cnfoc")
function water_sum_cnfoc (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  ttt = f1->$varname$
  var = todouble(ttt*ttt@scale_factor+ttt@add_offset)
  var!0 = "time"
  var&time = ttt&time
  var!1 = "lat"
  var&lat = ttt&lat
  var!2 = "lon"
  var&lon = ttt&lon
  yr = 1982
  var_mth = new((/30,400,700/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

;------ 1st functionto calculate the sum of water variable
undef("water_sum_era")
function water_sum_era (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  var@_FillValue = 1e+20
  yr = 1982
  var_mth = new((/30,91,180/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    
    tmp!0 = "lat"
    tmp!1 = "lon"
    tmp&lat = var&lat
    tmp&lon = var&lon
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end
;-------------------------------------------------------------
undef("water_sum_era2")
function water_sum_era2 (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  ttt = f1->$varname$
  var = todouble(ttt*ttt@scale_factor+ttt@add_offset)
  var@_FillValue = 1e+20
  kt = -32767*ttt@scale_factor+ttt@add_offset
  var = where(var .le. kt, var@_FillValue, var)
  yr = 1982
  var_mth = new((/30,241,480/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp1 = dim_sum_n_Wrap(var((yr-yearref)*12*4+(beginmth-1)*4+1-1:(yr-yearref)*12*4+endmth*4-1,:,:),0)

    tmp = tmp1/(endmth-beginmth+1)
    tmp!0 = "lat"
    tmp!1 = "lon"
    tmp&lat = ttt&latitude
    tmp&lon = ttt&longitude
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

;------ 1st functionto calculate the sum of water variable
undef("water_sum_era5_avg")
function water_sum_era5_avg (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  ;var@_FillValue = 1e+20
  if(beginmth .eq. 12)
    var(2,:,:) = var(11,:,:)
    tmp = dim_avg_n_Wrap(var(0:2,:,:),0)
  else
    tmp = dim_avg_n_Wrap(var(beginmth-1:endmth-1,:,:),0)
  end if

  tmp = tmp*scaleFactor
  return ([/tmp/])
end

;------ 1st functionto calculate the sum of water variable
undef("water_sum_era5_vert_avg")
function water_sum_era5_vert_avg (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  ;var@_FillValue = 1e+20
  if(beginmth .eq. 12)
    var(2,:,:,:) = var(11,:,:,:)
    tmp = dim_avg_n_Wrap(var(0:2,7,:,:),0) ; set pres level to 7 as '850hPa'
  else
    tmp = dim_avg_n_Wrap(var(beginmth-1:endmth-1,7,:,:),0)
  end if

  tmp = tmp*scaleFactor
  return ([/tmp/])
end


undef("water_sum_era_uv10")
function water_sum_era_uv10 (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  ttt = f1->$varname$
  var = todouble(ttt*ttt@scale_factor+ttt@add_offset)
  var@_FillValue = 1e+20
  kt = -32767*ttt@scale_factor+ttt@add_offset
  var = where(var .le. kt, var@_FillValue, var)
  yr = 1982
  var_mth = new((/30,241,480/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_sum_n_Wrap(var((yr-yearref)*12+(beginmth-1):(yr-yearref)*12+endmth-1,:,:),0)
    tmp!0 = "lat"
    tmp!1 = "lon"
    tmp&lat = ttt&latitude
    tmp&lon = ttt&longitude
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp = tmp*scaleFactor
    
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp
    delete(tmp)
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

undef("water_sum_merra")
function water_sum_merra (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  var_mth = new((/30,361,540/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp2 = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    ;a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
    ;lsdata = a->LSMASK
    ;lsm = landsea_mask(lsdata,tmp&lat,tmp&lon)
    ;tmp = mask(tmp,lsm.eq.0,False)
    ;tmp = mask(tmp,lsm.eq.4,False)
    ;tmp = mask(tmp,lsm.eq.2,False)
    ;area = mask(area,lsm.eq.0,False)
    ;area = mask(area,lsm.eq.4,False)
    ;area = mask(area,lsm.eq.2,False)
    tmp2 = tmp2*scaleFactor
    tmp2!0 = "lat"
    tmp2!1 = "lon"
    tmp2&lat = var&YDim
    tmp2&lon = var&XDim
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp2
    delete(tmp2)
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

undef("water_sum_ncep")
function water_sum_ncep (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  var_mth = new((/30,94,192/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp2 = dim_avg_n_Wrap(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:),0)
    tmp2 = tmp2*scaleFactor
    tmp2!0 = "lat"
    tmp2!1 = "lon"
    tmp2&lat = var&lat
    tmp2&lon = var&lon
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp2
    delete(tmp2)
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end

undef("water_sum_ncep2")
function water_sum_ncep2 (varname:string, beginmth:numeric,endmth:numeric, yearref:numeric, filename1:string, scaleFactor:numeric)
begin

  f1 = addfile(filename1,"r")
  var = f1->$varname$
  yr = 1982
  var_mth = new((/30,73,144/), typeof(var),var@_FillValue)
  ;var_mth_sum = new((/12/), typeof(var), var@_FillValue)
  do while(yr.le.2011)
    tmp = dim_avg_n(var((yr-yearref)*12+beginmth-1:(yr-yearref)*12+endmth-1,:,:,:),0)
    tmp = tmp*scaleFactor
    tmp2 = rm_single_dims(tmp)
    ;print(tmp2)
    tmp2!0 = "lat"
    tmp2!1 = "lon"
    tmp2&lat = var&lat
    tmp2&lon = var&lon
    ;var_mth_sum(mth) = dim_sum_n(dim_sum_n(tmp*area,1),0)/dim_sum_n(dim_sum_n(area,1),0)
    var_mth(yr-1982,:,:) = tmp2
    delete(tmp2)
    yr = yr + 1
  end do
  return ([/var_mth/])
  ;return ([/var_mth_sum,var_mth/])
end


undef("vector_plot")
function vector_plot(nb:string)
begin
  res = True
  res@gsnDraw = False
  res@gsnFrame = False
  res_vc                            = res
  res_vc@vcGlyphStyle               = "LineArrow"
  res_vc@vcLineArrowThicknessF      = 0.8
  res_vc@vcMinDistanceF             = 0.04
  res_vc@vcRefLengthF               = 0.05

;;wind barb resources don't apply
;;      res_vc@vcGlyphStyle               = "WindBarb"
;;      res_vc@vcWindBarbLineThicknessF   = 5
;;      res_vc@vcWindBarbColor            = "Gray40"

  res_vc@vcRefAnnoOn               = True
  res_vc@vcRefMagnitudeF           = 1.5
  res_vc@vcRefAnnoString1          = "1.5m/s"
  res_vc@vcRefAnnoSide             = "Top"
  res_vc@vcRefAnnoString2On        = False
  res_vc@vcRefAnnoPerimOn          = False
  res_vc@vcRefAnnoOrthogonalPosF   = -0.05
  res_vc@vcRefAnnoParallelPosF     = 1
  res_vc@vcRefAnnoBackgroundColor  = "White"
  res_vc@vcVectorDrawOrder         = "PostDraw"
  res_vc@gsnRightString            = ""
  res_vc@vcLineArrowColor          = "Red"
  res_vc@vcGlyphStyle              = "CurlyVector"
  return(res_vc)
end

;-------2 nd function to create original plot
undef("pattern_plot")
function pattern_plot (nb:string, varunit:string, PaletteColor:string, levelmode:string,levels:numeric, varname:string)
begin
  res = True
  res@gsnDraw = False
  res@gsnFrame = False
  res@gsnCenterString = "";Timescale_name
  ;res@gsnRightString = varunit
  res@gsnLeftString = varname
  res@gsnLeftStringFontColor = "black"
  res@gsnPaperOrientation = "portrait"

  ;res@gsnRightString = "Jan_1982_Veg3"
  res@cnFillPalette = PaletteColor
  res@cnFillOn = True
  res@tiMainString = "";Mainstring_name
  res@cnLevelSelectionMode = levelmode
  res@cnLevels = levels
  res@cnLinesOn = False

  res@vpWidthF = 0.6
  res@vpHeightF = 0.3

  res@mpFillOn = True
  res@mpOutlineOn = True
  res@mpGeophysicalLineColor = "Gray70"
  res@mpLandFillColor = "Gray90"
  res@mpMaxLatF = 23
  res@mpMinLatF = -23
  res@mpMaxLonF = -30
  res@mpMinLonF = -90
  res@tmXBValues = (/-80,-60,-40,-20,0,20,40,60,80,100,120,140,160/)
  res@tmXBLabels = (/"80~S~o~N~W","60~S~o~N~W","40~S~o~N~W","20~S~o~N~W","0~S~o~N~","20~S~o~N~E","40~S~o~N~E","60~S~o~N~E","80~S~o~N~E","100~S~o~N~E","120~S~o~N~E","140~S~o~N~E","160~S~o~N~E"/)
  res@tmYLValues = (/-20,0,20/)
  res@tmYLLabels = (/"20~S~o~N~S","0~S~o~N~","20~S~o~N~N"/)
  res@tmXBLabelFontHeightF = 0.014
  res@tmYLLabelFontHeightF = 0.014

  res@mpDataBaseVersion = "Ncarg4_1"
  res@mpDataSetName = "Earth..4"
  ;res@mpOutlineSpecifiers = (/"China","Taiwan"/)
  res@mpGeophysicalLineThicknessF = 1
  res@mpNationalLineThicknessF    = 1

  res@pmLabelBarWidthF = 0.05
  res@pmLabelBarHeightF = 0.28
  ;res@pmLabelBarOrthogonalPosF = 0.15
  res@lbTitleString    = varunit
  res@lbOrientation = "vertical"
  res@lbTitleFontHeightF = 0.014
  res@lbLabelFontHeightF = 0.014
  res@lbTitlePosition = "Right"
  res@lbTitleAngleF = 90.
  res@lbTitleDirection = "Across"
  ;res@lbBoxEndCapStyle = "TriangleBothEnds"
  res@lbLabelBarOn = False
  res@tmXBOn            = False
  res@tmYLOn            = False
  res@tmXTOn            = False
  res@tmYROn            = False
  res@cnLineLabelInterval   = 0
  res@lbPerimOn         = False
  res@lbBoxLinesOn = False

if(nb .eq. "e") then
    res@gsnAddCyclic = False
  end if
  return (res)
;draw(mmap)
;frame(wks)
end

undef("pattern_plot2")
function pattern_plot2 (nb:string, varunit:string, PaletteColor:string, levelmode:string,levels:numeric, varname:string)
begin
  res = True
  res@gsnDraw = False
  res@gsnFrame = False
  res@gsnPaperOrientation = "portrait"

  res@cnFillPalette = PaletteColor
  res@cnFillOn = False
  res@cnLevelSelectionMode = "ExplicitLevels"
  res@cnLevels = levels
  res@cnLinesOn = True
  res@cnLineColor = "green"
  res@cnLineLabelDensityF = 3.0

  res@vpWidthF = 0.6
  res@vpHeightF = 0.3

  res@mpFillOn = False

  if(nb .eq. "e") then
    res@gsnAddCyclic = False
  end if
  return (res)
;draw(mmap)
;frame(wks)
end

undef("get_color")
function get_color (value:numeric)
begin
  if(value .le. -1) then
    color=(/165., 0., 33./)
  else if(value .ge. -1 .and. value .lt. -0.8) then
    color=(/246., 38., 52./)
  else if(value .ge. -0.8 .and. value .lt. -0.6) then
    color=(/255., 61., 61./)
  else if(value .ge. -0.6 .and. value .lt. -0.4) then
    color=(/255., 172., 117./)
  else if(value .ge. -0.4 .and. value .lt. -0.2) then
    color=(/255., 214., 153./)
  else if(value .ge. -0.2 .and. value .lt. 0) then
    color=(/255., 255., 233./)
  else if(value .ge. 0 .and. value .lt. 0.2) then
    color=(/233., 255., 255./)
  else if(value .ge. 0.2 .and. value .lt. 0.4) then
    color=(/153., 233., 255./)
  else if(value .ge. 0.4 .and. value .lt. 0.6) then
    color=(/117., 211., 255./)
  else if(value .ge. 0.6 .and. value .lt. 0.8) then
    color=(/61., 135., 255./)
  else if(value .ge. 0.8 .and. value .lt. 1) then
    color=(/40., 86., 255./)
  else
    color=(/35., 0., 216./)
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  end if
  color = color/255
  return(color)
end

undef("Biomass_prediction")
function Biomass_prediction (xtp:numeric, xt:numeric, mat_ama:numeric, mat_con:numeric, mat_asa:numeric, flag:numeric, mi:numeric)
begin
  if(mi .ge. 6) then
    vi = mi -1
  else
    vi = mi
  end if
  yt = new((/180,360/),double)

  if(flag .eq. 1) then ; TREECOVER
    tp1 = xt(66:113,275:330)   ; SouthAmerica, lat:-23 ~ 23; 275 ~ 330
    yt(66:113,275:330) = mat_ama(6, vi)*tp1
    tp21 = xt(66:113,340:359) ; West Africa
    yt(66:113,340:359) = mat_con(6, vi)*tp21
    tp22 = xt(66:113,0:49) ; Mid-East Africa
    yt(66:113,0:49) = mat_con(6, vi)*tp22
    tp3 = xt(66:113,70:160); Southeast Asia
    yt(66:113,70:160) = mat_asa(6,vi)*tp3 
  else if(flag .eq. 3); MAT
    tp1 = xt(66:113,275:330)   ; SouthAmerica, lat:-23 ~ 23; 275 ~ 330
    yt(66:113,275:330) = mat_ama(5, vi)*tp1
    tp21 = xt(66:113,340:359) ; West Africa
    yt(66:113,340:359) = mat_con(5, vi)*tp21
    tp22 = xt(66:113,0:49) ; Mid-East Africa
    yt(66:113,0:49) = mat_con(5, vi)*tp22   
    tp3 = xt(66:113,70:160); Southeast Asia
    yt(66:113,70:160) = mat_asa(5,vi)*tp3
  else ; MAP
    tp1 = xt(66:113,275:330)   ; SouthAmerica, lat:-23 ~ 23; 275 ~ 330
    tp1p= xtp(66:113,275:330)
    yt1p = mat_ama(0,vi)*exp(-( ((tp1p-mat_ama(1,vi))/mat_ama(2,vi))^2  ) )-mat_ama(3,vi)
    yt1p = where(tp1p .ge. mat_ama(1,vi), mat_ama(0,vi)-mat_ama(3,vi), yt1p)
    yt1d = mat_ama(0,vi)*exp(-( ((tp1p+tp1-mat_ama(1,vi))/mat_ama(2,vi))^2  ) )-mat_ama(3,vi) 
    yt1d = where(tp1p+tp1 .ge. mat_ama(1,vi), mat_ama(0,vi)-mat_ama(3,vi), yt1d)
    yt(66:113,275:330) = (yt1d - yt1p)*mat_ama(4,vi)

    tp2 = xt(66:113,340:359)   ; Africa
    tp2p= xtp(66:113,340:359)
    yt2p = mat_con(0,vi)*exp(-( ((tp2p-mat_con(1,vi))/mat_con(2,vi))^2  ) )-mat_con(3,vi)
    yt2p = where(tp2p .ge. mat_con(1,vi), mat_con(0,vi)-mat_con(3,vi), yt2p)
    yt2d = mat_con(0,vi)*exp(-( ((tp2p+tp2-mat_con(1,vi))/mat_con(2,vi))^2  ) )-mat_con(3,vi)
    yt2d = where(tp2p+tp2 .ge. mat_con(1,vi), mat_con(0,vi)-mat_con(3,vi), yt2d)
    yt(66:113,340:359) = (yt2d - yt2p)*mat_con(4,vi) 

    tp3 = xt(66:113,0:49)   ; Africa
    tp3p= xtp(66:113,0:49)
    yt3p = mat_con(0,vi)*exp(-( ((tp3p-mat_con(1,vi))/mat_con(2,vi))^2  ) )-mat_con(3,vi)
    yt3p = where(tp3p .ge. mat_con(1,vi), mat_con(0,vi)-mat_con(3,vi), yt3p)
    yt3d = mat_con(0,vi)*exp(-( ((tp3p+tp3-mat_con(1,vi))/mat_con(2,vi))^2  ) )-mat_con(3,vi)
    yt3d = where(tp3p+tp3 .ge. mat_con(1,vi), mat_con(0,vi)-mat_con(3,vi), yt3d)
    yt(66:113,0:49) = (yt3d - yt3p)*mat_con(4,vi)

    tp4 = xt(66:113,70:160)   ; Southeast Asia
    tp4p= xtp(66:113,70:160)
    yt4p = mat_asa(0,vi)*exp(-( ((tp4p-mat_asa(1,vi))/mat_asa(2,vi))^2  ) )-mat_asa(3,vi)
    yt4p = where(tp4p .ge. mat_asa(1,vi), mat_asa(0,vi)-mat_asa(3,vi), yt4p)
    yt4d = mat_asa(0,vi)*exp(-( ((tp4p+tp4-mat_asa(1,vi))/mat_asa(2,vi))^2  ) )-mat_asa(3,vi)
    yt4d = where(tp4p+tp4 .ge. mat_asa(1,vi), mat_asa(0,vi)-mat_asa(3,vi), yt4d)
    yt(66:113,70:160) = (yt4d - yt4p)*mat_asa(4,vi)

  end if
  end if
  return(yt)
end

undef("Biomass_prediction2")
function Biomass_prediction2 (xtp:numeric, xt:numeric, mat_trop:numeric,  flag:numeric, mi:numeric)
begin
  if(mi .ge. 6) then
    vi = mi -1
  else
    vi = mi
  end if
  yt = new((/180,360/),double)

  if(flag .eq. 3); MAT
    tp1 = xt(66:113,:)   ;  lat:-23 ~ 23;  ~ 
    yt(66:113,:) = mat_trop(5, vi)*tp1
  else ; MAP
    tp1 = xt(66:113,:)   ; lat:-23 ~ 23; 
    tp1p= xtp(66:113,:)
    yt1p = mat_trop(0,vi)*exp(-( ((tp1p-mat_trop(1,vi))/mat_trop(2,vi))^2  ) )-mat_trop(3,vi)
    yt1p = where(tp1p .ge. mat_trop(1,vi), mat_trop(0,vi)-mat_trop(3,vi), yt1p)
    yt1d = mat_trop(0,vi)*exp(-( ((tp1p+tp1-mat_trop(1,vi))/mat_trop(2,vi))^2  ) )-mat_trop(3,vi) 
    yt1d = where(tp1p+tp1 .ge. mat_trop(1,vi), mat_trop(0,vi)-mat_trop(3,vi), yt1d)
    yt(66:113,:) = (yt1d - yt1p)*mat_trop(4,vi)

  end if
  return(yt)
end

undef("Biomass_prediction3")
function Biomass_prediction3 (prdelt:numeric, tadelt:numeric, prpic:numeric, mat_coefficient:numeric, flag:numeric)
begin
  if(flag .eq. 1) then ;using the matrix for each 1000 rainfall range
    prdelt_tp = prdelt(66:113,:)
    prpic_tp = prpic(66:113,:)
    tadelt_tp = tadelt(66:113,:)
    vegprdct = prdelt_tp
    i = 0
    do while(i .le. 113-66)
      j = 0
      do while( j .le. 359)
        bspr = prpic_tp(i,j)
        if(ismissing(bspr))
          j = j+1
          continue
        end if
        if(bspr .lt. 600) then
          vegprdct(i,j) = prdelt_tp(i,j)*mat_coefficient(0,0)        
        else if(bspr .gt. 3100) then
          vegprdct(i,j) = prdelt_tp(i,j)*mat_coefficient(0,25)
        else
          vegprdct(i,j) = prdelt_tp(i,j)*mat_coefficient(0,round(bspr/100-5-1,3))
        end if
        end if
        j = j+1
      end do
      i = i+1
    end do 
  else ; simple sensitivity
    vegprdct = prdelt(66:113,:)*0.066 
  end if
  return(vegprdct)
end

;------------------------ function labelbar
undef("attach_labelbar")
function attach_labelbar(wks,plot,labels,colors)
local lbres, vph, vpw, nboxes
begin
  nboxes = dimsizes(labels)
  getvalues plot                      ; Get plot size for use in
    "vpHeightF" : vph                 ; creating labelbar.
    "vpWidthF"  : vpw
  end getvalues

  lbres                    = True          ; labelbar only resources
  lbres@lbAutoManage       = False          ; Necessary to control sizes
  lbres@lbPerimOn          = False
  ;lbres@cnLabelBarEndStyle = "IncludeOuterBoxes"
  lbres@lbLabelPosition    = "Right"
  lbres@lbLabelAlignment   = "InteriorEdges"
  lbres@lbOrientation 	   = "Horizontal"
  lbres@vpWidthF           = 0.95 *  vpw     ; labelbar width
  lbres@vpHeightF          = 0.16 * vph           ; labelbar height
  lbres@lbLabelOffset      = 0.03
  lbres@lbFillColors       = colors
  lbres@lbMonoFillPattern  = True          ; Solid fill pattern
  lbres@lbLabelFontHeightF = 0.01          ; font height. default is small
  lbres@lbBoxLinesOn       = True

  lbid = gsn_create_labelbar(wks,nboxes,labels,lbres)
;
; Now, create some annotation resources indicating how we want to
; attach the labelbar to the plot.
;                                                                 
  amres                = True
  amres@amParallelPosF = 0     ; Move away from plot
  amres@amOrthogonalPosF = 0.68
  annoid = gsn_add_annotation(plot,lbid,amres)

  return(annoid)
end
;--------------------------------

procedure add_shp_outlines(wks,plot,shp_filename)
local lnres
begin
;---Resources for polyline
  lnres                  = True
  lnres@gsLineColor      = "red"
  lnres@gsLineThicknessF = 1.0            ; 3x thickness

  plot@lines = gsn_add_shapefile_polylines(wks, plot, shp_filename, lnres)
end


;=================================================    main function    =============================================
begin
;***************************** user define ******************************
var_name2 = "precip"

scaleFactor2 = 86400; for LE

units1 = "mm yr~S~-1~N~"; for PRE
units2 = "~S~o~N~C"
units3 = "%"
units4 = "MgC ha~S~-1~N~"
units5 = "%"

cmapp = read_colormap_file("BlueDarkRed18")
colortable1 = cmapp(::-1,:)
cmap = read_colormap_file("cmp_flux")
colortable2 = cmap
cmap2 = read_colormap_file("GreenMagenta16")
colortable3 = cmap2(::-1,:)
cmap4 = read_colormap_file("MPL_seismic")
colortable4 = cmap4(::-1,:)
cmap5 = read_colormap_file("MPL_PuOr")
colortable5 = cmap5(::-1,:)
;levelmode = "AutomaticLevels"
levelmode = "ExplicitLevels"

levels1 = ispan(-100, 100,10)
levels2 = fspan(-2.4,2.4,25)
levels3 = fspan(-80.,80.,21)
levels4 = fspan(-15., 15.,21)
levels5 = fspan(-20., 20., 21)
;*******************************************************************************
area_name = "Areas"
filename = "/home/liyue/th-1a/areas.nc"
;f = addfile(filename,"r")
;area = f->$area_name$
yearref = 1982
beginmth = 1 
endmth = 12
scenarios1="S1"
scenarios2="S2"
ens_name = "ens10"

modelname0 = (/"BCC-CSM2-MR","CanESM5","CESM2","CNRM-ESM2-1","IPSL-CM6A-LR","GISS-E2-1-G","UKESM1-0-LL","MPI-ESM1-2-LR"/)
modelname = (/"sBCC-CSM2-MR","sCanESM5","sCESM2","sCNRM-ESM2-1","sIPSL-CM6A-LR","sGISS-E2-1-G", "sUKESM1-0-LL","sMPI-ESM1-2-LR"/)
endyear = (/1930,1940,1929,1930,1929,1934,1929,2050/)
ensname = (/"r1i1p1f1_gn", "r1i1p2f1_gn", "r2i1p1f1_gn", "r1i1p1f2_gr", "r1i1p1f1_gr","r1i1p1f2_gn","r1i1p1f2_gn","r1i1p1f1_gn"/)
ff = addfile("/export/home/yuel59/script/rainfall_deforestation/2020.05.04.pre_statistics/l1.piControl/Clim_pattern_precip_piControl.nc","r")
climpr = ff->climpr
;climpr = new((/7,5,180,360/), float) ; (model; ann, amazon:wet, dry & congo:wet, dry; pattern)
f = addfile("/export/home/yuel59/script/rainfall_deforestation/2020.05.04.pre_statistics/l1.piControl/last30_pattern_precip_piControl.nc","r")
climpr30 = f->climpr30  ;(model; last 30yrs; ann, amazon:wet, dry & congo:wet, dry & tropAsia:wet, dry; pattern)
climpatt = climpr30(:,:,0,:,:)*86400
climask = dim_avg_n( dim_avg_n(climpatt,1),0)
ff = addfile("/export/home/yuel59/script/rainfall_deforestation/basin_map1deg.nc","r")
amabasin = ff->cell_area
;pr_avg = where(amabasin .ne. 259, pr_avg@_FillValue, pr_avg)
shp_filename = "/DFS-L/DATA/randerson/yuel59/landcover/GRDC_basin_map/Amazon_line.shp"
shp_filename2 = "/DFS-L/DATA/randerson/yuel59/landcover/GRDC_basin_map/Congo_line.shp"

f = addfile("/export/home/yuel59/script/rainfall_deforestation/2020.05.23.biomass_pr_relation/l1.prepare_data/Biomass_30yrmean_pattern.nc","r")
vegcannpic = f->vegcannpic
vegcanndef = f->vegcanndef
vegcanndelt = (vegcanndef - vegcannpic)*0.5
f = addfile("/export/home/yuel59/script/rainfall_deforestation/2020.05.23.biomass_pr_relation/l1.prepare_data/treeFrac_30yrmean_pattern.nc","r")
treeFracpic = f->treeFracpic
treeFracdef = f->treeFracdef
treeFracdelt = treeFracdef - treeFracpic
f = addfile("/export/home/yuel59/script/rainfall_deforestation/2020.05.23.biomass_pr_relation/l1.prepare_data/MAP_30yrmean_pattern.nc","r")
prannpic = f->prannpic
pranndef = f->pranndef
f = addfile("/export/home/yuel59/script/rainfall_deforestation/2020.05.23.biomass_pr_relation/l1.prepare_data/MAT_30yrmean_pattern.nc","r")
tasannpic = f->tasannpic
tasanndef = f->tasanndef
f = addfile("/export/home/yuel59/script/rainfall_deforestation/2020.07.06.all_figures/major_figures/l2_clim_space_biomass/sensitivity_obs_mod.nc","r")
bsens_obs = f->bsens_obs
bsens_mod = f->bsens_mod
mat_coefficient = bsens_obs
mat_coefficient(0,:) = mat_coefficient(0,:)*0.01
shp_filename = "/DFS-L/DATA/randerson/yuel59/landcover/GRDC_basin_map/Amazon_line.shp"
shp_filename2 = "/DFS-L/DATA/randerson/yuel59/landcover/GRDC_basin_map/Congo_line.shp"

f = addfile("/export/nfs0home/yuel59/script/rainfall_deforestation/2022.01.12.rainfall_confirmation/gpcc_precip.nc","r")
ppr = f->precip
prgpcc = ppr(0:29,:,:)
yrt = 126-30
do while( yrt .le. 126-1)
  ; Ann for all
  prgpcc(yrt-96,:,:) = dim_avg_n_Wrap(ppr(0+yrt*12:11+yrt*12,:,:), 0)
  yrt = yrt + 1
end do
prgp = dim_avg_n_Wrap(prgpcc,0)

;print(vegcannpic(6,66:113,275:330))
a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
lsdata = a->LSMASK
indd = (/1, 2, 3, 4, 6, 7/)
;mi = 0 
;do while(mi .le. 7)
;  print(mi)
;
;  if(mi .eq. 0 .or. mi .eq. 5) then
;     mi = mi + 1
;     continue
;  end if
  ; -------------------------------------------------------------------draw the plot
  graphname = "figure4_part1_rainfall"
  wks_type          = "pdf"
  wks_type@wkWidth  = 1450          ; Make X11 window larger. Default
  wks_type@wkHeight = 900
  wks = gsn_open_wks(wks_type,graphname);
  
  mmap = new(6,graphic)
  
  ;-------------------------------------- contour
  ;res22 = True
  ;res22@gsnDraw = False
  ;res22@gsnFrame = False
  ;res22@cnFillOpacityF = 0.1
  ;res22@cnFillOn = False
  ;res22@cnInfoLabelOn = False
  ;res22@cnLineLabelPlacementMode = "constant"
  ;res22@cnLineDashSegLenF = 0.1
  ;res22@cnLevelSelectionMode = "ManualLevels"
  ;res22@cnMinLevelValF = -0.05
  ;res22@cnMaxLevelValF = 1.95
  ;res22@cnLevelSpacingF = 1
  ;res22@cnLevelFlags = "LineOnly"
  ;res22@gsnLeftString = ""
  ;res22@gsnRightString = ""
  ;res22@tmXBOn = False
  ;res22@gsnContourPosLineDashPattern = 0 
  ;res22@cnLineColor = "springgreen"
  ;res22@cnLabelMasking = True
  ;res22@gsnContourZeroLineThicknessF = 2.5
  
  resp                  = True                      ; polyline mods desired
  resp@gsLineColor      = "Gray"                     ; color of lines
  resp@gsLineThicknessF = 1.0                       ; thickness of lines
  res22 = True
  res22@gsnDraw = False
  res22@gsnFrame = False
  res22@cnFillOpacityF = 0.1
  res22@cnFillOn = False
  res22@cnLinesOn = False
  res22@cnInfoLabelOn = False
  res22@cnLineLabelPlacementMode = "constant"
  res22@cnLineDashSegLenF = 0.1
  res22@cnLevelSelectionMode = "ManualLevels"
  res22@cnMinLevelValF = 0.6
  res22@cnMaxLevelValF = 1
  res22@cnLevelSpacingF = 0.05 
  
  ypts = (/ 10.0,  10.0,  -10.0,   -10.0, 10.0/)
  xpts = (/95.0, 155.0,155.0, 95.0,95.0/)

  ;----------------------------------------------Calculate the predicted Biomass------------------------
  prdelt = (dim_avg_n(pranndef,0)  - dim_avg_n(prannpic,0) ) * 365
  prdeltp = dim_avg_n( (pranndef - prannpic)/prannpic, 0)
  prgpc = prgp/30*365
  prgpct = prgpc*(1+prdeltp)
  prdelt2 = prdeltp*prgpc
  prpic = dim_avg_n(prannpic,0)*365
  tadelt = dim_avg_n(tasanndef,0) - dim_avg_n(tasannpic,0)
  flag =1 
  ;vegcprdct = Biomass_prediction3 (prdelt,tadelt, prpic, mat_coefficient,flag) ; choose regression on every 1000mm rainll range or not
  vegcprdct = Biomass_prediction3 (prdelt2,tadelt, prgpct, mat_coefficient,flag) ; choose regression on every 1000mm rainll range or not
  climask1 = climask(66:113,:)
  vegcprdct = where(climask1 .lt. 0.2739, vegcprdct@_FillValue, vegcprdct)
  ;-----------------------------------------------draw the map -------------------------------------------
  nb = "a"
  result1 = pattern_plot (nb, units4, colortable4, levelmode,levels4,"")
  res = result1
  bass = amabasin(66:113,:)
  vv = vegcprdct
  vv!0 = "lat"
  vv&lat = vegcanndef&lat(66:113)
  vv!1 = "lon"
  vv&lon = vegcannpic&lon
  vv&lon@units = "degrees_east"
  vv&lat@units = "degrees_north"
  lsm = landsea_mask(lsdata,vv&lat,vv&lon)
  vv = mask(vv,lsm.eq.0,False)
  vv = mask(vv,lsm.eq.4,False)
  vv = mask(vv,lsm.eq.2,False)
  vv = where(bass .ne. 259, vv@_FillValue, vv)
  map = gsn_csm_contour_map(wks,vv,res)
  delete(vv)
  add_shp_outlines(wks, map, shp_filename)

  nb = "a"
  result1 = pattern_plot (nb, units4, colortable4, levelmode,levels4,"")
  res = result1
  res@mpMaxLatF = 23
  res@mpMinLatF = -23
  res@mpMaxLonF = 50
  res@mpMinLonF = -10
  vv = vegcprdct
  vv!0 = "lat"
  vv&lat = vegcanndef&lat(66:113)
  vv!1 = "lon"
  vv&lon = vegcannpic&lon
  vv&lon@units = "degrees_east"
  vv&lat@units = "degrees_north"
  lsm = landsea_mask(lsdata,vv&lat,vv&lon)
  vv = mask(vv,lsm.eq.0,False)
  vv = mask(vv,lsm.eq.4,False)
  vv = mask(vv,lsm.eq.2,False)
  vv = where(bass .ne. 243, vv@_FillValue, vv)
  map2 = gsn_csm_contour_map(wks,vv,res)
  delete(vv)
  add_shp_outlines(wks, map2, shp_filename2)
  
  nb = "a"
  result1 = pattern_plot (nb, units4, colortable4, levelmode,levels4,"")
  res = result1 
  res@mpMaxLatF = 23
  res@mpMinLatF = -23
  res@mpMaxLonF = 155
  res@mpMinLonF = 95
  vv = vegcprdct 
  vv!0 = "lat"
  vv&lat = vegcanndef&lat(66:113)
  vv!1 = "lon"
  vv&lon = vegcannpic&lon
  vv&lon@units = "degrees_east"
  vv&lat@units = "degrees_north"
  lsm = landsea_mask(lsdata,vv&lat,vv&lon)
  vv = mask(vv,lsm.eq.0,False)
  vv = mask(vv,lsm.eq.4,False)
  vv = mask(vv,lsm.eq.2,False)
  vv({-23 : -10},:) = vv@_FillValue
  vv({10 : 23},:) = vv@_FillValue
  vv(:,{0 :90}) = vv@_FillValue
  vv(:,{160:360}) = vv@_FillValue
  map3 = gsn_csm_contour_map(wks,vv,res)
  delete(vv)

  ;----------addpolyline
  ypts = (/ -10.0,  -10.0,  10.0,   10.0, -10.0/)
  xpts = (/95.0, 155.0, 155.0, 95.0,95.0/)
  resp                  = True                      ; polyline mods desired
  resp@gsLineColor      = "red"                     ; color of lines
  resp@gsLineThicknessF = 1.0                       ; thickness of lines
  resp@gsLineLabelString= ""                    ; adds a line label string
  dum = new(4,graphic)
  ; draw each line separately. Each line must contain two points.
  do i = 0 , 3
    dum(i)=gsn_add_polyline(wks,map3,xpts(i:i+1),ypts(i:i+1),resp)
  end do

   
  mmap(0) = map
  mmap(1) = map2
  mmap(2) = map3

  pres = True
  pres@gsnPanelLabelBar = True
  pres@lbPerimOn         = False
  pres@lbBoxLinesOn = False
  gsn_panel(wks,mmap,(/2,3/),pres)


end
