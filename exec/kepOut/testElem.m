clear all 
close all

object = input('Name of the object? ', 's');
%fileMerc     = strcat(object,'.aei');
%fileMerc    = strcat('mercY1dm2/',object,'.aei');
fileMerc    =  strcat('merc/',object,'.aei');
fileMercNoY  = strcat('merc/',object,'.aei');
fileOrb9     = strcat('orb9/v',object,'.kep');
%fileOrb9y    = strcat('orb9y/v',object,'.kep');
fileOrb9y    = strcat('mercY1dm3/',object,'.aei');

test = load(fileMerc);
t_merc     = test(:,1)/10^6; 
a_merc     = test(:,2); 
e_merc     = test(:,3); 
i_merc     = test(:,4); 
Omnod_merc = test(:,5); 
omeg_merc  = test(:,7); 

%test = load(fileMercNoY);
%t_mercNoY     = test(:,1); 
%a_mercNoY     = test(:,2); 
%e_mercNoY     = test(:,3); 
%i_mercNoY     = test(:,4); 
%Omnod_mercNoY = test(:,5); 
%omeg_mercNoY  = test(:,7); 

%test = load(fileOrb9);
%t_orb9     = test(:,1)/10^6; 
%a_orb9     = test(:,2); 
%e_orb9     = test(:,3); 
%i_orb9     = test(:,4); 
%Omnod_orb9 = test(:,5); 
%omeg_orb9  = test(:,7); 

test = load(fileOrb9y);
t_orb9y     = test(:,1)/10^6; 
a_orb9y     = test(:,2); 
e_orb9y     = test(:,3); 
i_orb9y     = test(:,4); 
Omnod_orb9y = test(:,5); 
omeg_orb9y  = test(:,7); 

figure(1)
subplot(311)
title(object)
hold on
%plot(t_mercNoY, a_mercNoY)
plot(t_merc, a_merc)
%plot(t_orb9, a_orb9)
plot(t_orb9y, a_orb9y)
xlabel('t (My)')
ylabel('a (AU)')
%legend('mercury', 'mercury + yarko','orb9','orb9 + yarko')
legend('mercury + yarko','orb9 + yarko')

subplot(312)
hold on
%plot(t_mercNoY, e_mercNoY)
plot(t_merc, e_merc)
%plot(t_orb9, e_orb9)
plot(t_orb9y, e_orb9y)
xlabel('t (My)')
ylabel('e')

subplot(313)
hold on
%plot(t_mercNoY, i_mercNoY)
plot(t_merc, i_merc)
%plot(t_orb9, i_orb9)
plot(t_orb9y, i_orb9y)
xlabel('t (My)')
ylabel('i (deg)')
