# zeroInflatedPoisson.R 

library(pscl)
library(ggplot2)
library(boot)


zinb <- read.csv("https://stats.idre.ucla.edu/stat/data/fish.csv")

zinb <- within(zinb, {
  nofish <- factor(nofish)
  livebait <- factor(livebait)
  camper <- factor(camper)
})


# covariate description
# camper : How long the fisherman stayed
# persons : How many people were in the group
# child : Were there children in the group
# count : How many fish were caught


summary(zinb)


ggplot(zinb, aes(count)) + geom_histogram(bins = 149) #+ scale_x_log10()


# ZIP regression model

zip_model1 <- zeroinfl(count ~ child + camper | persons, data = zinb)

summary(zip_model1)


nullModel <- update(zip_model1, . ~ 1)
pchisq(2 * (logLik(zip_model1) - logLik(nullModel)), df = 3, lower.tail = FALSE)


# poisson glm model
poisson_glm <- glm(count ~ child + camper, family = poisson, data = zinb)


# Vuong test for poisson glm vs ZIP model
# Vuong test for comparing non-nested models
vuong(zip_model1, poisson_glm)


# Vuong test indicates that the ZIP model is significantly better than Poisson glm model


# Confidence interval for the covariates
dput(coef(zip_model1, "count"))

dput(coef(zip_model1, "zero"))



f <- function(data, i) {
  require(pscl)
  m <- zeroinfl(count ~ child + camper | persons, data = data[i, ],
                start = list(count = c(1.598, -1.0428, 0.834), zero = c(1.297, -0.564)))
  as.vector(t(do.call(rbind, coef(summary(m)))[, 1:2]))
}

set.seed(10)
res <- boot(zinb, f, R = 1200, parallel = "snow", ncpus = 4)



# Confidence interval for all the parameters

parms <- t(sapply(c(1, 3, 5, 7, 9), function(i) {
  out <- boot.ci(res, index = c(i, i + 1), type = c("perc", "bca"))
  with(out, c(Est = t0, pLL = percent[4], pUL = percent[5],
              bcaLL = bca[4], bcaLL = bca[5]))
}))

## add row names
row.names(parms) <- names(coef(m1))
## print results
parms

confint(zip_model1)

# IRR (Incident Risk Ratio) for Poisson model
# OR (Odds Ratio) for the ZIP model

expparms <- t(sapply(c(1, 3, 5, 7, 9), function(i) {
  out <- boot.ci(res, index = c(i, i + 1), type = c("perc", "bca"), h = exp)
  with(out, c(Est = t0, pLL = percent[4], pUL = percent[5],
              bcaLL = bca[4], bcaLL = bca[5]))
}))

## add row names
row.names(expparms) <- names(coef(zip_model1))
## print results
expparms



newdata1 <- expand.grid(0:3, factor(0:1), 1:4)
colnames(newdata1) <- c("child", "camper", "persons")
newdata1 <- subset(newdata1, subset=(child<=persons))
newdata1$phat <- predict(zip_model1, newdata1)

ggplot(newdata1, aes(x = child, y = phat, colour = factor(persons))) +
  geom_point() +
  geom_line() +
  facet_wrap(~camper) +
  labs(x = "Number of Children", y = "Predicted Fish Caught")