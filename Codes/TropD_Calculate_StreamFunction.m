% TropD calculate the streamfunction by integrating the meridional wind from the top of the atmosphere to the surface
% Written by Ori Adam Apr.2.2017
% Syntax:
% >> Psi = TropD_Calculate_StreamFunction(V,lat,lev)
% Input:
% V(lat,lev) = zonal-mean meridional wind
% lat = equally-spaced latitude vector
% lev = vertical pressure-level vector [hPa]
% Output:
% The streamfunction Psi(lat,lev)

function Psi = TropD_Calculate_StreamFunction(V,lat,lev)

if nargin ~= 3
    disp(['TropD_Calculate_StreamFunction: ERROR: Input must be if the form: TropD_Calculate_StreamFunction(V,lat,lev)'])
    Psi = [] ;
    return
end
EarthRadius    = 6.37122e6 ; % Earth's Radius in m
EarthGrav      = 9.80616   ; % Gravitational acceleration
lev = double(lev) ;
if ~iscolumn(lev)
    lev = lev' ;
end
if ~iscolumn(lat)
    lat = lat' ;
end
B = ones(size(V)) ;
B(isnan(V))  = 0  ; % B = 0 for subsurface data
COS = repmat(cosd(lat),[1 length(lev)]) ;
if lev(1) < lev(end)
    Psi = EarthRadius/EarthGrav.*2.*pi.*cumtrapz(double(lev)*100,B.*V.*COS,2) ;
else
    Psi = flip(EarthRadius/EarthGrav.*2.*pi.*cumtrapz(flip(lev,1)*100,flip(B.*V,2).*COS,2),2) ;
end