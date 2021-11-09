%% Jack Plourde AERO215 Fall 2021 
% Homework 3 COE's
clear all; close all; clc;
% Set state vector R and V, in ECI frame
R_vect = [-2315.9, 2168.6, 6314.5]; % kilometers
V_vect = [-3.0599, 6.0645, -3.2044]; % kilometers/sec

% Call COEs function 
[a,ecc,nu,inc,raan,aop] = plourdeJack_COEs(R_vect,V_vect);
% display resutls to command window 
disp("Part 4: ")
disp("Semi-major axis is: " + a + " kilometers")
disp("Eccentricity is: " + ecc + " (unitless)")  
disp("True anomoly is: " + nu + " degrees")
disp("Inclination is: " + inc + " degrees")
disp("RAAN is: " + raan + "degrees")
disp("AoP is: " + aop + " degrees")