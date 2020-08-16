library(ggplot2)



# Export as pdf with width = 7.5 inch, height = 6.5 inch:

ggplot(boxplot_experimental_data_dataframe, aes(x= kinetics, y=log.nM)) +
  scale_x_discrete(limits=c("IC50","Kd","Ki")) +
  geom_boxplot(outlier.shape = NA, varwidth = TRUE, lwd=1.4, aes(col=genotype)) +
  stat_boxplot(geom = "errorbar", width = 0.3, size=1.5, color="gray40") +
  geom_jitter(size=5, aes(col=genotype)) +
  theme_set(theme_classic())+
  theme(axis.title.x = element_text(size=30, color = "gray35"),
        axis.title.y = element_text(size=30, color = "gray35"),
        axis.line = element_blank(),
        title = element_text(size = 30, color = "gray35"),
        plot.title = element_text(face="bold", hjust = 0.5),
        axis.text = element_text(size=30, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        element_line(size=1.2),
        legend.position = "top",
        legend.direction = "horizontal",
        legend.key.width=unit(0.6,"cm"),
        legend.key.height=unit(2,"cm"),
        legend.title = element_text(size = 30, color = "gray30"),
        legend.text = element_text(size = 30, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1,
        panel.border = element_rect(size = 2.5, color = "gray40", fill = NA)) +
  labs(x = "Experimental binding affinity",  y = bquote(log[10](nM))) +
  coord_cartesian(ylim = c(-1.3, 3.2))



