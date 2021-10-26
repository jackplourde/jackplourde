% Jack Plourde Aero 215 Fall 2021
% Air Wrap Up Project
clear all; close all; clc;

% Constants and conversions 
knots2ftsec = 1.687810; % ft/sec
gamma = 1.4; 
R = 1716; % ft*lbf/(slug*R)
g = 32.1741; % ft/sec^2
rho_SL = 0.0023; % slugs/ft^3
pass_weight = 170; % lbf
Nautical2ft = 6076; % ft

%% Part 1A)
% Make Structures for the two aircraft
%RV8
RV10.Weight = 1605;% lbf
RV10.passengers = 4; % people
RV10.Weight = RV10.Weight + (RV10.passengers * pass_weight);
RV10.MaxFuel = 360; % lbf
RV10.CruiseAlt = 8000; % ft
RV10.CD0 = 0.0265;  
RV10.AR = 6.81; 
RV10.oEFF = 0.79;
RV10.CLmax = 1.15;
RV10.S = 148; % ft2
RV10.v_max = 175 * knots2ftsec; % ft/s
RV10.rho = 0.002378; % slug/ft3

% RV12
RV12.Weight = 740; %lbf
RV12.passengers = 2;
RV12.Weight = RV12.Weight + (RV12.passengers * pass_weight);
RV12.MaxFuel = 119; % lbf
RV12.CruiseAlt = 7500; % ft
RV12.CD0 = 0.0275;
RV12.AR = 5.63; 
RV12.oEFF = 0.78;
RV12.CLmax = 1.4;
RV12.S = 127; % ft2
RV12.v_max = 125 * knots2ftsec; % ft/s
RV12.rho = 0.002378; % slugs/ft4

% Max Weights
RV12Max = RV12;
RV12Max.Weight = RV12.Weight + RV12.MaxFuel; % lbf

RV10Max = RV10;
RV10Max.Weight = RV10.Weight + RV10.MaxFuel; % lbf

%% Part 1B)

% Estimate minimum drag value (lbf), minimum drag speed (knots), 
% and stall speed (ft/s). 

% RV10 (Empty)
[V_10,D_10] = AirProject_plourdeJack(RV10.v_max,RV10);
V_10 = V_10/knots2ftsec;

[drag10E,i] = min(D_10);
mindragv10 = V_10(i);

% RV10 (full) 
[V_10F,D_10F] = AirProject_plourdeJack(RV10.v_max,RV10Max);
V_10F = V_10F/knots2ftsec;

[drag10F,i] = min(D_10F);
mindragv10F = V_10F(i);


% RV12 (empty)
[V_12,D_12] = AirProject_plourdeJack(RV12.v_max,RV12);
V_12 = V_12/knots2ftsec;

[drag12E,i] = min(D_12);
mindragv12 = V_12(i);

% RV12 (full) 
[V_12F,D_12F] = AirProject_plourdeJack(RV12.v_max,RV12Max);
V_12F = V_12F/knots2ftsec;

[drag12F,i] = min(D_12F);
mindragv12F = V_12F(i);

disp("RV-10 (Empty Weight): ") 
disp("Minimum Drag Speed: " + mindragv10 + " knots")
disp("Minimum Drag: " + drag10E + " lbf")
disp("Stall Speed: " + V_10(1) + " knots")
disp(" ")
disp("RV-10 (Max Weight): ")
disp("Minimum Drag Speed: " + mindragv10F + " knots")
disp("Minimum Drag: " + drag10F + " lbf")
disp("Stall Speed: " + V_10F(1) + " knots")
disp(" ")
disp("RV-12iS (Empty Weight): ")
disp("Minimum Drag Speed: " + mindragv12 + " knots") 
disp("Minimum Drag: " + drag12E + " lbf")
disp("Stall Speed: " + V_12(1) + " knots")
disp(" ")
disp("RV-12iS (Max Weight): ")
disp("Minimum Drag Speed: " + mindragv12F + " knots")
disp("Minimum Drag: " + drag12F + " lbf")
disp("Stall Speed: " + V_12F(1) + " knots")

figure(1)
subplot(1,2,1)
title("Min Weight")
hold on
plot(V_10,D_10)
plot(V_12,D_12)
xlabel("Velocity, knots")
ylabel("Drag, lbf")
legend("RV-10", "RV-12iS")
subplot(1,2,2)
hold on
title("Max Weight")
plot(V_10F,D_10F,V_12F,D_12F)
xlabel("Velocity, knots")
ylabel("Drag, lbf")
legend("RV-10", "RV-12iS")
%% Part 2) 

