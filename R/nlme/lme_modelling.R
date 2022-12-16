# lme_model.R


# maximum likelihood with compound symmetric correlation structure
lme_model <- lme(fixed = Y ~ X1 + X2, 
				random = reStruct(~1 | Mouse.ID),
				correlation = corCompSymm(fixed = FALSE),
				data = data_table,
				method = "ML",
				na.action = na.omit)