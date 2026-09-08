# MATLAB Curve Fitting for Copper Thermal Conductivity

This engineering project uses MATLAB to model the thermal conductivity of copper as a function of temperature using experimental data.

Two candidate equations were evaluated using two numerical fitting methods:

- General Linear Least Squares (GLLS)
- MATLAB `fminsearch` nonlinear optimization

This produced four total curve fits, which were compared using standard error and R².

## Best Result

The best-performing model was **Equation 2 using `fminsearch`**:

- Standard Error: **79.04 W/m·K**
- R²: **0.98925**

This result provided the closest agreement with the experimental copper thermal-conductivity data.

## Model Equations

### Equation 1

`k = 1 / (c1/T + c2*T^2)`

### Equation 2

`k = 1 / (c1/T + c2*T + c3*T^2)`

where:

- `T` = temperature in Kelvin
- `k` = thermal conductivity in W/m·K
- `c1`, `c2`, `c3` = fitted model coefficients

## Numerical Methods

### General Linear Least Squares

The equations were transformed into reciprocal linear forms so the unknown coefficients could be solved using a least-squares matrix system in MATLAB.

### `fminsearch` Optimization

The GLLS coefficients were used as initial guesses for MATLAB's `fminsearch` function. The optimizer adjusted the coefficients to minimize the sum of squared residuals between measured and predicted thermal conductivity values.

## Model Evaluation

Each curve fit was evaluated using standard error, R², residual error, and visual comparison with the experimental data.

| Model | Method | Standard Error (W/m·K) | R² |
|---|---|---:|---:|
| Equation 1 | GLLS | 213.13 | 0.91532 |
| Equation 1 | fminsearch | 153.71 | 0.95596 |
| Equation 2 | GLLS | 82.42 | 0.98831 |
| **Equation 2** | **fminsearch** | **79.04** | **0.98925** |

## MATLAB Workflow

1. Import experimental temperature and conductivity data.
2. Linearize the candidate equations for GLLS.
3. Solve for model coefficients using MATLAB left division.
4. Use the GLLS solutions as starting points for `fminsearch`.
5. Calculate predicted thermal conductivity values.
6. Compute residual error, standard error, and R².
7. Plot all four fitted curves against the experimental data.
8. Export numerical results to CSV files.

## Repository Contents

- `project2.m` — MATLAB implementation of both equations and fitting methods
- `therm_con.dat` — experimental copper thermal-conductivity data
- `CurveFitResults.csv` — standard error and R² results for all four fits
- `CurveFitCoefficients.csv` — fitted model coefficients

## Skills Demonstrated

- MATLAB programming
- Numerical methods
- Least-squares curve fitting
- Nonlinear optimization
- Engineering data analysis
- Model validation
- Error analysis
- Data visualization

## Course

**ENGR 240 — Applied Numerical Methods**

Project completed by **James Lewis**.
