

biexp <- function(t, a, b, c, d, f) {a + b * exp(-c*t) + d * exp(-f*t)}

biexp_integral <- function (t, a, b, c, d, f)
	{a*t - (b/c) * exp(-c*t) - (d/f) * exp(-f*t)}
	
# non linear least square fit

nlsFit <- nls(y ~ biexp(t, a, b, c, d, f),
			 data = data_table,
			 start = list(a = , b = , c = , d = , f = ),
			 trace = TRUE)
nlsFitSummary <- summary(nlsFit)



