#!/bin/bash
for i in *.pdb;
do
	sed -i '/ANISOU/d' ./*.pdb
	sed -i 's/HETATM/ATOM  /g' ./*.pdb
	sed -i 's/TPO/TOP/g' ./*.pdb
done
