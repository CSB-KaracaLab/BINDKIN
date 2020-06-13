# BINDKIN
A structural benchmark to measure point mutations’ impact on kinase-ligand  interactions.

To construct the BINDKIN (effect of point mutations on the BINDing affinity of protein KINase:ligand complexes) benchmark, 
we performed a thorough search in the Protein Data Bank (PDB) (Berman et al., 2000) (rcsb.org) and obtained the list of 
available wild type and mutant kinase:ligand complexes. The resulting list was curated by the following criteria:
	> For each mutant complex, there has to be a wild type complex, containing the same protein and the ligand.
	> The wild type and mutant complexes should be determined in the same study (i.e. they should come from the same paper).
	> For each complex, there has to be experimentally determined binding affinity available in the form of IC50, Kd, or Ki together with a related research paper.  The experimental binding kinetics data were acquired from PDBbind (Cheng et al., 2009; Wang et al., 2004, 2005) (pdbbind-cn.org/index.asp), Binding DB (Gilson et al., 2016) (bindingdb.org/bind/index.jsp), and Binding MOAD (Ahmed et al., 2015; Smith et al., 2019) (bindingmoad.org/Search/advancesearch) databases. 
	> The ligand has to be a non-covalent ligand.
	
This limitation left us with 23 wild type-mutant complex pairs, making up the BINDKIN benchmark. BINDKIN is constituted
of seven EGFR, three Abl, three Mps1, three Src, two Cdk2, one ALK, one FGFR, one Kit, and one PKA kinases. 
These complexes present 36 point mutations distributed across 15 positions. 
Most of the mutation positions are within or in the vicinity of the ATP binding pocket.

The directory organization description of the repository:

# Organization of the input coordinate files:
Each folder that ends with the string "_structures" contains the 
subdirectories in which the input coordinate files are present.
	> "crystal_structures":The coordinates files obtained from the PDB are present here.
	> "homology_model_structures":The coordinate files of the model structures are present here.
	
In both of these folders, the default state of the structures, and the 
HADDOCK refined versions of them were given in separate directories as shown below:
	> "crystal_structures":
		> "crystal_structures"
		> "HADDOCK_refined_crystal_structures"
	
	> "homology_model_structures":
		> "model_structures"
		> "HADOCK_refined_model_structures"

In each four of these subdirectories, the structure files were separated 
into different subdirectories based on their file extensions or contents.
The subdirectories that contain the input coordinate files are as listed below:
			> "ligands_mol2":
				Ligand coordinate files in ".mol2" format.
			> "ligands_pdb":
				Ligand coordinate files in ".pdb" format.
			> "ligands_sdf":
				Ligand coordinate files in ".sdf" fomrat.
			> "PDB_files_edited":
				Preprocessed complex coordinate files (e.g.: the buffer aditives, ions, solvent etc. were removed).
			> "PDB_files_raw":
				Unedited complex coordinate files (e.g.: the buffer aditives, ions, solvent etc. were not removed).
			> "proteins_pdb":
				Protein coordinate files in ".pdb" format.

# Organization of the web server outputs:
Each folder that ends with the string "_results" contains the subdirectories in 
which the binding affinity prediction results were given for the web servers.
	> "crystal_structures_results":
		The result files obtained by running the crystal structures and their refined versions.
	> "homology_model_structures_results":
		The result files obtained by running the homology model structures and their refined versions.
	
In both of these folders, results obtained from different web servers were 
separately given in the subdirectories, indicated by the respective folder names.
The subdirectories that contain the web server output files or folders are as listed below:
			> "DSX_ONLINE":
				The results obtained from the "DSX-ONLINE" web server.
			> "HADDOCK_refinement":
				The results obtained from the refinement interface of the "HADDOCK2.2" web server. 
				The complete HADDOCK run results downloaded and stored. For easy extraction of the 
				results, a common string "BINDKIN_" was inserted at the beginning of each folder name.
			> "KDEEP":
				The results obtained from the "KDEEP" web server of the "PlayMolecule" platform.
			> "PDBePISA":
				The results obtained from the "PDBePISA" web server.
			> "Pose_and_Rank":
				The results obtained from the "Pose&Rank" web server.
			> "PRODIGY_LIG":
				The results obtained from the "PRODIGY-LIG" web server.

The directory "homology_modeling" contains the input and output files or folders that are related to homology modeling.

# The the summraized result files and their respective contents are listed below:
The recorded and analyzed results are given in the "BINDKIN_results" folder.
	> "BINDKIN_crystal_structure_direct_results.csv":
		The raw records of the web server score outputs, obtained by the 
		submission of the crystal structures or their refined versions.
	> "BINDKIN_crystal_structure_ratio_results.csv":
		The normalized scores of the crystal structures or their refined versions, obtained by 
		divison of the experimental and predicted values of MUT cases to that of their WT partners.
	> "BINDKIN_model_structure_direct_results.csv":
		The raw records of the web server score outputs, obtained by the 
		submission of the homology model structures or their refined versions.
	> "BINDKIN_model_structure_ratio_results.csv":
		The normalized scores of the homology model structures or their refined versions, obtained by 
		divison of the experimental and predicted values of MUT cases to that of their WT partners.
	> "BINDKIN_direct_assessment.csv":
		The records of the Pearson's R correlation coefficients obtained by linear 
		regression analysis of the "BINDKIN_crystal_structure_direct_results.csv" results.
	> "BINDKIN_ratio_assessment.csv":
		The records of the Pearson's R correlation coefficients obtained by linear 
		regression analysis of the "BINDKIN_crystal_structure_ratio_results.csv" results.
	> "BINDKIN_binary_assessment.csv":
		The records of the accuracy percentages obtained by quantitative
		analysis of the "BINDKIN_crystal_structure_ratio_results.csv" results.
	> "BINDKIN_pharmacophore.csv":
		The record of the pharmacophoric features of the ligands that are present in the BINDKIN benchmark set.

