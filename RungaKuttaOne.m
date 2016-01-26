function [ ynext ] = RungaKuttaOne(PSI,k,g,DeltaT)
% First attempt at Runga Kutta Method


k1 = RHSdPSI(PSI,k,g);

k2 = RHSdPSI(PSI + (DeltaT/2 .* k1),k,g); 

k3 = RHSdPSI(PSI + (DeltaT/2 .* k2),k,g); 

k4 = RHSdPSI(PSI + (DeltaT .* k3),k,g); 


ynext = PSI + DeltaT/6 * (k1 + 2*k2 + 2*k3 + k4);


end
