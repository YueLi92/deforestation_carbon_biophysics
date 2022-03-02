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
  res@mpGeophysicalLineColor = "Gray21"
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

  ;res22 = True
  ;res22@gsnDraw = False
  ;res22@gsnFrame = False
  ;res22@cnFillOpacityF = 0.3
  ;res22@cnFillOn = False
  ;res22@cnLinesOn = False
  ;res22@cnInfoLabelOn = False
  ;if(option.eq.2) then
  ;      map = gsn_csm_contour_map(wks,rc_lai_S3,res)
  ;      map_contour = gsn_csm_contour(wks,tval2_lai_S3,res22)
  ;      map_contour = ShadeLtGtContour(map_contour,-1.701,4,1.701,3)
  ;      overlay(map,map_contour)
  ;else
  ;       map = gsn_csm_contour_map(wks,var_mth,res)
  ;print("ok")
  ;end if
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
  lnres@gsLineColor      = "brown1"
  lnres@gsLineThicknessF = 1.0            ; 3x thickness

  plot@lines = gsn_add_shapefile_polylines(wks, plot, shp_filename, lnres)
end


;=================================================    main function    =============================================
begin
;***************************** user define ******************************
var_name2 = "precip"

scaleFactor2 = 86400; for LE

units1 = "%"; for PRE
units2 = "~S~o~N~C"
units3 = "mm yr~S~-1~N~"
units4 = "-Pa/s"

cmap = read_colormap_file("GreenMagenta16")
colortable1 = cmap(::-1,:)
colortable1(7,1) = 1
;print(colortable1)
cmap2 = read_colormap_file("MPL_RdYlBu")
colortable2 = cmap2
colortable3 = cmap2
cmap4 = read_colormap_file("amwg256")
colortable4 = cmap4
;levelmode = "AutomaticLevels"
levelmode = "ExplicitLevels"

levels1 = ispan(-80, 80,8)
levels2 = fspan(-2.,2.,21)
levels2_0 = (/-2, -1.5, -1.2, -0.9, -0.6, -0.3, 0, 0.3, 0.6, 0.9, 1.2, 1.5, 2/)
;levels3 = ispan(-1000,1000,100)
levels3 = fspan(-300., 300., 25)
levels4 = fspan(-0.04, 0.04,21)

;*******************************************************************************
a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")                    ;ocean value
lsdata = a->LSMASK

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
f = addfile("/export/home/yuel59/script/rainfall_deforestation/2020.05.04.pre_statistics/l1.piControl/last30_pattern_precip_piControl.nc","r")
climpr30 = f->climpr30  ;(model; last 30yrs; ann, amazon:wet, dry & congo:wet, dry & tropAsia:wet, dry; pattern)
climpatt = climpr30(:,:,0,:,:)*86400
;climpatt!2 = "lat"
;climpatt&lat = climpr30&lat
;climpatt!3 = "lon"
;climpatt&lon = climpr30&lon
f = addfile("/export/home/yuel59/script/rainfall_deforestation/2020.05.23.biomass_pr_relation/l1.prepare_data/treeFrac_30yrmean_pattern.nc","r")
tcpic = f->treeFracpic
tcpicavg = dim_avg_n_Wrap(tcpic,0)
tcdef = f->treeFracdef
tcdefavg = dim_avg_n_Wrap(tcdef,0)
tcdelt = tcdefavg-tcpicavg
tcdelt!0 = "lat"
tcdelt&lat = tcpic&lat
tcdelt!1 = "lon"
tcdelt&lon = tcpic&lon

ff = addfile("/export/home/yuel59/script/rainfall_deforestation/basin_map1deg.nc","r")
amabasin = ff->cell_area
;pr_avg = where(amabasin .ne. 259, pr_avg@_FillValue, pr_avg)
shp_filename = "/DFS-L/DATA/randerson/yuel59/landcover/GRDC_basin_map/Amazon_line.shp"
shp_filename2 = "/DFS-L/DATA/randerson/yuel59/landcover/GRDC_basin_map/Congo_line.shp"


