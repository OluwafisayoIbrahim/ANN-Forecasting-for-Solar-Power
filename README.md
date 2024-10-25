# ANN-Forecasting-for-Solar-Power
## Project Overview
This project focuses on forecasting solar power generation using Artificial Neural Networks (ANN). The motivation stems from the need to enhance accuracy in solar power predictions, which is critical for balancing energy generation with demand. ANN models were selected due to their ability to model complex relationships in weather and solar data, outperforming traditional methods in prediction precision.

## Problem Statement
Solar energy generation is inherently variable due to factors like weather conditions, which complicates energy planning and management. Existing methods for forecasting solar power often suffer from inaccuracies, leading to inefficiencies in power grids. This project proposes an ANN-based approach to address these limitations, ensuring better solar energy forecasting.

## Key Objectives
1. Data Acquisition: Collect solar irradiance, temperature, voltage, and other environmental parameters as inputs.
2. Model Design: Develop an ANN architecture to forecast solar power generation accurately.
3. Implementation: Use MATLAB to train and test the ANN model on real-world data.
4. Performance Evaluation: Measure model effectiveness using metrics like MAE, RMSE, MAPE, and R².

## Methodology
The process involves:

1. Data Collection: Solar data was gathered using pyranometers, solar panels, and sensors at Olabisi Onabanjo University, Ogun State.
2. Preprocessing: Data was cleaned, normalized, and split into training, validation, and testing sets to ensure high-quality input for the ANN.
3. Model Development: A feedforward ANN was designed and trained using the Levenberg-Marquardt algorithm.
4. Testing and Validation: The model's performance was evaluated against several metrics to ensure forecasting accuracy.
   
## Results
The ANN model achieved high accuracy with a low Mean Absolute Percentage Error (MAPE) ranging between 0.32% to 0.60%. The forecasting outcomes provide a reliable basis for managing solar energy resources, demonstrating the ANN model’s capability to enhance energy planning.

## Key Features
ANN Architecture: Feedforward network trained on weather and electrical data.
MATLAB Integration: Implemented with MATLAB’s neural network toolbox for smooth training and visualization.
Performance Metrics: Evaluation using RMSE, MAE, MAPE, and R² to ensure robust forecasting.

## Technologies Used
1. MATLAB: For ANN model development and data visualization.
2. Hardware: Pyranometers, solar panels, and digital thermometers, digitial multimeter for data collection.

## Code Workflow
Load Data for Each Day:

```matlab

data_monday = readtable('solar_data_mon_27th.csv');
data_tuesday = readtable('solar_data_tue_28th.csv');
% (Repeat for other days) ```

Extract Inputs and Targets:

matlab
Copy code
inputs_monday = [data_monday.SolarIrradiance, data_monday.Current, ...];
targets_monday = data_monday.Power;
Train the ANN Model:

matlab
Copy code
[mae_monday, rmse_monday, r2_monday, outputs_monday] = ...
    train_and_test_ann(inputs_monday, targets_monday, inputs_monday, targets_monday);
Plot Predicted vs. Actual Power:

matlab
Copy code
figure;
plot(time_monday, targets_monday, 'b-', 'LineWidth', 2);
plot(time_monday, predicted_monday, 'r-', 'LineWidth', 2);
legend('Actual', 'Predicted');
grid on;
Overall Performance Metrics:

matlab
Copy code
mae_week = mean([mae_monday, mae_tuesday, ...]);
fprintf('MAE: %.2f W\n', mae_week);
ANN Training Function:

matlab
Copy code
function [mae, rmse, r2, outputs] = train_and_test_ann(inputs_training, targets_training, ...)
    net = fitnet(10); % Hidden layer size of 10
    net.trainFcn = 'trainlm'; % Levenberg-Marquardt algorithm
    net.trainParam.epochs = 8000;
    net = train(net, inputs_training', targets_training');
    outputs = sim(net, inputs_testing');
end
Results
MAE: Achieved low errors between 0.32% to 0.60%.
RMSE and R²: Validated the accuracy and reliability of the predictions.
Outcome: The ANN model enabled early project completion and effective solar power forecasting for grid stability.
