clear all
close all

deg2rad = pi/180;

folder = input('Which folder? ','s');

cmd1 = strcat('load',32,folder,'/clo0.aei');
cmd2 = strcat('load',32,folder,'/EARTH.aei');
cmd3 = strcat('load',32,folder,'/meanElements.aei');
cmd4 = strcat('load',32,folder,'/standev.out');
eval(cmd1);
eval(cmd2);
eval(cmd3);
eval(cmd4)

c0     = clo0;

t      = c0(:,1)/10^3;
a      = c0(:,2);
e      = c0(:,3);
inc    = c0(:,4);
Omnod  = c0(:,5);
omega  = c0(:,6);
ell    = c0(:,7);

t_mean      = meanElements(:,1)/10^3;
a_mean      = meanElements(:,2);
e_mean      = meanElements(:,3);
inc_mean    = meanElements(:,4);
Omnod_mean  = meanElements(:,5);
omega_mean  = meanElements(:,6);
ell_mean    = meanElements(:,7);

a_std       = standev(:,2);
e_std       = standev(:,3);
inc_std     = standev(:,4);
Omnod_std   = standev(:,5);
omega_std   = standev(:,6);
ell_std     = standev(:,7);

t_E     = EARTH(:,1)/10^3;
a_E     = EARTH(:,2);
e_E     = EARTH(:,3);
inc_E   = EARTH(:,4);
Omnod_E = EARTH(:,5);
omega_E = EARTH(:,6);
ell_E   = EARTH(:,7);

for i=1:length(t)
   [x0, v0] = kep2car(a(i), e(i), inc(i), Omnod(i), omega(i), ell(i), 0);
   [xE, vE] = kep2car(a_E(i), e_E(i), inc_E(i), Omnod_E(i), omega_E(i), ell_E(i), 1);
   dist_Earth(i) = norm(x0-xE);
end

kozai = sqrt(1-e.^2).*cos(inc*deg2rad);
lambda   = ell   + omega   + Omnod;
lambda_E = ell_E + omega_E + Omnod_E;
lambda_r = mod(lambda - lambda_E, 360);


kozai_mean = sqrt(1-e_mean.^2).*cos(inc_mean*deg2rad);
lambda_mean   = ell_mean   + omega_mean   + Omnod_mean;
lambda_E = ell_E + omega_E + Omnod_E;
lambda_r_mean = mod(lambda_mean - lambda_E, 360);

for i=1:length(omega)
   if(omega(i)>180)
      omega(i)=omega(i)-360;
   end
   if(lambda_r(i)>180)
      lambda_r(i)=lambda_r(i)-360;
   end

   if(lambda_r_mean(i)>180)
      lambda_r_mean(i)=lambda_r_mean(i)-360;
   end

   if(omega_mean(i)>180)
      omega_mean(i) = omega_mean(i) - 360;
   end
end



figure(1)

set(gcf,'color','w');
set(gcf,'Position',[0 0 1700 700])

blue = [0, 0.4470, 0.7410];

h1 = subplot(711);
plot(t,lambda_r, 'color', blue)
hold on
plot(t_mean,lambda_r_mean, 'color', 'k')
%xlabel('t (Kyr)')
set(gca,'Xticklabel',[])
ylim([-200 200])
yticks([-150 -100 -50 0 50 100 150])
ylabel('$\lambda_r$ (deg)','interpreter','latex')

h2 = subplot(712);
c1 = a_mean'-a_std';
c2 = a_mean'+a_std';
t2 = [t_mean' flipud(t_mean)'];
inB = [c1 fliplr(c2)];
fill(t2', inB', [160/256 160/256 160/256]);

hold on
plot(t,a, 'color', blue)
plot(t_mean, a_mean, 'color', 'k')
%xlabel('t (Kyr)')
ylim([0.99 1.01])
yticks([0.996 1 1.005])
set(gca,'Xticklabel',[])
ylabel('a (AU)')

h3 = subplot(713);
hold on

c1 = e_mean'-e_std';
c2 = e_mean'+e_std';
t2 = [t_mean' flipud(t_mean)'];
inB = [c1 fliplr(c2)];
fill(t2', inB', [160/256 160/256 160/256]);

plot(t,e, 'color', blue)
plot(t_mean, e_mean, 'color', 'k')

%xlabel('t (Kyr)')
set(gca,'Xticklabel',[])
ylabel('e')
ylim([0 0.25])
yticks([0.05 0.1 0.15 0.2])

h4 = subplot(714);
c1 = inc_mean'-inc_std';
c2 = inc_mean'+inc_std';
t2 = [t_mean' flipud(t_mean)'];
inB = [c1 fliplr(c2)];
fill(t2', inB', [160/256 160/256 160/256]);

hold on
plot(t,inc, 'color', blue)
plot(t_mean, inc_mean, 'color', 'k')
set(gca,'Xticklabel',[])
ylabel('$i$ (deg)','interpreter','latex')
ylim([0 15])
yticks([2 4 6 8 10 12 14])

h5 = subplot(715);
hold on
c1 = omega_mean'-omega_std';
c2 = omega_mean'+omega_std';
t2 = [t_mean' flipud(t_mean)'];
inB = [c1 fliplr(c2)];
fill(t2', inB', [160/256 160/256 160/256]);

plot(t,omega, 'color', blue)
plot(t_mean,omega_mean, 'color', 'k')
ylim([-200 200])
yticks([-150 -100 -50 0 50 100 150])
ylabel('$\omega$ (deg)','interpreter','latex')

h6 = subplot(716);
plot(t,kozai,'color', blue)
hold on
plot(t_mean,kozai_mean, 'color', 'k') 
set(gca,'Xticklabel',[])
ylim([0.95 1])
yticks([0.96 0.97 0.98 0.99 1])
ylabel('$\sqrt{1-e^2} \cos i$','interpreter','latex')

h7 = subplot(717);
semilogy(t,dist_Earth,'color', blue)
hold on
semilogy([t(1) t(end)], [0.0098 0.0098], 'k-');
ylim([0.008 2.5])
ylabel('$d_E$','interpreter','latex')
xlabel('t (kyr)')

p1 = get(h1, 'Position');
p2 = get(h2, 'Position');
p3 = get(h3, 'Position');
p4 = get(h4, 'Position');
p5 = get(h5, 'Position');
p6 = get(h6, 'Position');
p7 = get(h7, 'Position');

hfig = p6(2)-p7(2);
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
p7(4) = hfig;

set(h1, 'Position', p1)
set(h2, 'Position', p2)
set(h3, 'Position', p3)
set(h4, 'Position', p4)
set(h5, 'Position', p5)
set(h6, 'Position', p6)
set(h7, 'Position', p7)


