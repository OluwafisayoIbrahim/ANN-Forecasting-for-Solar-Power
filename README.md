# ANN-Forecasting-for-Solar-Power

## Project Overview

This repository documents my undergraduate research project on solar power prediction using Artificial Neural Networks (ANN), completed at Olabisi Onabanjo University in 2023.

The project explored the application of machine learning to solar energy systems by developing a feedforward neural network in MATLAB to estimate solar power output from environmental and electrical measurements.

It includes the original MATLAB implementation, experimental data, model evaluation, and visualisation procedures. The study was subsequently revisited and extended in Python to improve experimental validation and assess the reliability of the original findings.

## Problem Statement

Solar power generation varies with environmental conditions, including solar irradiance, temperature, and humidity. Predicting solar power output can support energy planning, operational monitoring, and renewable energy management.

This project investigated whether an artificial neural network could model relationships between measured environmental and electrical variables and solar power generation.

The objective was to explore the use of ANN-based prediction in renewable energy systems and evaluate its performance using experimentally collected data.

## Research Objectives

1. Collect and organise solar irradiance, temperature, humidity, current, voltage, and power measurements.
2. Design and implement a feedforward artificial neural network in MATLAB.
3. Train the model using the Levenberg–Marquardt optimisation algorithm.
4. Evaluate model predictions using regression error metrics.
5. Investigate the suitability and limitations of ANN-based solar power prediction.

## Dataset

The research used measurements collected at Olabisi Onabanjo University, Ogun State, Nigeria, using solar panels and measurement instruments.

The dataset contains 189 measurements collected over 21 days, with approximately nine observations recorded per day between 8:00 AM and 4:00 PM.

The recorded variables include:

- Time
- Solar irradiance
- Temperature
- Humidity
- Current
- Voltage
- Power

These measurements were used to train and evaluate the original MATLAB model and later supported the Python re-evaluation.

## Methodology

### 1. Data Collection and Preparation

Solar measurements were collected and stored in daily CSV files.

The MATLAB scripts used `readtable()` to load the measurements, combined daily observations into tabular datasets, and prepared input and target variables for neural-network training.

The original implementation included random training, validation, and testing splits, alongside per-day training and evaluation procedures.

### 2. Neural Network Architecture

A feedforward Multilayer Perceptron (MLP) was implemented using MATLAB's Neural Network Toolbox.

The network configuration included:

- MATLAB `fitnet(10)`
- One hidden layer containing 10 neurons
- Hyperbolic tangent sigmoid (`tansig`) hidden-layer activation
- Linear (`purelin`) output activation
- Levenberg–Marquardt backpropagation (`trainlm`)
- Input and target normalisation using `mapminmax()` in the daily training function

The implementation explored the ability of a relatively small neural network to learn relationships between the measured input variables and solar power output.

### 3. Model Training

The network was trained using the Levenberg–Marquardt optimisation algorithm.

Training configurations included maximum epoch settings of 8,000 and 9,000 in different scripts.

The MATLAB implementation also used training, validation, and testing procedures to examine prediction errors.

### 4. Model Evaluation

The original code calculated several regression metrics, including:

- Mean Squared Error (MSE)
- Root Mean Squared Error (RMSE)
- Mean Absolute Error (MAE)
- Mean Absolute Percentage Error (MAPE)
- Coefficient of Determination (R²)

## Results and Evaluation Notes

The study initially reported low prediction errors. A subsequent review of the MATLAB scripts identified limitations in the original experimental and evaluation procedures, particularly in the way training data, testing data, and reported predictions were handled.

The principal limitations are described below.

### 1. Reuse of Training Data for Testing

In the daily MATLAB experiments, the same observations were supplied as both training and testing inputs.

This meant that the resulting evaluations did not independently demonstrate how well the model could generalise to previously unseen days.

### 2. Random Splitting of Individual Measurements

The original implementation used random observation-level data splitting.

Because multiple observations were collected during each day, measurements with related environmental conditions could appear across training, validation, and testing subsets.

This limited the extent to which the evaluation measured generalisation across separate measurement days.

### 3. Additional Internal MATLAB Data Division

The original scripts created external training, testing, and validation sets. However, MATLAB's `fitnet()` also performs internal data division unless configured otherwise.

