clear all
close all

deg2rad = pi/180;

load orb9/v1.kep
load orb9/vEARTHMOON.kep

load mercury/c1.aei
load mercury/EARTHMOO.aei

t      = v1(:,1)/10^3;
a      = v1(:,2);
e      = v1(:,3);
inc    = v1(:,4);
Omnod  = v1(:,5);
omega  = v1(:,7);
ell    = v1(:,9);

t_E     = vEARTHMOON(:,1);
a_E     = vEARTHMOON(:,2);
e_E     = vEARTHMOON(:,3);
inc_E   = vEARTHMOON(:,4);
Omnod_E = vEARTHMOON(:,5);
omega_E = vEARTHMOON(:,7);
ell_E   = vEARTHMOON(:,9);

kozai = sqrt(1-e.^2).*cos(inc*deg2rad);
lambda   = ell   + omega   + Omnod;
lambda_E = ell_E + omega_E + Omnod_E;
lambda_r = mod(360, lambda - lambda_E);

figure(1)
subplot(611)
plot(t,kozai)
xlabel('t (Kyr)')
ylabel('\sqrt(1-e^2) sin(i)')

subplot(612)
plot(t,lambda_r)
xlabel('t (Kyr)')
ylabel('\lambda_r (deg)')

subplot(613)
plot(t,a)
xlabel('t (Kyr)')
ylabel('a (AU)')

subplot(614)
plot(t,e)
xlabel('t (Kyr)')
ylabel('e')

subplot(615)
plot(t,inc)
xlabel('t (Kyr)')
ylabel('i (deg)')

subplot(616)
plot(t,omega)
xlabel('t (Kyr)')
ylabel('\omega (deg)')

%=====================================

t      = c1(:,1)/10^3;
a      = c1(:,2);
e      = c1(:,3);
inc    = c1(:,4);
Omnod  = c1(:,5);
omega  = c1(:,6);
ell    = c1(:,7);

t_E     = EARTHMOO(:,1);
a_E     = EARTHMOO(:,2);
e_E     = EARTHMOO(:,3);
inc_E   = EARTHMOO(:,4);
Omnod_E = EARTHMOO(:,5);
omega_E = EARTHMOO(:,6);
ell_E   = EARTHMOO(:,7);

kozai = sqrt(1-e.^2).*cos(inc*deg2rad);
lambda   = ell   + omega   + Omnod;
lambda_E = ell_E + omega_E + Omnod_E;
lambda_r = mod(360, lambda - lambda_E);

figure(2)
subplot(611)
plot(t,kozai)
xlabel('t (Kyr)')
ylabel('\sqrt(1-e^2) sin(i)')

subplot(612)
plot(t,lambda_r)
xlabel('t (Kyr)')
ylabel('\lambda_r (deg)')

subplot(613)
plot(t,a)
xlabel('t (Kyr)')
ylabel('a (AU)')

subplot(614)
plot(t,e)
xlabel('t (Kyr)')
ylabel('e')

subplot(615)
plot(t,inc)
xlabel('t (Kyr)')
ylabel('i (deg)')

subplot(616)
plot(t,omega)
xlabel('t (Kyr)')
ylabel('\omega (deg)')

%=====================================
load orb9_ever/v1.kep
load orb9_ever/vEARTHMOON.kep

t      = v1(:,1)/10^3;
a      = v1(:,2);
e      = v1(:,3);
inc    = v1(:,4);
Omnod  = v1(:,5);
omega  = v1(:,7);
ell    = v1(:,9);

t_E     = vEARTHMOON(:,1);
a_E     = vEARTHMOON(:,2);
e_E     = vEARTHMOON(:,3);
inc_E   = vEARTHMOON(:,4);
Omnod_E = vEARTHMOON(:,5);
omega_E = vEARTHMOON(:,7);
ell_E   = vEARTHMOON(:,9);

kozai = sqrt(1-e.^2).*cos(inc*deg2rad);
lambda   = ell   + omega   + Omnod;
lambda_E = ell_E + omega_E + Omnod_E;
lambda_r = mod(360, lambda - lambda_E);

figure(3)
subplot(611)
plot(t,kozai)
xlabel('t (Kyr)')
ylabel('\sqrt(1-e^2) sin(i)')

subplot(612)
plot(t,lambda_r)
xlabel('t (Kyr)')
ylabel('\lambda_r (deg)')

subplot(613)
plot(t,a)
xlabel('t (Kyr)')
ylabel('a (AU)')

subplot(614)
plot(t,e)
xlabel('t (Kyr)')
ylabel('e')

subplot(615)
plot(t,inc)
xlabel('t (Kyr)')
ylabel('i (deg)')

subplot(616)
plot(t,omega)
xlabel('t (Kyr)')
ylabel('\omega (deg)')

%===========================================
load mercury_bs/c1.aei
load mercury_bs/EARTHMOO.aei


t      = c1(:,1)/10^3;
a      = c1(:,2);
e      = c1(:,3);
inc    = c1(:,4);
Omnod  = c1(:,5);
omega  = c1(:,6);
ell    = c1(:,7);

t_E     = EARTHMOO(:,1);
a_E     = EARTHMOO(:,2);
e_E     = EARTHMOO(:,3);
inc_E   = EARTHMOO(:,4);
Omnod_E = EARTHMOO(:,5);
omega_E = EARTHMOO(:,6);
ell_E   = EARTHMOO(:,7);

kozai = sqrt(1-e.^2).*cos(inc*deg2rad);
lambda   = ell   + omega   + Omnod;
lambda_E = ell_E + omega_E + Omnod_E;
lambda_r = mod(360, lambda - lambda_E);

figure(4)
subplot(611)
plot(t,kozai)
xlabel('t (Kyr)')
ylabel('\sqrt(1-e^2) sin(i)')

subplot(612)
plot(t,lambda_r)
xlabel('t (Kyr)')
ylabel('\lambda_r (deg)')

subplot(613)
plot(t,a)
xlabel('t (Kyr)')
ylabel('a (AU)')

subplot(614)
plot(t,e)
xlabel('t (Kyr)')
ylabel('e')

subplot(615)
plot(t,inc)
xlabel('t (Kyr)')
ylabel('i (deg)')

subplot(616)
plot(t,omega)
xlabel('t (Kyr)')
ylabel('\omega (deg)')

%=====================================
