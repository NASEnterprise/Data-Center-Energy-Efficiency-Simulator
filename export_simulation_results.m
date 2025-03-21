% Function to calculate server energy consumption based on CPU utilization
% Inputs:
%   cpuUtilization - CPU utilization in percentage (0-100)
%   serverPowerRating - Server power rating in kW
% Output:
%   serverEnergy - Server energy consumption in kW
function serverEnergy = calculateServerEnergy(cpuUtilization, serverPowerRating)
    % Server power usage scales linearly with CPU utilization
    serverEnergy = (cpuUtilization / 100) * serverPowerRating;
end

% Function to calculate total energy consumption including cooling system
% Inputs:
%   cpuUtilization - CPU utilization in percentage (0-100)
%   serverPowerRating - Server power rating in kW
%   PUE - Power Usage Effectiveness
% Output:
%   totalEnergy - Total energy consumption in kW
function totalEnergy = calculateTotalEnergy(cpuUtilization, serverPowerRating, PUE)
    % Calculate server energy consumption
    serverEnergy = calculateServerEnergy(cpuUtilization, serverPowerRating);
    
    % Calculate cooling system energy consumption
    coolingEnergy = serverEnergy * (PUE - 1);
    
    % Total energy consumption
    totalEnergy = serverEnergy + coolingEnergy;
end

% Function to calculate potential energy savings
% Inputs:
%   cpuUtilization - CPU utilization in percentage (0-100)
%   serverPowerRating - Server power rating in kW
%   PUE - Current Power Usage Effectiveness
%   optimalPUE - Optimal Power Usage Effectiveness
% Output:
%   potentialSavings - Potential energy savings in kW
function potentialSavings = calculatePotentialSavings(cpuUtilization, serverPowerRating, PUE, optimalPUE)
    % Calculate server energy consumption
    serverEnergy = calculateServerEnergy(cpuUtilization, serverPowerRating);
    
    % Calculate current cooling system energy consumption
    currentCoolingEnergy = serverEnergy * (PUE - 1);
    
    % Calculate optimal cooling system energy consumption
    optimalCoolingEnergy = serverEnergy * (optimalPUE - 1);
    
    % Potential energy savings
    potentialSavings = currentCoolingEnergy - optimalCoolingEnergy;
end

% Example usage
cpuUtilization = 75; % CPU utilization in percentage
serverPowerRating = 10; % Server power rating in kW
PUE = 1.5; % Current Power Usage Effectiveness
optimalPUE = 1.2; % Optimal Power Usage Effectiveness

% Calculate total energy consumption
totalEnergy = calculateTotalEnergy(cpuUtilization, serverPowerRating, PUE);

% Calculate potential energy savings
potentialSavings = calculatePotentialSavings(cpuUtilization, serverPowerRating, PUE, optimalPUE);

% Prepare data for CSV export
results = table(cpuUtilization, serverPowerRating, PUE, totalEnergy, potentialSavings, ...
    'VariableNames', {'CPU_Utilization', 'Server_Power_Rating', 'PUE', 'Total_Energy_Consumption', 'Potential_Savings'});

% Export results to CSV file
csvFileName = 'simulation_results.csv';
writetable(results, csvFileName);

% Display message
fprintf('Simulation results exported to %s\n', csvFileName);

% Generate a report summarizing the simulation results
reportFileName = 'simulation_report.txt';
fileID = fopen(reportFileName, 'w');
fprintf(fileID, 'Data Center Energy Efficiency Simulation Report\n');
fprintf(fileID, '=============================================\n\n');
fprintf(fileID, 'Simulation Parameters:\n');
fprintf(fileID, '----------------------\n');
fprintf(fileID, 'CPU Utilization: %d%%\n', cpuUtilization);
fprintf(fileID, 'Server Power Rating: %.2f kW\n', serverPowerRating);
fprintf(fileID, 'Current PUE: %.2f\n', PUE);
fprintf(fileID, 'Optimal PUE: %.2f\n\n', optimalPUE);

fprintf(fileID, 'Simulation Results:\n');
fprintf(fileID, '-------------------\n');
fprintf(fileID, 'Total Energy Consumption: %.2f kW\n', totalEnergy);
fprintf(fileID, 'Potential Energy Savings: %.2f kW\n\n', potentialSavings);

fprintf(fileID, 'Recommendations for AWS:\n');
fprintf(fileID, '------------------------\n');
fprintf(fileID, '1. Optimize cooling systems to achieve a PUE closer to %.2f.\n', optimalPUE);
fprintf(fileID, '2. Monitor and manage server loads to improve energy efficiency.\n');
fprintf(fileID, '3. Consider upgrading hardware to more energy-efficient models.\n');

fclose(fileID);

% Display message
fprintf('Simulation report generated: %s\n', reportFileName);