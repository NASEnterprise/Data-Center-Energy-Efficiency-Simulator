% Function to calculate server energy consumption based on CPU utilization
% Inputs:
%   cpuUtilization - CPU utilization in percentage (0-100)
% Output:
%   serverEnergy - Server energy consumption in watts (W)
function serverEnergy = calculateServerEnergy(cpuUtilization)
    % Server power usage at 100% load
    maxPower = 300; % in watts (W)
    
    % Server power usage scales linearly with CPU utilization
    serverEnergy = (cpuUtilization / 100) * maxPower;
end

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

% Function to calculate total energy consumption (server + cooling)
% Inputs:
%   numServers - Number of servers in the data center
%   cpuUtilization - CPU utilization in percentage (0-100)
%   PUE - Power Usage Effectiveness
% Output:
%   totalEnergy - Total energy consumption in watts (W)
function totalEnergy = calculateTotalEnergy(numServers, cpuUtilization, PUE)
    % Calculate energy consumption for one server
    serverEnergy = calculateServerEnergy(cpuUtilization);
    
    % Calculate total server energy consumption for all servers
    totalServerEnergy = numServers * serverEnergy;
    
    % Calculate total cooling system energy consumption
    totalCoolingEnergy = calculateCoolingEnergy(totalServerEnergy, PUE);
    
    % Total energy consumption (server + cooling)
    totalEnergy = totalServerEnergy + totalCoolingEnergy;
end

% Example usage
numServers = 100; % Number of servers in the data center
cpuUtilization = 75; % CPU utilization in percentage
PUE = 1.5; % Power Usage Effectiveness

% Calculate total energy consumption
totalEnergy = calculateTotalEnergy(numServers, cpuUtilization, PUE);

% Display the result
fprintf('Total Energy Consumption for %d Servers at %d%% CPU Utilization: %.2f W\n', numServers, cpuUtilization, totalEnergy);