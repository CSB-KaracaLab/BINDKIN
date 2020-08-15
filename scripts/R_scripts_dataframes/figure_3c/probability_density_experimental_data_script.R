library(ggplot2)
library(grid)
library(gridExtra)



sp1 <- ggplot(probability_density_experimental_data_SENSITIVE_dataframe, aes(nM)) +
  geom_density(aes(x=nM), fill = 'burlywood1') +
  geom_histogram(aes(y=..density..), binwidth=0.019,
                 colour="black", fill="aquamarine2") +
  geom_density(alpha=.2, fill="#FF6666") +
  geom_vline(xintercept=0.1, color = "#3355FF", size=2.2) +
  annotate(geom = "rect", xmin = 0, xmax = 0.1, ymin=0, ymax=Inf, fill = "#3355FF", alpha = 0.2) +
  labs(x = NULL, y = NULL, title= "5 sensitive cases") +
  theme_set(theme_bw()) +
  geom_rug(size=1.4) +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(),
        axis.text = element_text(size=26, color = "black"),
        axis.ticks = element_line(size = 1.5, color = "gray40"),
        axis.ticks.length=unit(.4, "cm"),
        plot.title = element_text(size = 26, color = "#3355FF"),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1),
        panel.grid.minor = element_blank(),
        aspect.ratio=1,
        panel.border = element_rect(size = 2.5, color = "gray40"))



sp2 <- ggplot(probability_density_experimental_data_ALL_dataframe, aes(nM)) +
  geom_density(aes(x=nM), fill = 'burlywood1') +
  geom_histogram(aes(y=..density..), binwidth=1.8,
                 colour="black", fill="aquamarine2") +
  geom_density(alpha=.2, fill="#FF6666") +
  geom_vline(xintercept=0.1, color = "#3355FF", size=2.2) +
  geom_vline(xintercept=10, color = "#CD2E2E", size=2.2) +
  annotate(geom = "rect", xmin = 10, xmax = Inf, ymin=0, ymax=Inf, fill = "#CD2E2E", alpha = 0.2) +
  annotate(geom = "rect", xmin = 0, xmax = 0.1, ymin=0, ymax=Inf, fill = "#3355FF", alpha = 0.2) +
  labs(x = NULL, y = NULL, title= "5 resistant cases") +
  theme_set(theme_bw()) +
  geom_rug(size=1.4) +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(),
        axis.text = element_text(size=26, color = "black"),
        axis.ticks = element_line(size = 1.5, color = "gray40"),
        axis.ticks.length=unit(.4, "cm"),
        plot.title = element_text(size = 26, colour = "#CD2E2E", hjust = 1),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1),
        panel.grid.minor = element_blank(),
        aspect.ratio=1,
        panel.border = element_rect(size = 2.5, color = "gray40"))



# Export as pdf with width = 9.5 inch, height = 6.4 inch:

grid.arrange(sp1, sp2, ncol=2, nrow=1,
             top=textGrob("23 total cases",gp=gpar(fontsize=32,col="gray35",fontface="bold")),
             bottom=textGrob("Experimental [MUT(nM)/WT(nM)]",gp=gpar(fontsize=26,col="gray35")),
             left=textGrob("Probability density",gp=gpar(fontsize=26,col="gray35"), rot = 90))



