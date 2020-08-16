library(ggplot2)
library(ggpubr)
library(grid)
library(gridExtra)

# Export with legends, pdf width = 15 inch, height = 7 inch.
# By using LibreOffice Draw, overlay the plots to-be-drawn with the extracted legends.



sp1 <- ggplot(DSX_ONLINE_Ki_dataframe,aes(x=nM, y=DSXcsd.ScoreWithoutSAS,
                                          color=delta_resistance, shape=structure)) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.5) +
  theme_set(theme_bw()) +
  theme(axis.title.x = element_text(size=24, color = "gray35"),
        axis.title.y = element_text(size=24, color = "gray35"),
        title = element_text(size = 24, color = "gray35"),
        plot.title = element_text(face="bold", hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        aspect.ratio=1) +
  labs(x = NULL, y = NULL) +
  coord_cartesian(xlim = c(-1250, 750), ylim = c(17, -20))



sp2 <- ggplot(DSX_ONLINE_Ki_dataframe,aes(x=nM, y=DSXcsd.ScoreWithoutSAS,
                                          color=delta_polarity, shape=structure)) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.5) +
  theme_set(theme_bw()) +
  theme(axis.title.x = element_text(size=24, color = "gray35"),
        axis.title.y = element_text(size=24, color = "gray35"),
        title = element_text(size = 24, color = "gray35"),
        plot.title = element_text(face="bold", hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        aspect.ratio=1) +
  labs(x = NULL, y = NULL) +
  coord_cartesian(xlim = c(-1250, 750), ylim = c(17, -20)) +
  scale_color_gradient(name ="Hydropathy index change", low="#F8766D", high="#00BFC4",
                       guide = guide_colourbar(title.position = "right"))



sp3 <- ggplot(DSX_ONLINE_Ki_dataframe,aes(x=nM, y=DSXcsd.ScoreWithoutSAS,
                                          color=delta_volume, shape=structure)) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.5) +
  theme_set(theme_bw()) +
  theme(axis.title.x = element_text(size=24, color = "gray35"),
        axis.title.y = element_text(size=24, color = "gray35"),
        title = element_text(size = 24, color = "gray35"),
        plot.title = element_text(face="bold", hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        aspect.ratio=1) +
  labs(x = NULL, y = NULL) +
  coord_cartesian(xlim = c(-1250, 750), ylim = c(17, -20)) +
  scale_color_gradient(name ="Volume change", low="#F8766D", high="#00BFC4",
                       guide = guide_colourbar(title.position = "right"))



# Export as pdf with width = 16 inch, height = 6 inch:

grid.arrange(sp1, sp2, sp3, ncol=3, nrow=1,
             top=textGrob("DSX-ONLINE",gp=gpar(fontsize=34,col="gray30")),
             bottom=textGrob(bquote(Delta*'(Experimental affinity)'),gp=gpar(fontsize=40,col="gray30")),
             left=textGrob(bquote(Delta*'(Experimental affinity)'),gp=gpar(fontsize=40,col="gray30"), rot = 90))



