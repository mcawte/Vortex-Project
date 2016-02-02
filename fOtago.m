function [ Otago_Time ] = fOtago(PSI)

 tstart = tic;
 PhaseofPSI = angle(PSI);
 
 [X,Y] = size(PSI);
 

% wrap x and y phase, then take x diff and y diff, then curl x and y to
% find the vortices

Xunwrap = unwrap(PhaseofPSI,[],2);
Yunwrap = unwrap(PhaseofPSI,[],1);

dVx_dy= diff(diff(Xunwrap,1,2),1,1);

dVy_dx = diff(diff(Yunwrap,1,1),1,2);



% do crude curl

Vortex_Grid = dVy_dx - dVx_dy;
 
Otago_Time = toc(tstart);



end

