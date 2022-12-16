library(CMplot)

# Generating circular and linear Manhattan plot

# Table that is formatted as #sample_name, #chr, #position, #reads or other metric

CMPlot(table, plot.type="m", LOG10=FALSE, threshold=1, threshold.lty=2,
       amplify=FALSE, file="jpg", memo="annotated", dpi=300, file.output=FALSE,
       verbose=TRUE, width=14, height=10,
       ylab = "log10 read count")