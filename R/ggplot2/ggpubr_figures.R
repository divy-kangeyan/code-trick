### Scatter plot

ggscatter(data = data_table,
x = "x_vector", y = "y_vector", color = "color_vector",
geom_smooth(method = "lm") + xlab('') +
stat_cor(method = "pearson", label.x.npc = "center",
label.y.npc = "top") +
ylab('')

### Box plot


color_table <- data.frame('Group' = group_vec,
                          'Color' = color_vec)
                          
                          
lab1 <- c(expression(),
		  expression(),
		  expression())

ggboxplot(data, x= "x_vector", y= "y_vector", color = "color_vec",
yalb = "") +
theme(axis.title.x = element_blank(),
axis.text.x = element_blank()) + scale_y_log10() +
stat_summary(fun.data = function(x), data.frame(y=7,
                                                label = paste(" n =", length(x))),
                                                geom="text") + custom_colors +
                                                scale_colour_manual(name = NULL, labels = lab1,
                                                values = color_table$Color)
                                                
                                                
### Bar Plot

ggbarplot(data_table, x = "x_vec", y = "y_vec",
        fill="color_vec",
        ylab = "") +
        theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        legend.position = "right") + custom_colors + scale_fill_manual(name = NULL, labels = lab1, 
                                                                       values = color_table$Color) + 
                                                                       stat_pvalue_manual(stat.test, label = "p.adj.signif", 
                                                                       tip.length = 0.01,
                                                                       y.position = c(max_vale + 5000, max_val + 10000,
                                                                       max_val + 15000))
                                                
                                                