<img src="logo.png" alt="logo" width="250" />


## Features of the database
A structural benchmark to measure the impact of point mutations on protein kinase-ligand  interactions.

To construct the BINDKIN (effect of point mutations on the BINDing affinity of protein KINase:ligand complexes) benchmark, 
we performed a thorough search in the Protein Data Bank (PDB) (Berman et al., 2000) (rcsb.org) and obtained the list of 
available wild type and mutant kinase:ligand complexes. The resulting list was curated by the following criteria:

- For each mutant complex, there has to be a wild type complex, containing the same protein and the ligand.

- The wild type and mutant complexes should be determined in the same study (i.e. they should come from the same research paper).

- For each complex, there has to be an experimentally determined binding affinity available in the form of IC50, Kd, or Ki.

- The ligand has to be a reversible (non-covalent) ligand.

The experimental binding kinetics data were acquired from PDBbind (Cheng et al., 2009; Wang et al., 2004, 2005) (pdbbind-cn.org/index.asp), Binding DB (Gilson et al., 2016) (bindingdb.org/bind/index.jsp), and Binding MOAD (Ahmed et al., 2015; Smith et al., 2019) (bindingmoad.org/Search/advancesearch) databases.
	
These criteria have left us with 23 wild type-mutant complex pairs, making up the BINDKIN benchmark. BINDKIN is constituted of eight EGFR, three Abl, three Mps1, three Src, two Cdk2, one ALK, one FGFR, one Kit, and one PKA kinase cases. The 23 mutant cases in the BINDKIN benchmark include 17 single, three double, two triple, and one quintuple point mutants. These complexes present a total of 34 point mutations, distributed across 15 unique positions within or in the vicinity of the ATP binding pocket.

If you use (part of) this work, please cite:
```
Mehmet Erguven, Tülay Karakulak, M. Kasim Diril, and Ezgi Karaca (2021) How Far Are We from the Rapid Prediction of Drug Resistance Arising Due to Kinase Mutations? ACS Omega, 6, 2, 1254–1265
https://doi.org/10.1021/acsomega.0c04672
```

## Motivation
Protein kinase point mutations are of great clinical and scientific importance. Mutations occurring within the active site of protein kinases have been subjects of drug discovery and protein engineering studies. Due to technical and economical limitations, rapid experimental exploration of the impact of such mutations remains to be a challenge. This underscores the importance of kinase-ligand binding affinity prediction tools that are poised to measure the efficacy of inhibitors in the presence of kinase mutations.

To this end, here, we compare the performances of six web-based scoring tools (DSX-ONLINE, KDEEP, HADDOCK2.2, PDBePISA, Pose&Rank, and PRODIGY-LIG) in assessing the impact of point mutations on protein kinase-ligand interactions. This assessment is carried out on a new structure-based benchmark we compiled, named BNIDKIN.

We aim to aid experimentalists by highlighting accurate binding affinity prediction options. On the other hand, BINDKIN will serve the community as a means to improve the protein-ligand binding affinity prediction tools.

## Clone the repository
```
git clone https://github.com/CSB-KaracaLab/BINDKIN
```
or, if you do not use git:
```
wget https://github.com/CSB-KaracaLab/BINDKIN/archive/master.zip
```

## The directory structure of the repository
Each folder that ends with the string "`_structures`" contains the subdirectories in which the input coordinate files are located.

- ***"input_crystal_structures"*:** The coordinate files obtained from the PDB are located in here.

  - *"complexes_cleaned_pdb_format"***:** Contains the preprocessed complex coordinate files (e.g.: the buffer aditives, ions, solvent etc. were removed).
  
  - *"complexes_raw_pdb_format"***:** Contains the unedited complex coordinate files that are obtained from the PDB (e.g.: the buffer aditives, ions, solvent etc. were not removed).
  
  - *"ligands_mol2_format"***:** Contains the ligand coordinate files in ".mol2" format.
  
  - *"ligands_pdb_format"***:** Contains the ligand coordinate files in ".pdb" format.
  
  - *"ligands_sdf_format"***:** Contains the ligand coordinate files in ".sdf" fomrat.
  
  - *"proteins_pdb_format"***:** Contains the protein coordinate files in ".pdb" format.

- ***"input_model_structures"*:** The coordinate files of the model structures are located in here.

  - *"complexes_raw_pdb_format"***:** Contains the unedited complex coordinate files that are obtained from HADDOCK2.2 refinement interface.
  
  - *"ligands_mol2_format"***:** Contains the ligand coordinate files in ".mol2" format.
  
  - *"ligands_pdb_format"***:** Contains the ligand coordinate files in ".pdb" format.
  
  - *"ligands_sdf_format"***:** Contains the ligand coordinate files in ".sdf" fomrat.
  
  - *"proteins_pdb_format"***:** Contains the protein coordinate files in ".pdb" format.
  
  - *"zz_homology_modeling"***:** Contains the subdirectories related to homology modeling.
  
    - *"1_FASTA_full_length"***:** Contains the full-length sequences of the Ki-cases.
    
    - *"2_FASTA_kinase_domains_fused"***:** Contains the truncated sequences of the Ki-cases that are constituted of the kinase domains.
    
    - *"3_I_TASSER_outputs"***:** Contains the complete homology modeling result folders that were downloaded from the I-TASSER web server.
    
    - *"4_I_TASSER_selected_models"***:** Contains the model structures with the highest C-scores. For each case, a single structure was selected.
    
    - *"5_HADDOCK_water_refinement"***:** I-TASSER discards small molecules when generating the model structures. Consequently, we initially generated the crude model complexes. First, the model protein moieties were superposed to their respective co-crystal structures. Then, the crystal structure ligand coordinates were isolated together with the model structure protein coordinates. These crude complexes were subjected to water refinement by using the HADDOCK2.2 web server. The complete HADDOCK2.2 run results and the associated files are located in this directory.
    
