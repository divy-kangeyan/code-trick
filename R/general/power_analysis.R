# power_analysis.R

library(sfmisc)
library(MKmisc)

# Power analysis based on t-test assuming same standard deviaitons between two groups

samples_size <- n
effect_size_vec <- es

power_table <- marix(nrow = sample_size, nrow = length(es))

for (j in seq_len(effect_size_vec)){
	effect_size <- effect_size_vec[j]
	for (i in 1:sample_size){
		power_output <- power.t.test(n = i, delta = effect_size,
		sd = standard_deviation,
		sig.level = 0.05,
		type = c("two.sample"))
		
		power_table[i,j] <- power_output$power	
	
	}
}

# Considering 80% power

sample_size_needed <- rep(NA, ncol(power_table))

for (i in 1:ncol(power_table)){
	time_specific_ss <- min(which(power_table[,i] > 0.8))
	sample_size_needed[i] <- time_specific_ss
}

# Power analyziz based on Welch t-test assuming standard deviations differe between two groups

samples_size <- n
effect_size_vec <- es

power_table <- marix(nrow = sample_size, nrow = length(es))

for (j in seq_len(effect_size_vec)){
	effect_size <- effect_size_vec[j]
	for (i in 1:sample_size){
		power_output <- power.t.test(n = i, delta = effect_size,
		sd1 = standard_deviation_1,
		sd2 = standard_deviation_2,
		sig.level = 0.05,
		power = NULL,
		alternative = c("two.sided", "one.sided"),
		strict = FALSE, tol = .Machine$double.eps^0.25)
		
		power_table[i,j] <- power_output$power	
	
	}
}



sample_size_needed <- rep(NA, ncol(power_table))

for (i in 1:ncol(power_table)){
	time_specific_ss <- min(which(power_table[,i] > 0.8))
	sample_size_needed[i] <- time_specific_ss
}

