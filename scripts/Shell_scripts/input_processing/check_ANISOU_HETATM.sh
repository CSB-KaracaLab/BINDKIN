#!/bin/bash
for i in *.pdb;
do
	grep ANISOU *.pdb
	grep HETATM *.pdb
done
