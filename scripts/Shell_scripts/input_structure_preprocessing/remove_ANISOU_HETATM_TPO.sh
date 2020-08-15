#!/bin/bash
#For each pdb file in a given directory, this script
	#removes the containing the term "ANISOU",
	#changes the term "HETATM" to "ATOM", and
	#changes the term "TPO" to "TOP".

for i in *.pdb;
do
	sed -i '/ANISOU/d' ./*.pdb
	sed -i 's/HETATM/ATOM  /g' ./*.pdb
	sed -i 's/TPO/TOP/g' ./*.pdb
done
