% 2D Soliton test code
 clear all
 close
 clc

% Real space information

Points = 300;
Range = 150;
DeltaX = Range/Points;
x = linspace(-Range/2,Range/2 - DeltaX,Points);
[X,Y] = meshgrid(x,x);


mkdir ./Data;

% Define potential here

r2 = X.^2 + Y.^2;

Thomas_Fermi = 20;

V = 1/2 * r2 / Thomas_Fermi^2; 

% Time step information
DeltaT = 0.001;
Time = 100;
Steps = floor(Time/DeltaT);


% K space information
dk = (2*pi)/Range;
kmax = (2*pi)/(DeltaX);
k = (-kmax/2:dk:kmax/2 -dk);
[Kx,Ky] = meshgrid(k,k);
k = sqrt(Kx.^2 + Ky.^2);
k = fftshift(k);

% Soliton set up

%Bright
N = 1;
n = 100;
Kv = 2*pi/Range *n;
PSI = N .* sech(X) .*exp(1i.*Kv.*X);
g = -1;


%Dark
g = 1;
PSI =  N*tanh(X).*N*tanh(X-10);%.*exp(1i.*Kv.*X);

phase = atan2(Y-2,X) -atan2(Y+2,X);

density = 2 - V;

PSI = real(sqrt(density)); %.*exp(1i*phase);

Ground_state = load('./Data/Ground_state');

PSI = Ground_state.PSI .*exp(1i*phase);

%InitialNatoms = sum(sum(abs(PSI.^2))).*DeltaX.^2;

% Initialize matrix to store evolution of soliton solutions
%Solutions = zeros(floor(Steps/1000),Points,Points);




% Loop to solve dynamics and plot the solution
for ii = 1:Steps;
    
% This uses the first oder Baker Hausdorff    
% PSI = Baker_Hausdorff_Oh(PSI,k,g,DeltaT);

% This uses the third oder Baker Hausdorff    
 PSI = Baker_Hausdorff_Oh3(PSI,k,g,V,DeltaT);
 
% This uses the third oder Baker Hausdorff with -iTime   
% PSI = Baker_Hausdorff_Oh3_iTime(PSI,k,g,V,DeltaT);
 
 %renormalize here
 
  
%Natoms = sum(sum(abs(PSI.^2))).*DeltaX.^2;
 
%PSI = (sqrt(InitialNatoms)/sqrt(Natoms)) .* PSI;

 
 
 
% This uses the First attempt at a Runga Kutta Method
 %PSI = RungaKuttaOne(PSI,k,g,DeltaT);

%Solutions(ii,:) = PSI(:,:);

% 
% %Plotting code
 if floor(ii/1000) == ii/1000
     save(['./Data/' num2str(ii/1000) '.mat'],'PSI')

     
% Natoms = sum(abs(Solutions(ii,:)).^2)*DeltaX;
% plot(x,(abs(Solutions(ii,:))))
% title(['Probability Density, N = ' num2str(Natoms) ]);
% xlabel('x axis');
% ylabel('Amplitude')
% drawnow;
% pause(0.001)
% % pause
subplot(121)
imagesc(x,x,abs(PSI).^2);
title('Density')
subplot(122)
imagesc(x,x,angle(PSI))
title('Phase')
set(gca,'ydir','normal')
drawnow
pause(0.01);

 end


end



