#!/bin/csh

foreach i (*.list)
head -1 $i | tail -1 >> PoseRank.txt
end
