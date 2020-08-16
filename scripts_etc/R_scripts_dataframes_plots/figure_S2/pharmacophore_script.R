library(ggplot2)
library(ggpubr)
library(grid)
library(gridExtra)



sp1 <- ggplot(pharmacophore_dataframe,aes(x=PDBePISA.InterfaceAreaA2, y=nM,
                             color=kinetics, shape=genotype)) +
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
           label.y = 740,
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
  labs(x = "Interface area", y = NULL, title = NULL) +
  coord_cartesian(xlim = c(305, 630), ylim = c(-100, 1170))
  



sp2 <- ggplot(pharmacophore_dataframe,aes(x=PubChem_MolWeight, y=nM,
                                    color=kinetics, shape=genotype)) +
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
           label.y = 740,
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
  labs(x = "Molecular weight", y = NULL, title = NULL) +
  coord_cartesian(xlim = c(270, 590), ylim = c(-100, 1170))



sp3 <- ggplot(pharmacophore_dataframe,aes(x=PubChem_RotatableBondCount, y=nM,
                                    color=kinetics, shape=genotype)) +
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
           label.y = 740,
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
  labs(x = "Rotatable bonds", y = NULL, title = NULL) +
  coord_cartesian(xlim = c(-1.1, 12), ylim = c(-100, 1170))



sp4 <- ggplot(pharmacophore_dataframe,aes(x=PDBePISA.NHB, y=nM,
                                    color=kinetics, shape=genotype)) +
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
           label.y = 740,
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
  labs(x = "Hydrogen bonds", y = NULL, title = NULL) +
  coord_cartesian(xlim = c(-1, 10.8), ylim = c(-100, 1170))



sp5 <- ggplot(pharmacophore_dataframe,aes(x=PubChem_HbondDonorCount, y=nM,
                                    color=kinetics, shape=genotype)) +
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
           label.y = 740,
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
  labs(x = "Hydrogen bond donors", y = NULL, title = NULL) +
  coord_cartesian(xlim = c(0.65, 4.3), ylim = c(-100, 1170))



sp6 <- ggplot(pharmacophore_dataframe,aes(x=PubChem_HbondAcceptorCount, y=nM,
                                    color=kinetics, shape=genotype)) +
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
           label.y = 740,
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
  labs(x = "Hydrogen bond acceptors", y = NULL, title = NULL) +
  coord_cartesian(xlim = c(2, 13), ylim = c(-100, 1170))



sp7 <- ggplot(pharmacophore_dataframe,aes(x=ALOGPS_logP, y=nM,
                                    color=kinetics, shape=genotype)) +
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
           label.y = 740,
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
  labs(x = "logP", y = NULL, title = NULL) +
  coord_cartesian(xlim = c(1.1, 5.2), ylim = c(-100, 1170))



sp8 <- ggplot(pharmacophore_dataframe,aes(x=ALOGPS_logS, y=nM,
                                    color=kinetics, shape=genotype)) +
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
           label.y = 740,
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
  labs(x = "logS", y = NULL, title = NULL) +
  coord_cartesian(xlim = c(-6.2, -3), ylim = c(-100, 1170))



# Export as pdf with width = 20 inch, height = 15 inch:

grid.arrange(sp1, sp2, sp3, sp4, sp5, sp6, sp7, sp8, ncol=3, nrow=3,
             bottom=textGrob("Physicochemical features",gp=gpar(fontsize=40,col="gray30")),
             left=textGrob(bquote('Experimental affinity'~(log[10](nM))),gp=gpar(fontsize=40,col="gray30"), rot = 90))



