function [V,D] = AirProject_plourdeJack(~,inputs)

% Call Input variables from script 
W = inputs.Weight;
CLmax = inputs.CLmax;
S = inputs.S; 
oEFF = inputs.oEFF;
AR = inputs.AR;
CD0 = inputs.CD0; 
v_max = inputs.v_max;
rho = inputs.rho; % slugs/ft^3 at sea level
% Calculate Stall Velocity 
v_stall = sqrt(W/(0.5*rho*CLmax*S));

% Create a Velocity Vector between stall and maximum velocity
V = linspace(v_stall,v_max);

% Create an empty vector for Drag
D = zeros(1,length(V));

for velocity = 1:length(V)
   
    % calculate dynamic pressure lbf/ft2
    q = 0.5*rho*(V(velocity))^2;
    % calculate parasite drag lbf
    D_parasite = CD0 * q * S;
    % calculate induced drag lbf
    D_induced = (W^2)/(q*S*pi*oEFF*AR);
    % sum the drag terms for total drag lbf
    D(velocity) = D_parasite + D_induced;

end

