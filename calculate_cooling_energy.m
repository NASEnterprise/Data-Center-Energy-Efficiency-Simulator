% Function to calculate cooling system energy consumption using PUE
% Inputs:
%   serverEnergy - Server energy consumption in watts (W)
%   PUE - Power Usage Effectiveness
% Output:
%   coolingEnergy - Cooling system energy consumption in watts (W)
function coolingEnergy = calculateCoolingEnergy(serverEnergy, PUE)
    % Cooling system energy consumption
    coolingEnergy = serverEnergy * (PUE - 1);
end

% Example usage
serverEnergy = 225; % Server energy consumption in watts (W)
PUE = 1.5; % Power Usage Effectiveness

% Calculate cooling system energy consumption
coolingEnergy = calculateCoolingEnergy(serverEnergy, PUE);

% Display the result
fprintf('Cooling System Energy Consumption: %.2f W\n', coolingEnergy);