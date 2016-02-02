function [GroundPSI, Energy] = fGround_State_Creator(PSI,ksquareon2,g,V,...
    DeltaT,InitialNatoms, Points, Energy1, DeltaX, k)

%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

Energy = zeros(1,Points);
mkdir ./Data/;


% The 2D third oder Baker Hausdorff with t set to -i*t is called   
 PSI = Baker_Hausdorff_Oh3_iTime(PSI,ksquareon2,g,V,DeltaT);
 
% PSI is now renormalized to keep the right number density correct so that
% the whole thing does not decay away entirely.
  
Natoms = sum(sum(abs(PSI.^2))).*DeltaX.^2;
PSI = (sqrt(InitialNatoms)/sqrt(Natoms)) .* PSI;

Energy(1,1) = GPE_Energy_2D(PSI,k,g,V,DeltaT);

  
PSI = Baker_Hausdorff_Oh3_iTime(PSI,ksquareon2,g,V,DeltaT); 
Natoms = sum(sum(abs(PSI.^2))).*DeltaX.^2;
PSI = (sqrt(InitialNatoms)/sqrt(Natoms)) .* PSI;

Energy(1,2) = GPE_Energy_2D(PSI,k,g,V,DeltaT);

ii = 2;

while Energy(1,ii-1) - Energy(1,ii) > 0.000001;
    
    ii = ii + 1;
 
% The 2D third oder Baker Hausdorff with t set to -i*t is called   
 PSI = Baker_Hausdorff_Oh3_iTime(PSI,ksquareon2,g,V,DeltaT);
 
% PSI is now renormalized to keep the right number density correct so that
% the whole thing does not decay away entirely.
  
Natoms = sum(sum(abs(PSI.^2))).*DeltaX.^2;
PSI = (sqrt(InitialNatoms)/sqrt(Natoms)) .* PSI;

Energy(1,ii) = GPE_Energy_2D(PSI,k,g,V,DeltaT);
end


save(['./Data/Ground_state_grid_' num2str(Points) '.mat'],'PSI')

GroundPSI = PSI;
    


end