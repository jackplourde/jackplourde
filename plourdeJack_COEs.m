function [a,ecc,nu,inc,raan,aop] = plourdeJack_COEs(R_vect,V_vect)
%plourdeJack_COEs Calculate six COEs from R and V input Vectors

% constants
% earth's gravitational parameter 
mu_earth = 3.986004418*10^5; % km^3/sec^2
R_magnitude = norm(R_vect); % km
V_magnitude = norm(V_vect); % km/s
i_hat = [1 0 0];
j_hat = [0 1 0];
k_hat = [0 0 1];

%% calculate orbit constants
% specific mechanical energy
SME = ((V_magnitude^2)/2) - (mu_earth/R_magnitude);

% specific angular momentum
h = cross(R_vect,V_vect);

% calculate semi-major axis,a 
a = -mu_earth/(2*SME);

% calculate orbital period
period = 2*pi*sqrt((a^3)/mu_earth); % seconds
period_min = period/60; % minutes 
% calculate eccentricity vector
ecc_vect = (1/mu_earth)*(((V_magnitude^2)-(mu_earth/R_magnitude))*R_vect-(dot(R_vect,V_vect)*V_vect));
% calculate eccentricity 
ecc = norm(ecc_vect);
% calculate inclination
inc = acosd((dot(k_hat,h)/(norm(k_hat)*norm(h))));
% calculate node vector
n = cross(k_hat,h);
% calculate RAAN 
raan = acosd(dot(i_hat,n)/(norm(i_hat)*norm(n)));
% perform quadrant check for RAAN 
if n(2) < 0 
    raan = 360 - raan;
end
% calculate argument of periapsis, AOP  
aop = acosd(dot(n,ecc_vect)/(norm(n)*norm(ecc_vect)));
% perform quadrant check for AOP 
if ecc_vect(3) < 0 
    aop = 360 - aop;
end
% calculate true anomaly, nu 
nu = acosd(dot(ecc_vect,R_vect)/(norm(ecc_vect)*norm(R_vect))); 
% perform quadrant check for nu 
if (dot(R_vect,V_vect)) < 0 
    nu = 360 - nu; 
end
end

