#!/bin/csh

foreach i (*.txt)
head -33 $i | tail -1 >> DSXscores.txt
end
