% Otago Vortex Counter
 clear all
 % close
% clc
 
 Stirred_Vortices_84 = load('Data/Stirred_Vortices_84');
 
 PSI = Stirred_Vortices_84.PSI;
 
 PhaseofPSI = angle(PSI);
 
 [X,Y] = size(PSI);
 
tic
% wrap x and y phase, then take x diff and y diff, then curl x and y to
% find the vortices

Xunwrap = unwrap(PhaseofPSI,[],2);
Yunwrap = unwrap(PhaseofPSI,[],1);

dVx_dy= diff(diff(Xunwrap,1,2),1,1);

dVy_dx = diff(diff(Yunwrap,1,1),1,2);



% do crude curl

Vortex_Grid = dVy_dx - dVx_dy;
 
Otago_Time = toc
%Otago_cpu = cputime

 figure
 imagesc(X,Y,Vortex_Grid)
 set(gca,'ydir','normal')
 
