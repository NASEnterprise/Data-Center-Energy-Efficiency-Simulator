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

% Example data for varying server loads over time
time = 0:1:23; % Time in hours
serverLoads = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 20, 30, 40, 50, 60]; % Server loads in percentage
serverPowerRating = 10; % Server power rating in kW
PUE = 1.5; % Power Usage Effectiveness

% Calculate energy consumption over time
totalEnergyOverTime = arrayfun(@(load) calculateTotalEnergy(load, serverPowerRating, PUE), serverLoads);

% Plot energy consumption over time
figure;
plot(time, totalEnergyOverTime, '-o');
xlabel('Time (hours)');
ylabel('Total Energy Consumption (kW)');
title('Energy Consumption Over Time');
grid on;

% Example data for different hardware configurations
hardwareConfigurations = [5, 10, 15, 20]; % Different server power ratings in kW
serverLoad = 75; % Fixed server load in percentage

% Calculate energy consumption for different hardware configurations
totalEnergyForConfigs = arrayfun(@(power) calculateTotalEnergy(serverLoad, power, PUE), hardwareConfigurations);

% Create bar chart to compare energy consumption for different hardware configurations
figure;
bar(hardwareConfigurations, totalEnergyForConfigs);
xlabel('Hardware Power Rating (kW)');
ylabel('Total Energy Consumption (kW)');
title('Energy Consumption for Different Hardware Configurations');
grid on;