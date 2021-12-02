%% Jack Plourde AERO 215, Fall 2021
% Space Wrap Up Project
clear all; close all; clc;

% Potentially useful constants 
g0 = 9.80665; % m/s^2
mu_earth = 3.986004418*10^5; % km^3/sec^2
%% Part 1 COEs
% Calculate Cargo Dragon C208 COEs
    % Given vectors: 
    R_dragon0 = [-406.663, -4186.877, -5059.146]; % km
    V_dragon0 = [7.386, -2.178, 1.1889]; % km/s
    
    % Call function
        [a_drag0,ecc_drag0,nu_drag0,inc_drag0,raan_drag0,aop_drag0] = plourdeJack_COEs(R_dragon0,V_dragon0);
    
    % find radius of apogee
    R_drag0_apogee = a_drag0*(1+ecc_drag0); % km
    
    % find radius of perigee 
    R_drag0_perigee = a_drag0*(1-ecc_drag0); % km   
% Calculate ISS COEs
    % Given Vectors
    R_ISS0 = [5648.682, -2337.321, 2943.766]; % km
    V_ISS0 = [-0.208, 5.799, 5.008]; % km/s
    
    % Call function
    [a_ISS0,ecc_ISS0,nu_ISS0,inc_ISS0,raan_ISS0,aop_ISS0] = plourdeJack_COEs(R_ISS0,V_ISS0);
    
    % find radius of apogee
    R_ISS0_apogee = a_ISS0*(1+ecc_ISS0); % km
    
    % find radius of perigee 
    R_ISS0_perigee = a_ISS0*(1-ecc_ISS0); % km    
 %  Display to command window
disp("Part 1A (COEs): ")
disp("Cargo Dragon C208 COEs: ")
disp("Semi-Major Axis: " + a_drag0 + " (kilometers)")
disp("Eccentricity: " + ecc_drag0 + " (unitless)")
disp("True Anomaly: " + nu_drag0 + " (degrees)")
disp("Inclination: " + inc_drag0 + " (degrees)")
disp("RAAN: " + raan_drag0 + " (degrees)")
disp("AoP: " + aop_drag0 + " (degrees)") 
disp("ISS COEs: ")
disp("Semi-Major Axis: " + a_ISS0 + " (kilometers)")
disp("Eccentricity: " + ecc_ISS0 + " (unitless)")
disp("True Anomaly: " + nu_ISS0 + " (degrees)")
disp("Inclination: " + inc_ISS0 + " (degrees)")
disp("RAAN: " + raan_ISS0 + " (degrees)")
disp("AoP: " + aop_ISS0 + " (degrees)") 
disp("Part 1B: ")
disp("Dragon Perigee Radius: " + R_drag0_perigee + " km")
disp("Dragon Apogee Radius: " + R_drag0_apogee + " km")
disp("ISS Perigee Radius: " + R_ISS0_perigee + " km")
disp("ISS Apogee Radius: " + R_ISS0_apogee + " km")

%Comments: 
%The Dragon's perigee radius is less than the ISS's perigee radius, by
%about 200 km. However, the apogee of dragon, while still less than the
%space station, is only about 120 km away from the ISS. This means it
%makes the most sense to circularize and rendesvous at apogee, which
%requires the least amount of delta-V, and is also safer than crossing the
%two orbits of the spacecrafts. 
%The inclinations of the two spacecraft are nearly identical, this makes
%sense because an in orbit plane change would be costly. So Falcon 9 would
%want to launch into that inclination, instead of launching equatorially
%and then trying to match the inclination of the ISS. 


%% Part 2
% Find the ΔV to circularize Cargo Dragon C208 at initial apogee. 
    % find Specific Mechanical Energy of initial orbit 
    SME_drag0 = -mu_earth/(2*a_drag0);
    % find velocity of initial orbit at apogee
     V_drag0_apogee = sqrt(2*(SME_drag0 + (mu_earth/R_drag0_apogee))); % km/s
    % find SME of circular orbit 
     R_circ = R_drag0_apogee; % km, circular at R_i_apogee
    SME_circ = -mu_earth/(2*R_circ);
    
    % find velocity of circular orbit 
    V_circ = sqrt(2*(SME_circ + (mu_earth/R_circ))); % km/s;
    
    % find delta-V to circularize the initial orbit 
    dV_circ = abs(V_circ - V_drag0_apogee); % km/s
disp(" ")
disp("Part 2 (Circularizing Dragons Orbit): ")
disp("ΔV to Circularize: " + dV_circ + " km/s")
%% Part 3 

dragon_ISP = 316; % sec
dragon_mfinal = 12568; % kg
dV_circ = dV_circ*1000; % m/s
dragon_m0 = exp(dV_circ/(dragon_ISP*g0))*dragon_mfinal; %kg 
dragon_mpropUSED = dragon_m0 - dragon_mfinal;
dragon_VpropUSED = dragon_mpropUSED/1000; % meters^3
disp(" ")
disp("Part 3 (Propellant Used: ")
disp("Biprop mass used to circularize: " + dragon_mpropUSED + " kg")
disp("Biprop volume needed for circularization: " + dragon_VpropUSED + " m^3")


