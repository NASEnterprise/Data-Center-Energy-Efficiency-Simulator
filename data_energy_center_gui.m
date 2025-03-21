function data_energy_center_gui
    % Create the GUI
    fig = uifigure('Name', 'Data Center Energy Efficiency Simulator', 'Position', [100 100 400 300]);

    % Server Load Input
    uilabel(fig, 'Position', [20 250 150 22], 'Text', 'Server Load (%)');
    serverLoadInput = uieditfield(fig, 'numeric', 'Position', [200 250 100 22]);

    % Cooling System Efficiency Input
    uilabel(fig, 'Position', [20 200 150 22], 'Text', 'Cooling Efficiency (PUE)');
    coolingEfficiencyInput = uieditfield(fig, 'numeric', 'Position', [200 200 100 22]);

    % Hardware Configurations Input
    uilabel(fig, 'Position', [20 150 150 22], 'Text', 'Hardware Power Rating (W)');
    hardwarePowerInput = uieditfield(fig, 'numeric', 'Position', [200 150 100 22]);

    % Number of Servers Input
    uilabel(fig, 'Position', [20 100 150 22], 'Text', 'Number of Servers');
    numServersInput = uieditfield(fig, 'numeric', 'Position', [200 100 100 22]);

    % Calculate Button
    calculateButton = uibutton(fig, 'Position', [150 50 100 22], 'Text', 'Calculate', ...
        'ButtonPushedFcn', @(btn, event) calculateEnergyConsumption(serverLoadInput.Value, coolingEfficiencyInput.Value, hardwarePowerInput.Value, numServersInput.Value));

    % Output Labels
    totalEnergyLabel = uilabel(fig, 'Position', [20 20 350 22], 'Text', 'Total Energy Consumption: ');
    energySavingsLabel = uilabel(fig, 'Position', [20 0 350 22], 'Text', 'Potential Energy Savings: ');

    function calculateEnergyConsumption(serverLoad, coolingEfficiency, hardwarePower, numServers)
        % Energy Consumption Model
        serverEnergy = calculateServerEnergy(serverLoad, hardwarePower);
        totalServerEnergy = numServers * serverEnergy;
        coolingEnergy = totalServerEnergy * (coolingEfficiency - 1);
        totalEnergy = totalServerEnergy + coolingEnergy;

        % Potential Energy Savings (example calculation)
        optimalPUE = 1.2; % Example optimal PUE
        optimalCoolingEnergy = totalServerEnergy * (optimalPUE - 1);
        potentialSavings = coolingEnergy - optimalCoolingEnergy;

        % Update Output Labels
        totalEnergyLabel.Text = sprintf('Total Energy Consumption: %.2f W', totalEnergy);
        energySavingsLabel.Text = sprintf('Potential Energy Savings: %.2f W', potentialSavings);
    end

    function serverEnergy = calculateServerEnergy(cpuUtilization, serverPowerRating)
        % Server power usage scales linearly with CPU utilization
        serverEnergy = (cpuUtilization / 100) * serverPowerRating;
    end
end