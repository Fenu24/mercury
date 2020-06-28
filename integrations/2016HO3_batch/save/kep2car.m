function [x, v] = car2kep(a, e, inc, OmNod, omega, ell, wMass)
   m2au    = 1/149597870700;
   GMsun   = 1.32712440018d20*m2au^3;
   GMearth = 3.986004418d14*m2au^3;

   if(wMass==1)
      GM = GMsun + GMearth;
   else
      GM = GMsun;
   end
   
   inc   = deg2rad(inc);
   omega = deg2rad(omega);
   OmNod = deg2rad(OmNod);
   ell   = deg2rad(ell);

   com = cos(omega);
   som = sin(omega);
   R_om = [com -som 0;
           som  com 0;
             0    0 1];

   ci  = cos(inc);
   si  = sin(inc);
   R_i = [1   0   0;
          0  ci -si;
          0  si  ci];

   con = cos(OmNod);
   son = sin(OmNod);
   R_Omn = [con -son 0;
            son  con 0;
              0    0 1];
   % R = R_Omn*R_i*R_om
   R = R_Omn*R_i*R_om;
   u = keplereq(ell, e);

   cosu = cos(u);
   sinu = sin(u);
   pos = [a*(cosu - e);
          a*sqrt(1.d0-e^2)*sinu;
          0];
   
   dposdu = [-sinu*a;
              a*sqrt(1.d0-e^2)*cosu;
              0];

   norma   = norm(dposdu);
   versvel = dposdu/norma;
   normpos = norm(pos);
   
   normvel = GM*sqrt(2/normpos-1/a);
   vel = normvel*versvel;
   x = R*pos;
   v = R*vel;
end