prepp = new((/8,30, 180, 360/), float)
mi = 0 
do while(mi .le. 7)

  if(mi .eq. 7) then
    f1 = addfile("/DFS-L/DATA/randerson/yuel59/cmip6-lumip/pr/pr_Amon_"+modelname(mi)+"_deforest-globe_"+ensname(mi)+"_190101-"+endyear(mi)+"12.1deg.nc","r")
  else 
    f1 = addfile("/DFS-L/DATA/randerson/yuel59/cmip6-lumip/pr/pr_Amon_"+modelname(mi)+"_deforest-globe_"+ensname(mi)+"_185001-"+endyear(mi)+"12.1deg.nc","r")
  end if
  pre = f1->pr
  prep = pre*86400 ; mm/d
  
  yr = 0
  do while( yr .le. 79)
    if(yr .ge. 50) then 
      prepp(mi,yr-50,:,:) = dim_avg_n(prep(0+yr*12 : 11+yr*12, :, :),0)
    end if
    yr = yr + 1
  end do

  if(mi .ne. 7) then
    delete(pre)
    delete(prep)
  end if
  mi = mi + 1
end do 
prepp!2 = "lat"
prepp&lat = pre&lat
prepp!3 = "lon"
prepp&lon = pre&lon

climask = dim_avg_n( dim_avg_n(climpatt,1),0)   
prediff = dim_avg_n(prepp,1) - dim_avg_n(climpatt,1) 
prediff!1 = "lat"
prediff&lat = pre&lat
prediff!2 = "lon"
prediff&lon = pre&lon

prediffavg = dim_avg_n(prediff,0) 
prediffavg!0 = "lat"
prediffavg&lat = pre&lat
prediffavg!1 = "lon"
prediffavg&lon = pre&lon

mdagre = prediffavg
mdagre = where(mdagre .ne. mdagre@_FillValue, 0, mdagre@_FillValue)
nlat = 180
nlon = 360
do ilat = 0, nlat-1
  do ilon = 0, nlon-1
    tt1 = prediffavg(ilat, ilon)
    if(tt1 .eq. tt1@_FillValue) then
      continue;
    end if

    ttt = prediff(:,ilat,ilon)
    mdagre(ilat,ilon) = num(ttt*tt1 .gt. 0)
  end do
end do
mdagre = mdagre/6.3 ; at leat 6 models, so the value would be over 0.95
mdagre!0 = "lat"
mdagre&lat = pre&lat
mdagre!1 = "lon"
mdagre&lon = pre&lon 
;------------------------------------------------------------------------Student t test for significance
ksv   = new((/8,nlat,nlon/),typeof(pre))

mi = 0
do while(mi .le. 7)    
    do ilat = 0, nlat-1
    do ilon = 0, nlon-1
      X = prepp(mi,:,ilat,ilon)
      Y = climpatt(mi,:,ilat,ilon)
      aveX    = avg (X)             ; 23.6    ; dim_avg_n (X,0)
      aveY    = avg (Y)             ; 19.222
      varX    = variance (X)        ; 17.083  ; dim_variance_n (X,0)
      varY    = variance (Y)        ; 13.477
      sX      = dimsizes (X)        ; 25
      sY      = dimsizes (Y)
      prob = ttest(aveX,varX,sX, aveY,varY,sY, True, False)
      ksv(mi,ilat,ilon) = 1-prob
      delete(X)
      delete(Y)
  
    end do
  end do
  mi = mi +1
end do
ksv!1 = "lat"
ksv&lat = pre&lat
ksv!2 = "lon"
ksv&lon = pre&lon

mdagre2 = mdagre
mdagre2 = where(mdagre2 .ne. mdagre2@_FillValue, 0, mdagre2@_FillValue)
do ilat = 0, nlat-1
  do ilon = 0, nlon-1
    tt1 = prediffavg(ilat, ilon)
    if(tt1 .eq. tt1@_FillValue) then
      continue;
    end if

    ttt = ksv(:,ilat,ilon)
    mdagre2(ilat,ilon) = num(ttt .gt. 0.95)
  end do
end do
mdagre2 = mdagre2/6.3 ; at leat 6 models, so the value would be over 0.95
mdagre2!0 = "lat"
mdagre2&lat = pre&lat
mdagre2!1 = "lon"
mdagre2&lon = pre&lon

; -------------------------------------------------------------------draw the plot
graphname = "figure1_rainfall_change"
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


