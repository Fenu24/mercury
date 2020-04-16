clear all
close all

deg2rad = pi/180;

load c0.aei
load EARTH.aei

t      = c0(:,1)/10^3;
a      = c0(:,2);
e      = c0(:,3);
inc    = c0(:,4);
Omnod  = c0(:,5);
omega  = c0(:,6);
ell    = c0(:,7);

t_E     = EARTH(:,1);
a_E     = EARTH(:,2);
e_E     = EARTH(:,3);
inc_E   = EARTH(:,4);
Omnod_E = EARTH(:,5);
omega_E = EARTH(:,6);
ell_E   = EARTH(:,7);

kozai = sqrt(1-e.^2).*cos(inc*deg2rad);
lambda   = ell   + omega   + Omnod;
lambda_E = ell_E + omega_E + Omnod_E;
lambda_r = mod(lambda - lambda_E, 360);

for i=1:length(omega)
   if(omega(i)>180)
      omega(i)=omega(i)-360;
   end
   if(lambda_r(i)>180)
      lambda_r(i)=lambda_r(i)-360;
   end
end



figure(1)

set(gcf,'color','w');

h1 = subplot(611);
plot(t,kozai)
hold on
%xlabel('t (Kyr)')
set(gca,'Xticklabel',[])
ylim([0.95 1])
yticks([0.96 0.97 0.98 0.99 1])
ylabel('$\sqrt{1-e^2} \cos i$','interpreter','latex')
%title('469219 Kamoʻoalewa')
title('No Yarkovsky')

h2 = subplot(612);
plot(t,lambda_r)
hold on
%xlabel('t (Kyr)')
set(gca,'Xticklabel',[])
ylim([-200 200])
yticks([-150 -100 -50 0 50 100 150])
ylabel('$\lambda_r$ (deg)','interpreter','latex')

h3 = subplot(613);
plot(t,a)
hold on
%xlabel('t (Kyr)')
ylim([0.99 1.01])
yticks([0.996 1 1.005])
set(gca,'Xticklabel',[])
ylabel('a (AU)')

h4 = subplot(614);
plot(t,e)
hold on
%xlabel('t (Kyr)')
set(gca,'Xticklabel',[])
ylabel('e')
ylim([0 0.25])
yticks([0.05 0.1 0.15 0.2])

h5 = subplot(615);
plot(t,inc)
hold on
set(gca,'Xticklabel',[])
ylabel('$i$ (deg)','interpreter','latex')
ylim([0 15])
yticks([2 4 6 8 10 12 14])

h6 = subplot(616);
plot(t,omega)
hold on
ylim([-200 200])
yticks([-150 -100 -50 0 50 100 150])
xlabel('t (kyr)')
ylabel('$\omega$ (deg)','interpreter','latex')

p1 = get(h1, 'Position');
p2 = get(h2, 'Position');
p3 = get(h3, 'Position');
p4 = get(h4, 'Position');
p5 = get(h5, 'Position');
p6 = get(h6, 'Position');

hfig = p5(2)-p6(2);
eps = hfig*0.5/100;
%p1(4) = hfig-eps;
%p2(4) = hfig-eps;
%p3(4) = hfig-eps;
%p4(4) = hfig-eps;
%p5(4) = hfig-eps;
%p6(4) = hfig-eps;
p1(4) = hfig;
p2(4) = hfig;
p3(4) = hfig;
p4(4) = hfig;
p5(4) = hfig;
p6(4) = hfig;

set(h1, 'Position', p1)
set(h2, 'Position', p2)
set(h3, 'Position', p3)
set(h4, 'Position', p4)
set(h5, 'Position', p5)
set(h6, 'Position', p6)


