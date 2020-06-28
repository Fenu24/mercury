function u = keplereq(ell, e)
   jmax = 100;
   uk = pi;
   elle = mod(ell, 2*pi);
   for j=1:jmax
      ukp1 = uk + (elle-uk+e*sin(uk))/(1-e*cos(uk));
      if(abs(ukp1-uk)<1e-14)
          break;
      end
      uk=ukp1;
   end
   u = ukp1;
end
