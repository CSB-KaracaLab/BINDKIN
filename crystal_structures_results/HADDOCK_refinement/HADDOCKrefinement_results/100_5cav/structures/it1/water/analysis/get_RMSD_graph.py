#### Author: Mikael Trellet (February 2011)

#### Get HADDOCK score graph in function of i-RMSD ####

from os       import popen, _exit, environ, pathsep
from sys      import argv, stderr, stdout
from math     import sqrt
import re

def getGraph(nb_clust): # Generate graphics for iRMSD analysis
#   popen('mv -f new_list.list complex_HS_irmsd_lrmsd_fnat.list')
    popen('/home/software/software/R_2.12.0/bin/R irmsd complex_HS_irmsd_lrmsd_fnat.list irmsd_graph.eps '+nb_clust+' < Graph_rmsd.R --slave >> R_log.out')
    popen('/home/software/software/R_2.12.0/bin/R lrmsd complex_HS_irmsd_lrmsd_fnat.list lrmsd_graph.eps '+nb_clust+' < Graph_rmsd.R --slave >> R_log.out')
    popen('/home/software/software/R_2.12.0/bin/R fnat complex_HS_irmsd_lrmsd_fnat.list fnat_graph.eps '+nb_clust+' < Graph_rmsd.R --slave >> R_log.out')
    popen('/home/software/software/R_2.12.0/bin/R vdw complex_HS_irmsd_lrmsd_fnat.list vdw_graph.eps '+nb_clust+' < Graph_rmsd.R --slave >> R_log.out')
    popen('/home/software/software/R_2.12.0/bin/R elec complex_HS_irmsd_lrmsd_fnat.list elec_graph.eps '+nb_clust+' < Graph_rmsd.R --slave >> R_log.out')
    popen('/home/software/software/R_2.12.0/bin/R air complex_HS_irmsd_lrmsd_fnat.list air_graph.eps '+nb_clust+' < Graph_rmsd.R --slave >> R_log.out')
    popen('/home/software/software/R_2.12.0/bin/R ilrmsd complex_clustered.list ilrmsd_graph.eps '+nb_clust+' < Graph_rmsd.R --slave >> R_log.out')

def main(argv):
    nb_clust=argv[1]
    getGraph(nb_clust)

    return 0

end = main(argv)
_exit(end)
