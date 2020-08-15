library(ggplot2)
library(ggpubr)
library(ggrepel)

# plot.margin	is the margin around entire plot (unit with the sizes of the top, right, bottom, and left margins)



cbPalette <- c("#757575", "#E69F00", "#56B4E9", "#009E73", "#CC79A7", "#0072B2", "#D55E00", "#F0E442")



sp1 <- ggplot(DSX_ONLINE_Ki_cases_labeled_direct_assessment_dataframe,aes(x=nM, y=DSXcsd.ScoreWithoutSAS, color = pair_ID)) +
  scale_colour_manual(values=cbPalette) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se = FALSE, color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=1,label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  theme(axis.title.x = element_text(size=25, color = "gray35"),
        axis.title.y = element_text(size=25, color = "gray35"),
        plot.title = element_text(size= 22, hjust = 0.5, color = "gray35"),
        axis.text = element_text(size=22, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "vertical",
        legend.key.width=unit(0.6,"cm"),
        legend.key.height=unit(1.7,"cm"),
        legend.title = element_text(face = "bold", size = 20, color = "gray35"),
        legend.text = element_text(size = 22, colour = "black"),
        aspect.ratio=1, plot.margin = unit(c(0.3,0.1,0.3,0.1),"cm")) +
  labs(x = bquote('K'[i]~'(nM)'), y = "Score", title = "DSX-ONLINE (direct assessment)") +
  coord_cartesian(xlim = c(-150, 1250), ylim = c(-105, -135.5)) +
  geom_label_repel(aes(label = label_ID), size=6,
                   box.padding = 0.4, point.padding = 0.5,
                   segment.color = 'grey50')



sp2 <- ggplot(DSX_ONLINE_Ki_cases_labeled_delta_assessment_dataframe,aes(x=nM, y=DSXcsd.ScoreWithoutSAS, color = pair_ID)) +
  scale_colour_manual(values=cbPalette) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se = FALSE, color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=1,label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  theme(axis.title.x = element_text(size=25, color = "gray35"),
        axis.title.y = element_text(size=25, color = "gray35"),
        plot.title = element_text(size= 22, hjust = 0.5, color = "gray35"),
        axis.text = element_text(size=22, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "vertical",
        legend.key.width=unit(0.6,"cm"),
        legend.key.height=unit(1.7,"cm"),
        legend.title = element_text(face = "bold", size = 20, color = "gray35"),
        legend.text = element_text(size = 22, colour = "black"),
        aspect.ratio=1, plot.margin=unit(c(0.3,0.3,0.3,0.3),"cm")) +
  labs(x = bquote(Delta*'K'[i]~'(nM)'), y = "Score", title = "DSX-ONLINE (delta assessment)") +
  coord_cartesian(xlim = c(-1300, 800), ylim = c(-18.5, 6)) +
  geom_label_repel(aes(label = label_ID), size=6,
                   box.padding = 0.4, point.padding = 0.5,
                   segment.color = 'grey50')



# Export as pdf with width = 12 inch, height = 6 inch:

ggarrange(sp1, sp2, nrow = 1, ncol = 2)



