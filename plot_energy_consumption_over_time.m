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
%   cpuUtilization - CPU utilization in percentage (0-100)
%   PUE - Power Usage Effectiveness
% Output:
%   totalEnergy - Total energy consumption in watts (W)
function totalEnergy = calculateTotalEnergy(cpuUtilization, PUE)
    % Calculate energy consumption for one server
    serverEnergy = calculateServerEnergy(cpuUtilization);
    
    % Calculate cooling system energy consumption
    coolingEnergy = calculateCoolingEnergy(serverEnergy, PUE);
    
    % Total energy consumption (server + cooling)
    totalEnergy = serverEnergy + coolingEnergy;
end

% Example data for varying server loads over time
time = 0:1:23; % Time in hours
serverLoads = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 20, 30, 40, 50, 60]; % Server loads in percentage
PUE = 1.5; % Power Usage Effectiveness

% Calculate energy consumption over time
totalEnergyOverTime = arrayfun(@(load) calculateTotalEnergy(load, PUE), serverLoads);

% Plot energy consumption over time
figure;
plot(time, totalEnergyOverTime, '-o');
xlabel('Time (hours)');
ylabel('Total Energy Consumption (W)');
title('Energy Consumption Over Time');
grid on;