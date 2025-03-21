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

% Example usage
cpuUtilization = 75; % CPU utilization in percentage

% Calculate server energy consumption
serverEnergy = calculateServerEnergy(cpuUtilization);

% Display the result
fprintf('Server Energy Consumption at %d%% CPU Utilization: %.2f W\n', cpuUtilization, serverEnergy);