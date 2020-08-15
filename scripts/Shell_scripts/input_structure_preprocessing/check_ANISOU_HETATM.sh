#!/bin/bash
#For each pdb file in a given directory, this script checks the presence of the terms "ANISOU" and "HETATM".

for i in *.pdb;
do
	grep ANISOU *.pdb
	grep HETATM *.pdb
done
