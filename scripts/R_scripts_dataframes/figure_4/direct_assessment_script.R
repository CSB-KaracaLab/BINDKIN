library(ggplot2)
library(ggpubr)
library(grid)
library(gridExtra)



sp1 <- ggplot(direct_assessment_dataframe,aes(x=nM, y=DSXcsd.ScoreWithoutSAS,
                             color=kinetics, shape=genotype)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x = 400,
           label.y.npc = "bottom",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x = 400,
           label.y.npc = "top",
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
  coord_cartesian(xlim = c(-125, 1200), ylim = c(-70, -235))
  



sp2 <- ggplot(direct_assessment_dataframe,aes(x=nM, y=HADDOCK.TotalScoreElec02,
                                    color=kinetics, shape=genotype)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x = 400,
           label.y.npc = "bottom",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x = 400,
           label.y.npc = "top",
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
  coord_cartesian(xlim = c(-125, 1200), ylim = c(-32, -135))



sp3 <- ggplot(direct_assessment_dataframe,aes(x=nM, y=KDEEP.protonated.pKd,
                                    color=kinetics, shape=genotype)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x = 400,
           label.y.npc = "bottom",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x = 400,
           label.y.npc = "top",
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
  coord_cartesian(xlim = c(-125, 1200), ylim = c(6.1, 9.1))



sp4 <- ggplot(direct_assessment_dataframe,aes(x=nM, y=KDEEP.protonated.DeltaG,
                                    color=kinetics, shape=genotype)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x = 400,
           label.y.npc = "bottom",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x = 400,
           label.y.npc = "top",
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
  coord_cartesian(xlim = c(-125, 1200), ylim = c(-8.3, -12.3))



sp5 <- ggplot(direct_assessment_dataframe,aes(x=nM, y=PDBePISA.DeltaG,
                                    color=kinetics, shape=genotype)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x = 400,
           label.y.npc = "bottom",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x = 400,
           label.y.npc = "top",
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
  coord_cartesian(xlim = c(-125, 1200), ylim = c(7, -22))



sp6 <- ggplot(direct_assessment_dataframe,aes(x=nM, y=Pose,
                                    color=kinetics, shape=genotype)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x = 400,
           label.y.npc = "bottom",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x = 400,
           label.y.npc = "top",
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
  coord_cartesian(xlim = c(-125, 1200), ylim = c(-27, -112))



sp7 <- ggplot(direct_assessment_dataframe,aes(x=nM, y=Rank,
                                    color=kinetics, shape=genotype)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x = 400,
           label.y.npc = "bottom",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x = 400,
           label.y.npc = "top",
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
  coord_cartesian(xlim = c(-125, 1200), ylim = c(5, -44))



sp8 <- ggplot(direct_assessment_dataframe,aes(x=nM, y=PRODIGY.DeltaG,
                                    color=kinetics, shape=genotype)) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
  geom_point(size=5) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=kinetics, label = ..r.label..),
           label.x = 400,
           label.y.npc = "bottom",
           size = 7) +
  stat_cor(method = "pearson",
           aes(group=1, label = ..r.label..),
           label.x = 400,
           label.y.npc = "top",
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
  coord_cartesian(xlim = c(-125, 1200), ylim = c(-7.1, -11.5))



# Export as pdf with width = 20 inch, height = 15 inch:

grid.arrange(sp1, sp2, sp3, sp4, sp5, sp6, sp7, sp8, ncol=3, nrow=3,
             bottom=textGrob(bquote('Experimental affinity'~(log[10](nM))),gp=gpar(fontsize=40,col="gray30")),
             left=textGrob("Predicted affinity",gp=gpar(fontsize=40,col="gray30"), rot = 90))



