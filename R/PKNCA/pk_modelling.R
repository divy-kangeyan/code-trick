library(PKNCA)

pk_model_fit <- pk.calc.half.life(concentration, timepoint)


### Output metrics

# $\lambda$z (Elimination Rate Constant): Rate of elimination of the drug - exponential decay rate

# $R^2$: Coefficient of determination

# $Adjusted R^2$: Adjusted Coefficient of determination

# $\lambda$z Time First: First time point used for half-life calculation

# $\lambda$z n points: Number of points used for half-life calculation

$C_{last}$ prediction: Predicted concetration level by the model at the last time point

$T_{1/2$ - half life: TIme span at half the concentration

Span Ratio: Ratio of half-life to time used for half-life calculation

$T_{max}$: Time of maximum observed concentration

$T_{last}$: Time of last observed concentration above the LOQ