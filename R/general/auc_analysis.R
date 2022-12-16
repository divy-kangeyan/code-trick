# auc_analysis.R

library(sfmisc)

# numerical integtartion

integrate.xy(x_vec, y_vec, start, end, 
             use.spline=TRUE, xtol=2e-08)
             
             