# From a correlation matrix

colnames(correlation_matrix) <- rownames(correlation_matrix) <- covariate_names

melted_cormat <- melt(correlation_matrix)

ggplot(data = melted_cormat, aes(Var2, Var1, fill = value)) +
	geom_tile(color = "white") +
	scale_fill_gradient2(low = "blue", high = "red", mid = "white",
						midpoint = 0, limit = c(-1,1), space = "Lab",
						name = Pearson \n Correlation) +
						theme_minimal() +
						theme(axis,text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1)) +
						coord_fixed() + xlab("") + ylab("")