% The RV-12iS and the RV-10 have different nominal operational 
% altitudes ("cruise altitude") given above; estimate the minimum drag value 
% (in lbf), the minimum drag speed (in knots) for
% each aircraft at their respective cruise altitudes, with full passenger load 
% and half fuel.

% Set cruise parameters 

CruiseRV10 = RV10;
CruiseRV10.rho = 0.00186850; % slugs/ft3
CruiseRV10.Weight = RV10.Weight + (0.5*RV10.MaxFuel);

CruiseRV12= RV12;
CruiseRV12.rho = 0.00189760; % slugs/ft^3
CruiseRV12.Weight = RV12.Weight + (0.5*RV12.MaxFuel);

% RV10
[V_10c,D_10c] = AirProject_plourdeJack(RV10.v_max,CruiseRV10);
V_10c = V_10c/knots2ftsec;

[mindrag10Cruise,i] = min(D_10c);
mindragv10Cruise = V_10c(i);

% RV12
[V_12c,D_12c] = AirProject_plourdeJack(RV12.v_max,CruiseRV12);
V_12c = V_12c/knots2ftsec;

[mindrag12Cruise,i] = min(D_12c);
mindragv12Cruise = V_12c(i);

disp(" ")
disp("RV-10 (Cruise): ") 
disp("Minimum Drag Speed: " + mindragv10Cruise + " knots")
disp("Minimum Drag: " + mindrag10Cruise + " lbf")
disp(" ")
disp("RV-12iS (Cruise): ")
disp("Minimum Drag Speed: " + mindragv12Cruise + " knots")
disp("Minimum Drag: " + mindrag12Cruise + " lbf")

%% Part 3
% need to convert power specific fuel consumption from gal/hour*hp into
% 1/ft in order to find the range. 
PSFC = 0.07; % gal/(hour*hp)
AVGAS_density = 6.01; % lbf/gal
Powerfromhp = 550; %hp to lbf*ft/sec
hour2sec = 3600; % sec
 
PSFC = 0.07 * AVGAS_density / Powerfromhp / hour2sec; % ft^-1

% RV-10
% RV10MidWeight = CruiseRV10;

Range_RV10 = (1/PSFC) * (CruiseRV10.Weight / mindrag10Cruise) * log(RV10Max.Weight/(RV10.Weight));% feet
Range_RV10 = Range_RV10/Nautical2ft; % Nautical Miles
FlightTime_RV10 = Range_RV10 / mindragv10Cruise; % hours
disp(" ")
disp("RV-10 Flight Range: " + Range_RV10 + " Nautical Miles") 
disp("RV-10 Flight Time: " + FlightTime_RV10 + " Hours")
disp(" ")
% RV-12iS
RV12MidWeight = CruiseRV12;

Range_RV12 = (1/PSFC)*(RV12MidWeight.Weight / mindrag12Cruise) * log(RV12Max.Weight/(RV12.Weight));
Range_RV12 = Range_RV12 / Nautical2ft; % Nautical Miles
FlightTIme_RV12 = Range_RV12 / mindragv12Cruise; % hours
disp("RV-12iS Flight Range: " + Range_RV12 + " Nautical Miles")
disp("RV-12iS Flight Time: " + FlightTIme_RV12 + " Hours")

%% Part 4 

% Using the cost of avgas given above and the results from Part 3, calculate
% the cost of the flight in total dollars spent on fuel,  then with that
% value find dollars per passenger, and dollars per passenger per 
% nautical mile. Assume all the fuel was consumed on the flight.

% cost of AVGAS 
AVGAS_cost = 5.04; % $/gal

AVGAS_cost_lbf = AVGAS_cost / AVGAS_density;

COST10 = RV10.MaxFuel * AVGAS_cost_lbf; % dollars
COST10_perPass = COST10 / RV10.passengers; % dollars per passenger
COST10_perPass_perNaut = COST10_perPass / Range_RV10; % dollars per person per nautical mile

COST12 = RV12.MaxFuel * AVGAS_cost_lbf; 
COST12_perPass = COST12 / RV12.passengers; 
COST12_perPass_perNaut = COST12/ (RV12.passengers * Range_RV12);

disp(" ")
disp("RV-10 Fuel Cost Analysis: ")
disp("Total Cost: $" + COST10)
disp("Cost Per Passenger: $" + COST10_perPass)
disp("Cost Per Passenger Per Nautical Mile: $" + COST10_perPass_perNaut)
disp(" ") 
disp("RV-12iS Fuel Cost Analysis: ")
disp("Total Cost: $" + COST12)
disp("Cost Per Passenger: $" + COST12_perPass)
disp("Cost Per Passenger Per Nautical Mile: $" + COST12_perPass_perNaut)