# BINDKIN
A structural benchmark to measure point mutations’ impact on kinase-ligand  interactions.

To construct the BINDKIN (effect of point mutations on the BINDing affinity of protein KINase:ligand complexes) benchmark, 
we performed a thorough search in the Protein Data Bank (PDB) (Berman et al., 2000) (rcsb.org) and obtained the list of 
available wild type and mutant kinase:ligand complexes. The resulting list was curated by the following criteria:
- For each mutant complex, there has to be a wild type complex, containing the same protein and the ligand.
- The wild type and mutant complexes should be determined in the same study (i.e. they should come from the same paper).
- For each complex, there has to be experimentally determined binding affinity available in the form of IC50, Kd, or Ki together with a related research paper.
- The ligand has to be a reversible (non-covalent) ligand.

The experimental binding kinetics data were acquired from PDBbind (Cheng et al., 2009; Wang et al., 2004, 2005) (pdbbind-cn.org/index.asp), Binding DB (Gilson et al., 2016) (bindingdb.org/bind/index.jsp), and Binding MOAD (Ahmed et al., 2015; Smith et al., 2019) (bindingmoad.org/Search/advancesearch) databases.
	
These criteria have left us with 23 wild type-mutant complex pairs, making up the BINDKIN benchmark. BINDKIN is constituted of eight EGFR, three Abl, three Mps1, three Src, two Cdk2, one ALK, one FGFR, one Kit, and one PKA kinase cases. The 23 mutant cases in the BINDKIN benchmark include 17 single, three double, two triple, and one quintuple point mutants. These complexes present a total of 34 point mutations, distributed across 15 unique positions within or in the vicinity of the ATP binding pocket.

## The directory organization of the repository:

### Organization of the input coordinate files:
Each folder that ends with the string "structures" contains the subdirectories in which the input coordinate files are present.
- ***"input_crystal_structures"*:** The coordinates files obtained from the PDB are located in here.
  - *"complexes_cleaned_pdb_format"***:** Contains the preprocessed complex coordinate files (e.g.: the buffer aditives, ions, solvent etc. were removed).
  - *"complexes_raw_pdb_format"***:** Contains the unedited complex coordinate files that are obtained from the PDB (e.g.: the buffer aditives, ions, solvent etc. were not removed).
  - *"ligands_mol2_format"***:** Contains the ligand coordinate files in ".mol2" format.
  - *"ligands_pdb_format"***:** Contains the ligand coordinate files in ".pdb" format.
  - *"ligands_sdf_format"***:** Contains the ligand coordinate files in ".sdf" fomrat.
  - *"proteins_pdb_format"***:** Contains the protein coordinate files in ".pdb" format.
- ***"input_model_structures"*:** The coordinate files of the model structures are located in here.
  - *"complexes_raw_pdb_format"***:** Contains the unedited complex coordinate files that are obtained from the PDB (e.g.: the buffer aditives, ions, solvent etc. were not removed).
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

## The the result files and their respective contents are listed below:
- ***"BINDKIN_crystal_structures_direct_assessment.csv":*** The raw records of the experimental and predicted binding affinity data. The data was obtained by submission of the crystal structures to the web servers.
- ***"BINDKIN_crystal_structures_delta_assessment.csv":*** The normalized experimental and predicted binding affinity data for the crystal structures. The data was obtained by subtraction of the experimental and predicted values of the wild-type cases from those of their mutant partners.
- ***"BINDKIN_model_structures_direct_assessment.csv":*** The raw records of the experimental and predicted binding affinity data. The data was obtained by submission of the water-refined homology model structures to the web servers.
- ***"BINDKIN_model_structures_delta_assessment.csv":*** The normalized experimental and predicted binding affinity data for the water-refined homology model structures. The data was obtained by subtraction of the experimental and predicted values of wild-type cases from those of their mutant partners.
- ***"BINDKIN_pharmacophore.csv":*** The record of the pharmacophoric features of the ligands that are present in BINDKIN.

