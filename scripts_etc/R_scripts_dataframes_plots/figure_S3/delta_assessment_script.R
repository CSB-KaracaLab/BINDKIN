library(ggplot2)
library(ggpubr)
library(grid)
library(gridExtra)



sp1 <- ggplot(delta_assessment_dataframe,aes(x=nM, y=DSXcsd.ScoreWithoutSAS, color=kinetics)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "bottom",
           size = 7) +
  theme(axis.title.x = element_text(size=24, color = "gray35"),
        axis.title.y = element_text(size=24, color = "gray35"),
        title = element_text(size = 24, color = "gray35"),
        plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "vertical",
        legend.key.width=unit(0.6,"cm"),
        legend.key.height=unit(2,"cm"),
        legend.title = element_text(size = 24, color = "gray35"),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1) +
  labs(x = NULL, y = "Score", title = "DSX-ONLINE") +
  coord_cartesian(xlim = c(-1250, 750), ylim = c(-37, 26))



sp2 <- ggplot(delta_assessment_dataframe,aes(x=nM, y=HADDOCKweb.TotalScoreElec02, color=kinetics)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "bottom",
           size = 7) +
  theme(axis.title.x = element_text(size=24, color = "gray35"),
        axis.title.y = element_text(size=24, color = "gray35"),
        title = element_text(size = 24, color = "gray35"),
        plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "vertical",
        legend.key.width=unit(0.6,"cm"),
        legend.key.height=unit(2,"cm"),
        legend.title = element_text(size = 24, color = "gray35"),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1) +
  labs(x = NULL, y = "Total score", title = "HADDOCK2.2") +
  coord_cartesian(xlim = c(-1250, 750), ylim = c(-28, 23))



sp3 <- ggplot(delta_assessment_dataframe,aes(x=nM, y=KDEEP.protonated.pKd, color=kinetics)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "bottom",
           size = 7) +
  theme(axis.title.x = element_text(size=24, color = "gray35"),
        axis.title.y = element_text(size=24, color = "gray35"),
        title = element_text(size = 24, color = "gray35"),
        plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "vertical",
        legend.key.width=unit(0.6,"cm"),
        legend.key.height=unit(2,"cm"),
        legend.title = element_text(size = 24, color = "gray35"),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1) +
  ylab(bquote(pK[d])) +
  labs(x = NULL, title = "KDEEP") +
  coord_cartesian(xlim = c(-1250, 750), ylim = c(-0.65, 0.65))



sp4 <- ggplot(delta_assessment_dataframe,aes(x=nM, y=KDEEP.protonated.DeltaG, color=kinetics)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "bottom",
           size = 7) +
  theme(axis.title.x = element_text(size=24, color = "gray35"),
        axis.title.y = element_text(size=24, color = "gray35"),
        title = element_text(size = 24, color = "gray35"),
        plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "vertical",
        legend.key.width=unit(0.6,"cm"),
        legend.key.height=unit(2,"cm"),
        legend.title = element_text(size = 24, color = "gray35"),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1) +
  ylab(bquote(Delta*G)) +
  labs(x = NULL, title = "KDEEP") +
  coord_cartesian(xlim = c(-1250, 750), ylim = c(-0.9, 0.85))



sp5 <- ggplot(delta_assessment_dataframe,aes(x=nM, y=PDBePISA.DeltaG, color=kinetics)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "bottom",
           size = 7) +
  theme(axis.title.x = element_text(size=24, color = "gray35"),
        axis.title.y = element_text(size=24, color = "gray35"),
        title = element_text(size = 24, color = "gray35"),
        plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "vertical",
        legend.key.width=unit(0.6,"cm"),
        legend.key.height=unit(2,"cm"),
        legend.title = element_text(size = 24, color = "gray35"),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1) +
  ylab(bquote(Delta*G)) +
  labs(x = NULL, title = "PDBePISA") +
  coord_cartesian(xlim = c(-1250, 750), ylim = c(-1.2, 2.25))



sp6 <- ggplot(delta_assessment_dataframe,aes(x=nM, y=Pose, color=kinetics)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "bottom",
           size = 7) +
  theme(axis.title.x = element_text(size=24, color = "gray35"),
        axis.title.y = element_text(size=24, color = "gray35"),
        title = element_text(size = 24, color = "gray35"),
        plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "vertical",
        legend.key.width=unit(0.6,"cm"),
        legend.key.height=unit(2,"cm"),
        legend.title = element_text(size = 24, color = "gray35"),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1) +
  labs(x = NULL, y = "Pose score", title = "Pose&Rank") +
  coord_cartesian(xlim = c(-1250, 750), ylim = c(-17.5, 24))



sp7 <- ggplot(delta_assessment_dataframe,aes(x=nM, y=Rank, color=kinetics)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "bottom",
           size = 7) +
  theme(axis.title.x = element_text(size=24, color = "gray35"),
        axis.title.y = element_text(size=24, color = "gray35"),
        title = element_text(size = 24, color = "gray35"),
        plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "vertical",
        legend.key.width=unit(0.6,"cm"),
        legend.key.height=unit(2,"cm"),
        legend.title = element_text(size = 24, color = "gray35"),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1) +
  labs(x = NULL, y = "Rank score", title = "Pose&Rank") +
  coord_cartesian(xlim = c(-1250, 750), ylim = c(-12.5, 16))



sp8 <- ggplot(delta_assessment_dataframe,aes(x=nM, y=PRODIGY.DeltaG, color=kinetics)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "bottom",
           size = 7) +
  theme(axis.title.x = element_text(size=24, color = "gray35"),
        axis.title.y = element_text(size=24, color = "gray35"),
        title = element_text(size = 24, color = "gray35"),
        plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "vertical",
        legend.key.width=unit(0.6,"cm"),
        legend.key.height=unit(2,"cm"),
        legend.title = element_text(size = 24, color = "gray35"),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1) +
  ylab(bquote(Delta*G)) +
  labs(x = NULL, title = "PRODIGY-LIG") +
  coord_cartesian(xlim = c(-1250, 750), ylim = c(-0.75, 0.68))



# Export as pdf with width = 20 inch, height = 15 inch:

grid.arrange(sp1, sp2, sp3, sp4, sp5, sp6, sp7, sp8, ncol=3, nrow=3,
             bottom=textGrob(bquote(Delta*'(Experimental affinity) (nM)'),gp=gpar(fontsize=40,col="gray30")),
             left=textGrob(bquote(Delta*'(Predicted affinity)'),gp=gpar(fontsize=40,col="gray30"), rot = 90))