Consequently, the effective training and validation procedure was more complicated than the external split alone suggested.

### 4. Limited Dataset Size

The study used 189 measurements from 21 days.

This provided a practical dataset for an undergraduate experiment but limited the ability to establish reliable generalisation across different seasons, weather conditions, and operating environments.

The small dataset also increased the importance of controlling model complexity and evaluating sensitivity to different training configurations.

### 5. Limited Evidence of Future Forecasting Capability

The original model used measurements observed at the same time as the target power output.

Consequently, the experiments were more appropriately interpreted as power estimation from available measurements than as a demonstration of future solar-generation forecasting.

A future-forecasting system would require an explicitly defined prediction horizon and appropriate historical or forecasted input variables.

### 6. Limited Baseline Comparisons

The original work did not provide a sufficiently structured comparison between the ANN and simpler predictive models under the same independent validation protocol.

Without these comparisons, it was difficult to determine whether the neural network's additional complexity provided a meaningful advantage.

## Subsequent Python Re-evaluation (2026)

To investigate these limitations, I independently reimplemented and extended the research using Python.

**Repository:** [Solar Power Prediction — Python Reimplementation](https://github.com/OluwafisayoIbrahim/solar-power-prediction-python)

The updated study introduced two experimental settings:

- **Electrical-input replication:** Retained the original measurement variables to investigate the behaviour of the original prediction setup.
- **Weather-based prediction:** Used solar irradiance, temperature, humidity, and hour of day without contemporaneous electrical measurements.

The Python study also introduced:

- Day-grouped cross-validation using seven outer folds
- Nested grouped cross-validation for model selection
- Repeated experiments across three random seeds
- Linear-regression and physics-based baseline comparisons
- Feedforward neural networks implemented in scikit-learn, TensorFlow/Keras, and PyTorch
- Pooled out-of-fold evaluation using MAE, RMSE, MAPE, and R²
- Reproducible experiment configurations, automated testing, and GitHub Actions CI
- An interactive Streamlit application for model inference

### Findings from the Re-evaluation

The revised experiments provided a more reliable comparison of neural-network methods and simpler predictive approaches.

The weather-based experiments showed that tuned neural networks could model the relationship between environmental measurements and solar power output, but their performance was broadly comparable to linear regression on the available dataset.

The matched TensorFlow/Keras and PyTorch experiments also produced similar predictive performance, without establishing a consistent advantage for either framework.

The results highlighted the importance of baseline comparisons, independent evaluation, careful feature selection, and understanding the limitations of small experimental datasets.

The weather-based models still used contemporaneous measurements and therefore did not establish future-time forecasting capability.

## Technologies Used

**Programming and Modelling**
- MATLAB
- MATLAB Neural Network Toolbox
- Feedforward Artificial Neural Networks
- Levenberg–Marquardt Optimisation

**Data Processing and Evaluation**
- CSV-based data processing
- `readtable()`
- `mapminmax()`
- MSE, MAE, RMSE, MAPE, and R²

**Experimental Equipment**
- Solar panels
- Pyranometer
- Digital thermometer
- Digital multimeter
- Supporting electrical measurement equipment

## Repository Scope

This repository preserves the original MATLAB-based undergraduate research implementation.

The historical MATLAB scripts are retained for documentation and reproducibility rather than presented as a corrected research implementation.

For the revised methodology, updated experiments, full comparisons, and Python implementations, refer to the [Python research repository](https://github.com/OluwafisayoIbrahim/solar-power-prediction-python).

## Research Output

**Forecasting Solar Power Generation using Artificial Neural Networks**

Ibrahim, O. SSRN preprint, 2024.

DOI: https://doi.org/10.2139/ssrn.4771898

The original research was completed in 2023 and subsequently revisited to address methodological and evaluation limitations.

## Conclusion

This project provided my initial practical experience in applying artificial neural networks to an engineering prediction problem.

The subsequent re-evaluation extended that work beyond model implementation to examine experimental validity, model generalisation, and the interpretation of predictive results.

Together, the original MATLAB study and its Python extension document the development of the research, the limitations identified, and the improvements made to the evaluation methodology.
