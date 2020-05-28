close all
clear all

object = input('Name of the object? ', 's');

% Check if the file exists, only for test1
if(not(isfile(strcat('../test1/v',object,'.kep'))))
   errorMsg = "ERROR: file for object " + object + " not found";
   disp(errorMsg)
   return
end

% Take the tests to print
testIndexesStr = input('Which tests do you want to plot? ','s');
if( strcmp(testIndexesStr,'all'))
   testIndexes = 1:10;
else
   testIndexes = str2num(testIndexesStr);
end

% Load and plot files
for i=testIndexes
   legendCell{find(testIndexes==i)} = strcat('test ', num2str(i));
   file  = strcat('../test',num2str(i),'/v',object,'.kep');
   test = load(file);
   t     = test(:,1)/10^6; 
   a     = test(:,2); 
   e     = test(:,3); 
   i     = test(:,4); 
   Omnod = test(:,5); 
   omeg  = test(:,7); 
   figure(1)
   subplot(211)
   hold on
   plot(t,a)
   subplot(212)
   hold on
   plot(t,e)

   figure(2)
   subplot(311)
   hold on
   plot(t,i)
   subplot(312)
   hold on
   plot(t,Omnod)
   subplot(313)
   hold on
   plot(t,omeg)
end
figure(1)
subplot(211)
title(object)
legend(legendCell)
xlabel('t (Myr)')
ylabel('a (au)')
subplot(212)
xlabel('t (Myr)')
ylabel('e')

figure(2)
subplot(311)
title(object)
legend(legendCell)
xlabel('t (Myr)')
ylabel('i (deg)')
subplot(312)
xlabel('t (Myr)')
ylabel('\Omega (deg)')
subplot(313)
xlabel('t (Myr)')
ylabel('\omega (deg')
