import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.FileWriter;
import java.io.IOException;

public class DataCenterEnergyReport {
    private static JTextField serverLoadField;
    private static JTextField coolingEfficiencyField;
    private static JTextField hardwarePowerField;
    private static JTextField numServersField;
    private static JLabel totalEnergyLabel;
    private static JLabel energySavingsLabel;

    public static void main(String[] args) {
        JFrame frame = new JFrame("Data Center Energy Efficiency Simulator");
        frame.setSize(400, 350);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(null);

        JLabel serverLoadLabel = new JLabel("Server Load (%)");
        serverLoadLabel.setBounds(20, 20, 150, 25);
        frame.add(serverLoadLabel);

        serverLoadField = new JTextField();
        serverLoadField.setBounds(200, 20, 150, 25);
        frame.add(serverLoadField);

        JLabel coolingEfficiencyLabel = new JLabel("Cooling Efficiency (PUE)");
        coolingEfficiencyLabel.setBounds(20, 60, 150, 25);
        frame.add(coolingEfficiencyLabel);

        coolingEfficiencyField = new JTextField();
        coolingEfficiencyField.setBounds(200, 60, 150, 25);
        frame.add(coolingEfficiencyField);

        JLabel hardwarePowerLabel = new JLabel("Hardware Power Rating (W)");
        hardwarePowerLabel.setBounds(20, 100, 150, 25);
        frame.add(hardwarePowerLabel);

        hardwarePowerField = new JTextField();
        hardwarePowerField.setBounds(200, 100, 150, 25);
        frame.add(hardwarePowerField);

        JLabel numServersLabel = new JLabel("Number of Servers");
        numServersLabel.setBounds(20, 140, 150, 25);
        frame.add(numServersLabel);

        numServersField = new JTextField();
        numServersField.setBounds(200, 140, 150, 25);
        frame.add(numServersField);

        JButton calculateButton = new JButton("Calculate");
        calculateButton.setBounds(150, 180, 100, 25);
        frame.add(calculateButton);

        totalEnergyLabel = new JLabel("Total Energy Consumption: ");
        totalEnergyLabel.setBounds(20, 220, 350, 25);
        frame.add(totalEnergyLabel);

        energySavingsLabel = new JLabel("Potential Energy Savings: ");
        energySavingsLabel.setBounds(20, 260, 350, 25);
        frame.add(energySavingsLabel);

        calculateButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                calculateEnergyConsumption();
            }
        });

        frame.setVisible(true);
    }

    private static void calculateEnergyConsumption() {
        try {
            double serverLoad = Double.parseDouble(serverLoadField.getText());
            double coolingEfficiency = Double.parseDouble(coolingEfficiencyField.getText());
            double hardwarePower = Double.parseDouble(hardwarePowerField.getText());
            int numServers = Integer.parseInt(numServersField.getText());

            double serverEnergy = calculateServerEnergy(serverLoad, hardwarePower);
            double totalServerEnergy = numServers * serverEnergy;
            double coolingEnergy = calculateCoolingEnergy(totalServerEnergy, coolingEfficiency);
            double totalEnergy = totalServerEnergy + coolingEnergy;

            double optimalPUE = 1.2;
            double optimalCoolingEnergy = totalServerEnergy * (optimalPUE - 1);
            double potentialSavings = coolingEnergy - optimalCoolingEnergy;

            totalEnergyLabel.setText(String.format("Total Energy Consumption: %.2f W", totalEnergy));
            energySavingsLabel.setText(String.format("Potential Energy Savings: %.2f W", potentialSavings));

            generateReport(serverLoad, coolingEfficiency, hardwarePower, numServers, totalEnergy, potentialSavings, optimalPUE);
        } catch (NumberFormatException ex) {
            JOptionPane.showMessageDialog(null, "Please enter valid numeric values.", "Input Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private static double calculateServerEnergy(double cpuUtilization, double serverPowerRating) {
        return (cpuUtilization / 100) * serverPowerRating;
    }

    private static double calculateCoolingEnergy(double serverEnergy, double PUE) {
        return serverEnergy * (PUE - 1);
    }

    private static void generateReport(double serverLoad, double coolingEfficiency, double hardwarePower, int numServers, double totalEnergy, double potentialSavings, double optimalPUE) {
        String reportFileName = "simulation_report.txt";
        try (FileWriter writer = new FileWriter(reportFileName)) {
            writer.write("Data Center Energy Efficiency Simulation Report\n");
            writer.write("=============================================\n\n");
            writer.write("Simulation Parameters:\n");
            writer.write("----------------------\n");
            writer.write(String.format("Server Load: %.2f%%\n", serverLoad));
            writer.write(String.format("Cooling Efficiency (PUE): %.2f\n", coolingEfficiency));
            writer.write(String.format("Hardware Power Rating: %.2f W\n", hardwarePower));
            writer.write(String.format("Number of Servers: %d\n\n", numServers));

            writer.write("Simulation Results:\n");
            writer.write("-------------------\n");
            writer.write(String.format("Total Energy Consumption: %.2f W\n", totalEnergy));
            writer.write(String.format("Potential Energy Savings: %.2f W\n\n", potentialSavings));

            writer.write("Recommendations for AWS:\n");
            writer.write("------------------------\n");
            writer.write(String.format("1. Optimize cooling systems to achieve a PUE closer to %.2f.\n", optimalPUE));
            writer.write("2. Monitor and manage server loads to improve energy efficiency.\n");
            writer.write("3. Consider upgrading hardware to more energy-efficient models.\n");

            JOptionPane.showMessageDialog(null, "Simulation report generated: " + reportFileName, "Report Generated", JOptionPane.INFORMATION_MESSAGE);
        } catch (IOException e) {
            JOptionPane.showMessageDialog(null, "Error writing report: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
}