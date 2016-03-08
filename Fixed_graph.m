subplot(121)
imagesc(x,x,abs(PSI(:,:)).^2);
set(gca,'ydir','normal')
title('Density')
axis square
subplot(122)
imagesc(x,x,angle(PSI(:,:)))
title('Phase')
set(gca,'ydir','normal')
axis square