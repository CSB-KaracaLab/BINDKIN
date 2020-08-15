library(ggplot2)
library(ggpubr)
library(grid)
library(gridExtra)



sp1 <- ggplot(IC50,aes(x=nM, y=DSXcsd.ScoreWithoutSAS, color=sensitivity)) +
  scale_color_manual(values=c("#999999", "#CD2E2E")) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=1,label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  theme(axis.title.x = element_text(size=32, color = "gray35"),
        axis.title.y = element_text(size=28, color = "gray35"),
        plot.title = element_text(size = 50, color = "gray35", face="bold", hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "horizontal",
        legend.key.width=unit(1,"cm"),
        legend.title = element_blank(),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1, plot.margin=unit(c(1,1,1,1),"cm")) +
  coord_cartesian(xlim = c(-50, 385), ylim = c(-10, 25)) +
  labs(x = NULL, y = NULL, title = NULL)
  # labs(x = NULL, y = "DSX-ONLINE", title = bquote('IC'[50]))



sp2 <- ggplot(Kd,aes(x=nM, y=DSXcsd.ScoreWithoutSAS, color=sensitivity)) +
  scale_color_manual(values=c("#999999", "#CD2E2E", "#3355FF")) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=1,label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  theme(axis.title.x = element_text(size=32, color = "gray35"),
        axis.title.y = element_text(size=28, color = "gray35"),
        plot.title = element_text(size = 50, color = "gray35", face="bold", hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "horizontal",
        legend.key.width=unit(1,"cm"),
        legend.title = element_blank(),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1, plot.margin=unit(c(1,1,1,1),"cm")) +
  coord_cartesian(xlim = c(-145, 95), ylim = c(15, -38)) +
  labs(x = NULL, y = NULL, title = NULL)
  # labs(x = NULL, y = NULL, title = bquote('K'[d]))



sp3 <- ggplot(Ki,aes(x=nM, y=DSXcsd.ScoreWithoutSAS, color=sensitivity)) +
  scale_color_manual(values=c("#999999", "#3355FF")) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=1,label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  theme(axis.title.x = element_text(size=32, color = "gray35"),
        axis.title.y = element_text(size=28, color = "gray35"),
        plot.title = element_text(size = 50, color = "gray35", face="bold", hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "horizontal",
        legend.key.width=unit(1,"cm"),
        legend.title = element_blank(),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1, plot.margin=unit(c(1,1,1,1),"cm")) +
  coord_cartesian(xlim = c(-1300, 800), ylim = c(-19, 7)) +
  labs(x = NULL, y = NULL, title = NULL)
  # labs(x = NULL, y = NULL, title = bquote('K'[i]))



sp4 <- ggplot(IC50,aes(x=nM, y=KDEEP.protonated.DeltaG, color=sensitivity)) +
  scale_color_manual(values=c("#999999", "#CD2E2E")) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=1,label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  theme(axis.title.x = element_text(size=32, color = "gray35"),
        axis.title.y = element_text(size=28, color = "gray35"),
        plot.title = element_text(size = 50, color = "gray35", face="bold", hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "horizontal",
        legend.key.width=unit(1,"cm"),
        legend.title = element_blank(),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1, plot.margin=unit(c(1,1,1,1),"cm")) +
  coord_cartesian(xlim = c(-50, 385), ylim = c(-0.5, 0.85)) +
  labs(x = NULL, y = NULL, title = NULL)
  # labs(x = NULL, y = bquote('KDEEP'~(Delta*G)), title = NULL)



sp5 <- ggplot(Kd,aes(x=nM, y=KDEEP.protonated.DeltaG, color=sensitivity)) +
  scale_color_manual(values=c("#999999", "#CD2E2E", "#3355FF")) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=1,label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  theme(axis.title.x = element_text(size=32, color = "gray35"),
        axis.title.y = element_text(size=28, color = "gray35"),
        plot.title = element_text(size = 50, color = "gray35", face="bold", hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "horizontal",
        legend.key.width=unit(1,"cm"),
        legend.title = element_blank(),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1, plot.margin=unit(c(1,1,1,1),"cm")) +
  coord_cartesian(xlim = c(-145, 95), ylim = c(-0.9, 0.7)) +
  labs(x = NULL, y = NULL, title = NULL)
  # labs(x = NULL, y = NULL, title = NULL)



sp6 <- ggplot(Ki,aes(x=nM, y=KDEEP.protonated.DeltaG, color=sensitivity)) +
  scale_color_manual(values=c("#999999", "#3355FF")) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=1,label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  theme(axis.title.x = element_text(size=32, color = "gray35"),
        axis.title.y = element_text(size=28, color = "gray35"),
        plot.title = element_text(size = 50, color = "gray35", face="bold", hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "horizontal",
        legend.key.width=unit(1,"cm"),
        legend.title = element_blank(),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1, plot.margin=unit(c(1,1,1,1),"cm")) +
  coord_cartesian(xlim = c(-1300, 800), ylim = c(-0.6, 0.06)) +
  labs(x = NULL, y = NULL, title = NULL)
  # labs(x = NULL, y = NULL, title = NULL)



sp7 <- ggplot(IC50,aes(x=nM, y=Pose, color=sensitivity)) +
  scale_color_manual(values=c("#999999", "#CD2E2E")) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=1,label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  theme(axis.title.x = element_text(size=32, color = "gray35"),
        axis.title.y = element_text(size=28, color = "gray35"),
        plot.title = element_text(size = 50, color = "gray35", face="bold", hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "horizontal",
        legend.key.width=unit(1,"cm"),
        legend.title = element_blank(),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1, plot.margin=unit(c(1,1,1,1),"cm")) +
  coord_cartesian(xlim = c(-50, 385), ylim = c(-14, 25)) +
  labs(x = NULL, y = NULL, title = NULL)
  # labs(x = bquote(Delta*'IC'[50]~(nM)), y = "Pose&Rank (PoseScore)", title = NULL)



sp8 <- ggplot(Kd,aes(x=nM, y=Pose, color=sensitivity)) +
  scale_color_manual(values=c("#999999", "#CD2E2E", "#3355FF")) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=1,label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  theme(axis.title.x = element_text(size=32, color = "gray35"),
        axis.title.y = element_text(size=28, color = "gray35"),
        plot.title = element_text(size = 50, color = "gray35", face="bold", hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "horizontal",
        legend.key.width=unit(1,"cm"),
        legend.title = element_blank(),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1, plot.margin=unit(c(1,1,1,1),"cm")) +
  coord_cartesian(xlim = c(-145, 95), ylim = c(-17, 8)) +
  labs(x = NULL, y = NULL, title = NULL)
  # labs(x = bquote(Delta*'K'[d]~(nM)), y = NULL, title = NULL)



sp9 <- ggplot(Ki,aes(x=nM, y=Pose, color=sensitivity)) +
  scale_color_manual(values=c("#999999", "#3355FF")) +
  geom_point(size=6) +
  geom_smooth(method = "lm", se=FALSE, aes(group=1), color="gray35", size=2) +
  geom_rug(size=1.2) +
  theme_set(theme_bw()) +
  stat_cor(method = "pearson",
           aes(group=1,label = ..r.label..),
           label.x.npc = "left",
           label.y.npc = "top",
           size = 7) +
  theme(axis.title.x = element_text(size=32, color = "gray35"),
        axis.title.y = element_text(size=28, color = "gray35"),
        plot.title = element_text(size = 50, color = "gray35", face="bold", hjust = 0.5),
        axis.text = element_text(size=24, color = "black"),
        axis.ticks = element_line(size = 1.5, colour = "gray40"),
        axis.ticks.length = unit(.25, "cm"),
        axis.line = element_blank(),
        panel.grid.major = element_line(linetype = "dashed", color = "gray85", size = 1), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(size = 2.5, color = "gray40"),
        element_line(size=1.2),
        legend.position = "none",
        legend.direction = "horizontal",
        legend.key.width=unit(1,"cm"),
        legend.title = element_blank(),
        legend.text = element_text(size = 24, colour = "black"),
        legend.title.align = 0.5,
        aspect.ratio=1, plot.margin=unit(c(1,1,1,1),"cm")) +
  coord_cartesian(xlim = c(-1300, 800), ylim = c(-12, 11)) +
  labs(x = NULL, y = NULL, title = NULL)
  # labs(x = bquote(Delta*'K'[i]~(nM)), y = NULL, title = NULL)



# Export as pdf with width = 18 inch, height = 24 inch:

ggarrange(sp1, sp2, sp3, sp4, sp5, sp6, sp7, sp8, sp9, sp10, sp11, sp12,
          nrow = 4, ncol = 3, widths = c(1, 1, 1), heights = c(1, 1, 1))



