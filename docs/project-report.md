# Project Report — Application of Curve Fitting Algorithms

**James Lewis**  
**ENGR 240 — Applied Numerical Methods**  
**August 25, 2026**

## Problem Specification

The purpose of this project was to use curve-fitting methods to model the relationship between the thermal conductivity of copper and temperature. Because thermal conductivity changes with temperature, experimental data can be used to develop mathematical models that predict this relationship.

Two model equations were evaluated. Each equation was fitted to the experimental data using General Linear Least Squares (GLLS) and MATLAB's `fminsearch`, producing four total curve fits. Fit quality was evaluated using coefficient of determination (R²) and standard error.

## Mathematical Formulation

### Equation 1

`k = 1 / (c1/T + c2*T^2)`

For GLLS, the equation was linearized by taking the reciprocal:

`1/k = c1/T + c2*T^2`

### Equation 2

`k = 1 / (c1/T + c2*T + c3*T^2)`

The reciprocal form used for GLLS was:

`1/k = c1/T + c2*T + c3*T^2`

where `k` is thermal conductivity, `T` is temperature, and `c1`, `c2`, and `c3` are fitted coefficients.

For `fminsearch`, the coefficients were adjusted to minimize the sum of squared residuals between measured and predicted thermal conductivity values.

Fit quality was evaluated using the sum of squared residuals, standard error, R², and total sum of squares. Lower standard error indicates less prediction error, while an R² value closer to 1 indicates a better fit.

## Curve-Fit Comparison

![Copper Thermal Conductivity Curve Fits](curve_fit_plot.svg)

The Equation 2 curves followed the experimental data more closely than the Equation 1 curves over the measured temperature range. The GLLS and `fminsearch` versions of Equation 2 were also close to one another.

## Results

| Model | Method | Standard Error (W/m·K) | R² |
|---|---|---:|---:|
| Equation 1 | GLLS | 213.13 | 0.91532 |
| Equation 1 | fminsearch | 153.71 | 0.95596 |
| Equation 2 | GLLS | 82.42 | 0.98831 |
| **Equation 2** | **fminsearch** | **79.045** | **0.98925** |

### Curve-Fit Coefficients

| Model | c1 | c2 | c3 |
|---|---:|---:|---:|
| Equation 1 - GLLS | 0.0036168207 | 3.661922e-07 | 0 |
| Equation 1 - fminsearch | 0.0039217646 | 3.163701e-07 | 0 |
| Equation 2 - GLLS | 0.0049413993 | -7.279713e-06 | 5.237999e-07 |
| Equation 2 - fminsearch | 0.0051055717 | -8.187621e-06 | 5.434614e-07 |

## Results and Discussion

Equation 2 provided a substantially better fit than Equation 1. For Equation 1, `fminsearch` reduced the standard error from 213.13 to 153.71 and increased R² from 0.91532 to 0.95596.

Equation 2 performed much better with both methods. GLLS produced a standard error of 82.42 and R² of 0.98831. The best overall result was Equation 2 using `fminsearch`, with a standard error of 79.045 W/m·K and R² of 0.98925.

## Conclusion

`fminsearch` provided a better fit than GLLS for both equations. Equation 2 was the better model overall because it produced substantially lower standard error and R² values closer to 1. The best-performing combination was Equation 2 using `fminsearch`.

This project demonstrated the use of MATLAB programming, least-squares curve fitting, nonlinear optimization, model validation, error analysis, and engineering data visualization.
