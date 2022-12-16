anova_fit <- anova(lm(y ~ x1 + x2,
                    data = data_table))
    
# displaying the table                
anova_fit %>%
	kable(escape = F, format.args = list(big.mark = ',')) %>%
	kable_styling()
	
ss_vector <- anova_fit$`Sum Sq`

var_explained <- (ss_vector / sum(ss_vector)) * 100

var_exp_df <- data.frame('covariate' = ,
						 'percent variance explained' = var_explained)
						 
						 
	
	