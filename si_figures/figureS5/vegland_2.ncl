;************************************************
;vegland_2.ncl
;************************************************
;
; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl" 
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"    
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"    

begin
  f      = addfile ("landcover_modis.nc", "r")           ; read as he2

  info = (/                             \ ;Majority_Land_Cover_Type_1
        " 0 water"                     ,\ 
        " 1 evergreen_needleleaf"      ,\ ;_forest
        " 2 evergreen_broadleaf"       ,\ ;_forest     
        " 3 deciduous_needleleaf"      ,\ ;_forest
        " 4 deciduous_broadleaf"       ,\ ;_forest     
        " 5 mixed_forests"             ,\
        " 6 closed_shrubland"          ,\
        " 7 open_shrublands"           ,\
        " 8 woody_savannas"            ,\
        " 9 savannas"                  ,\
        " 10 grasslands"               ,\
        " 11 permanent_wetlands"       ,\
        " 12 croplands"                ,\
        " 13 urban_and_built_up"       ,\
        " 14 crop_nat_veg_mosaic"      ,\ ; cropland_natural_vegetation_mosaic
        " 15 snow_and_ice"             ,\
        " 16 barren_or_sparse"         ,\ ; barren_or_sparsely_vegetated       
        " 17 unclassified"             /)

  ninfo = dimsizes(info)        ; # of classifications

  xhe   = f->landcover
  printVarSummary(xhe)

;************************************************
; create plot
;************************************************
  pltType = "pdf"               ; ps, pdf, png, x11, eps
  ;sfx     = get_file_suffix(fili,0)

  pltDir  = "./"
 ;pltName = sfx@fBase+"."+region+"_majority"
  pltName = "MODIS_landcover_map"
  pltPath = pltDir + pltName

  colorscheme = (/"cadetblue1", "darkgreen", "chartreuse", "olivedrab3","palegreen",\
		"darkseagreen","mediumpurple1","mistyrose","burlywood3","gold",\
		"tan1","royalblue","lightgoldenrod1","red","lightgoldenrod4","white",\
		"lightsteelblue","grey90"/) 

  ncolors = dimsizes(colorscheme)
  if (ninfo.ne.ncolors) then            ; make sure # of colors match categories (classes)
      print("size mismatch: ninfo="+ninfo+"   ncolors="+ncolors)
      exit
  end if

  wks = gsn_open_wks(pltType,pltPath)  

  res                  = True                ; plot mods desired
  res@gsnDraw          = False
  res@gsnFrame         = False
  res@gsnMaximize      = True               ; ps, pdf 

  res@cnFillOn         = True               ; color Fill 
  res@cnFillMode       = "RasterFill" 
  res@cnLinesOn        =  False             ; Turn off contour lines
  res@cnLevelSelectionMode = "ExplicitLevels" ; set explict contour levels
  res@cnLevels         = tobyte( ispan(1,ninfo-1,1) )   ;one less than ninfo
  res@cnFillPalette    = colorscheme        ; distinct colors for categories
  res@gsnSpreadColors  = False              ; use each color sequentially

  res@lbLabelPosition  = "Center"           ; label position
  res@lbLabelAlignment = "BoxCenters"       ; label orientation
  res@lbLabelStrings   = ispan(0,ninfo,1)  
  res@lbLabelStride    = 1
  res@lbLabelAutoStride = False 	    ; in V6.1.0 and up, this is defaulted
					    ; to True, and overrides lbLabelStride
					    ; default. Set this to ensure that 
					    ; your label scheme is preserved.

  res@pmLabelBarHeightF        =  0.075
  res@pmLabelBarWidthF         =  0.50      ; default is 0.6
 ;res@pmLabelBarOrthogonalPosF = -0.0005    ; move up smidge
  res@tmXBLabelFontHeightF = 0.01
  res@tmYLLabelFontHeightF = 0.01

  res@mpFillOn         = False
  res@mpCenterLonF     = 0.0

;;res@mpGridAndLimbOn   = True
;;res@mpGridLatSpacingF = 5.0
;;res@mpGridLonSpacingF = 5.0
;;res@mpGridLineDashPattern = "2"

;;res@gsnAddCyclic  = False                  ; regional data   

  res@vpHeightF  = 0.5
  res@vpWidthF   = 0.5

  res@trGridType     = "TriangularMesh"

  res@tiMainString   = ""
  res@mpMaxLatF = 23
  res@mpMinLatF = -23
  res@mpMaxLonF = 155 
  res@mpMinLonF = -90
  plot = gsn_csm_contour_map_ce(wks, xhe, res) ; create plot

  rtxt = True
  rtxt@txJust        = "TopLeft"
  rtxt@txFontHeightF = 0.010    ; 0.0075     ;  0125

; Add text: rows x columns of text (arbitrary)
; Usually must play with xx, yy and txFontHeightF

  nrow = 3       ; # rows
  ncol = 6       ; # columns

  n  = -1
  xx = 0.05                ; arbitrary
  do nc=0,ncol-1
     yy = 0.32
    do nr=0,nrow-1
       n = n+1
       if (n.le.(ninfo-1)) then
           gsn_text_ndc (wks,info(n),xx,yy,rtxt)
           yy = yy - 3*rtxt@txFontHeightF
       end if
    end do
    xx = xx + 0.155
  end do

  draw(plot)
  frame(wks)

end

