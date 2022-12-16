library(survival)
library(survminer)
library(coxphw)
library(kableExtra)
library(powerSurvEpi)

# Kaplan - Meier Curve

sfit <- survfit (Surv(survival.time, survival.status) ~ group,
                  data = data_table)

# Median survival table

median_surv_table <- surv_median(sfit)

median_surv_table %>%
	kable(escape = F, format.args = list(big.mark = ','), digits = 2,
	row.names = FALSE) %>%
	kable_styling()
	
	

# Kaplan - Meier Curve plotting

ggsurvplot(sfit, conf.int = FALSE, surv.median.line = "v",
risk.table = FALSE, legend.labs = lab1, legend.title = "group",
legend = "right", palette=color_table$Color,
title="Kaplan-Meier Curve for Mice Survival",
risk.table.height=0.15, xlab = "Days")


# Average Hazard Ratio (non-proportional Hazard assumption)
coxphw(Surv(survival.time, survival.status) ~ treatement_status + Sex,
data = merged_survival_table, template = "AHR",
iter = 500)


# Log-rank test

test <- survdiff(Surv(survival_time, scores.) ~ treatement_status,
data = study_table)


# Schoenfeld residual test for testing proportional hazard assumption

res.cox <- coxph(Surv(survival_time, scores.) ~ treatment_status,
data = study_table)

test.ph <- cox.zph(res.cox)

ggcoxzph(test.ph)

# Power calculation with Cox proportional Hazard assumption

res <- ssizeCT(formula = Surv(age_at_death, scores.) ~ group,
dat = data_table,
power = power_value,
k = 1,
RR = rr. alpha = 0.05)



Test Reference: Rosner - 2006 Fundamentals of Biostatistics