lsm = landsea_mask(lsdata,mdagre&lat,mdagre&lon)
mdagre = mask(mdagre,lsm.eq.0,False)
mdagre = mask(mdagre,lsm.eq.2,False)
mdagre = mask(mdagre,lsm.eq.4,False)
mdagre({15:20},{305:310}) = 0.97
mdagre = where(climask .lt. 0.2739, mdagre@_FillValue, mdagre)
;mdagre = where(tcpicavg .lt. 10, mdagre@_FillValue, mdagre)
;mdagre = where(tcdelt .gt. -5, mdagre@_FillValue, mdagre)
ypts = (/ 10.0,  10.0,  -10.0,   -10.0, 10.0/)
xpts = (/95.0, 155.0,155.0, 95.0,95.0/)
;-----------------------------------------------draw the map -------------------------------------------
nb = "a"
result1 = pattern_plot (nb, units3, colortable3, levelmode,levels3,"")
res = result1
vv = prediffavg*365
vv!0 = "lat"
vv&lat = prediffavg&lat
vv!1 = "lon"
vv&lon = prediffavg&lon
vv = where(climask .lt. 0.2739, vv@_FillValue, vv)
;vv = where(tcpicavg .lt. 10, vv@_FillValue, vv)
;vv = where(tcdelt .gt. -5, vv@_FillValue, vv)
lsm = landsea_mask(lsdata,vv&lat,vv&lon)
vv = mask(vv,lsm.eq.0,False)
vv = mask(vv,lsm.eq.2,False)
vv = mask(vv,lsm.eq.4,False)
map = gsn_csm_contour_map(wks,vv,res)
map11 = gsn_csm_contour(wks,mdagre2,res22)
map11 = ShadeGtContour(map11,0.951, 17)
map111 = gsn_csm_contour(wks,mdagre, res22)
map111 = ShadeGtContour(map111,0.951, 17)
delete(vv)
;overlay(map,map11)
overlay(map,map111)
add_shp_outlines(wks, map, shp_filename)

nb = "b"
result1 = pattern_plot (nb, units3, colortable3, levelmode,levels3,"")
res = result1
res@mpMaxLatF = 23
res@mpMinLatF = -23
res@mpMaxLonF = 50
res@mpMinLonF = -10
vv = prediffavg*365
vv!0 = "lat"
vv&lat = prediffavg&lat
vv!1 = "lon"
vv&lon = prediffavg&lon
lsm = landsea_mask(lsdata,vv&lat,vv&lon)
vv = mask(vv,lsm.eq.0,False)
vv = mask(vv,lsm.eq.2,False)
vv = mask(vv,lsm.eq.4,False)
vv = where(climask .lt. 0.2739, vv@_FillValue, vv)
;vv = where(tcpicavg .lt. 10, vv@_FillValue, vv)
;vv = where(tcdelt .gt. -5, vv@_FillValue, vv)
map2 = gsn_csm_contour_map(wks,vv,res)
map22 = gsn_csm_contour(wks,mdagre2,res22)
map22 = ShadeGtContour(map22,0.951, 17)
map222 = gsn_csm_contour(wks,mdagre, res22)
map222 = ShadeGtContour(map222,0.951, 17)
delete(vv)
;overlay(map2,map22)
overlay(map2,map222)
add_shp_outlines(wks, map2, shp_filename2)

nb = "c"
result1 = pattern_plot (nb, units3, colortable3, levelmode,levels3,"")
res = result1
res@mpMaxLatF = 23
res@mpMinLatF = -23
res@mpMaxLonF = 155
res@mpMinLonF = 95
vv = prediffavg*365
vv!0 = "lat"
vv&lat = prediffavg&lat
vv!1 = "lon"
vv&lon = prediffavg&lon
vv = where(climask .lt. 0.2739, vv@_FillValue, vv)
;vv = where(tcpicavg .lt. 10, vv@_FillValue, vv)
;vv = where(tcdelt .gt. -5, vv@_FillValue, vv)
lsm = landsea_mask(lsdata,vv&lat,vv&lon)
vv = mask(vv,lsm.eq.0,False)
vv = mask(vv,lsm.eq.2,False)
vv = mask(vv,lsm.eq.4,False)
map3 = gsn_csm_contour_map(wks,vv,res)
map33 = gsn_csm_contour(wks,mdagre2,res22)
map33 = ShadeGtContour(map33,0.951, 17)
map333 = gsn_csm_contour(wks,mdagre, res22)
map333 = ShadeGtContour(map333,0.951, 17)
delete(vv)
;overlay(map3,map33)
overlay(map3,map333)

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
