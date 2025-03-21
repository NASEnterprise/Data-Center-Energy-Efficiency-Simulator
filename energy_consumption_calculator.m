% Function to calculate server energy consumption based on CPU utilization
function serverEnergy = calculateServerEnergy(cpuUtilization, serverPowerRating)
    % Server power usage scales linearly with CPU utilization
    serverEnergy = (cpuUtilization / 100) * serverPowerRating;
end

% Function to calculate total energy consumption including cooling system
function totalEnergy = calculateTotalEnergy(cpuUtilization, serverPowerRating, PUE)
    % Calculate server energy consumption
    serverEnergy = calculateServerEnergy(cpuUtilization, serverPowerRating);
    
    % Calculate cooling system energy consumption
    coolingEnergy = serverEnergy * (PUE - 1);
    
    % Total energy consumption
    totalEnergy = serverEnergy + coolingEnergy;
end

% Example usage
cpuUtilization = 75; % CPU utilization in percentage
serverPowerRating = 10; % Server power rating in kW
PUE = 1.5; % Power Usage Effectiveness

% Calculate total energy consumption
totalEnergy = calculateTotalEnergy(cpuUtilization, serverPowerRating, PUE);

% Display the result
fprintf('Total Energy Consumption: %.2f kW\n', totalEnergy);