- ***"scripts_etc"*:** The scripts that are used for result analyses and data visualization are located in the subdirectories under this directory.

  - *"C_shell_scrpits_for_HADDOCK"***:** The C shell scripts used for HADDOCK2.2 result analyses and input structure manipulation are located in here. HADDOCK calculates the intermolecular interaction energy using its scoring function "_total score_", which is composed of van der Waals, electrostatic, and desolvation energy. The buried surface area of the complexes are also calculated. Each coordinate file generated by HADDOCK starts with a header section, in which the above mentioned scores are embedded. The scripts in this directory allows easy extraction of the best scores (highest predicted affinities) from multiple HADDOCK run outputs, by ranking the different types of scores separately.

  - *"R_scripts_dataframes_plots"***:** The R scripts and dataframes used in R and the resultant visual data (plots) used in the BINDKIN paper. The folder names correspond to the figure number in the BINDKIN paper (e.g: the folder named "figure_5" contains the documents associated with the fifth figure in the manuscript). The subdirectories located in here are _figure_3b_, _figure_3c_, _figure_4_, _figure_5_, _figure_6a_, _figure_S2_, _figure_S3_, and _figure_S4a_. The file name of each R script ends with the string "`_script`". The file name of each dataframe ends with the string "`_dataframe`". The file name of each plot ends with the string "`_plot`".

## HADDOCK result analysis

The scripts in the directory `BINDKIN\scripts_etc\C_shell_scripts_for_HADDOCK` and the commands given below works in the Unix environment. For Windows, Unix terminal can be installed via Windows Store application.

The scripts were written in a way that they will accept the directory names that start only with the string "`BINDKIN_`". To edit the names of multiple directories, the command named "_rename_" can be used. Using the command given below, "_rename_" is installed via terminal:
```
sudo apt install rename
```

The scripts were written in C shell language. Consequently, they should be executed using C shell. Using the command given below, C shell is installed in terminal:
```
sudo apt-get install csh
```

The step-by-step guideline for preparation and analysis are explained below:

**1)** Extract the downloaded HADDOCK runs into an empty directory.

**2)** In terminal, go to the main directory in which the extracted HADDOCK run directories are located. In case of Windows, open the directory of interest using File Explorer. Then type `bash` in the directory path title bar in the File Explorer window.

**3)** Use the command given below to insert the string "`BINDKIN_`" at the beginning of the each directory name:
```
rename 's/^/BINDKIN_/' *
```

**4)** Copy all of scripts located in the "_HADDOCK_output_analysis_" directory of the repository, to your local directory where all of the uncompressed and renamed HADDOCK runs are located.

**5)** Use the command given below to make the script files executable:
```
chmod +x script_*
```

**6)** Execute the "`script_get_*`", "`script_sort_*`", and "`script_clean_*`" scripts in the given order. For example:
```
./script_get_BSA
./script_sort_BSA
./script_clean_BSA
```
In this example, you will obtain the list of maximum buried surface area (`_BSA`) scores for each docking run. Execute the complete set of the script trio ("_get_", "_sort_", and "_clean_") for one given score type, and only then proceed with executing another script trio associated with another score type. In the script file names `_vdW` stands for van der Waals, `_elec` stands for electrostatics, `total_01` and `total_02` stand for total score.

## The result files and their respective contents
- ***"BINDKIN_direct_assessment_crystal_structures.csv":*** The raw records of the experimental and predicted binding affinity data. The data was obtained by submission of the crystal structures to the web servers.

- ***"BINDKIN_delta_assessment_crystal_structures.csv":*** The normalized experimental and predicted binding affinity data for the crystal structures. The data was obtained by subtraction of the experimental and predicted values of the wild-type cases from those of their mutant partners.

- ***"BINDKIN_direct_assessment_model_structures.csv":*** The raw records of the experimental and predicted binding affinity data. The data was obtained by submission of the water-refined homology model structures to the web servers.

- ***"BINDKIN_delta_assessment_model_structures.csv":*** The normalized experimental and predicted binding affinity data for the HADDOCK-refined homology model structures. The data was obtained by subtraction of the experimental and predicted values of wild-type cases from the mutant ones.

- ***"BINDKIN_pharmacophore.csv":*** The records of the pharmacophoric features of the ligands in BINDKIN.

- ***"BINDKIN_information.csv":*** The records of other information about the pdb files, such as the mutation positions, multiple conformations, HETATM content etc.

## Acknowledgements
We thank Dr. Gerard Martinez (Acellera Ltd., London, United Kingdom) for his help and guidance during benchmarking of the KDEEP web server. We thank Dr. Daniel Fisher (The Institute of Molecular Genetics of Montpellier (IGMM), Montpellier, France) for helping us clarifying the wrong binding kinetics data records found in the PDBbind database (for the PDB entries 4EOR and 4EOK). We thank Deniz Dogan and Dr. Alexandre M.J.J. Bonvin for their participation in the initial reviewing of the manuscript. We thank Mehdi Kosaca and Eda Samiloglu for their help in searching and annotating the experimental techniques used for determination of the kinetic parameters.

## Contact
ezgi.karaca@ibg.edu.tr

erguven.mehmet.00@gmail.com
