#!/bin/csh -f
#
set found=`tail -n 500 $1 | grep "CHAIN LENGHT FOR SYMMETRY RESTRAINTS DO NOT MATCH" | grep -v display | wc -l | awk '{print $1}'`

if ($found > 0) then
  tail -n 500 $1 |grep -A 1 "CHAIN LENGHT FOR SYMMETRY RESTRAINTS DO NOT MATCH" >>FAILED
endif

set found=`tail -n 500 $1 | grep "NCS-restraints error encountered: Improperly defined non-crystallographic symmetry" | wc -l | awk '{print $1}'`

if ($found > 0) then
  tail -n 500 $1 |grep "NCS-restraints error encountered: Improperly defined non-crystallographic symmetry" >>FAILED
endif

set found=`tail -n 500 $1 | grep "exceeded allocation for NOE-restraints" | wc -l | awk '{print $1}'`

if ($found > 0) then
  tail -n 500 $1 |grep "exceeded allocation for NOE-restraints" >>FAILED
  echo "Check your definition of active and passive residues" >>FAILED
  echo "Make sure to filter those for solvent accessibility"  >>FAILED
endif

set found=`tail -n 500 $1 | grep "not enough memory available to the program" | wc -l | awk '{print $1}'`

if ($found > 0) then
  head -n 100 $1 | grep "Running on" >>WARNING
  tail -n 500 $1 | grep "not enough memory available to the program" >>WARNING
  echo "Check your definition of active and passive residues"     >>WARNING
  echo "Make sure to filter those for solvent accessibility"      >>WARNING
  echo "Try to decrease the size of your system where possible"   >>WARNING
endif

if ( -e WARNING ) then
  set warnlength=`wc -l WARNING | awk '{print $1}'`
  # if more than 20 structures fail we will flag the run as failed.
  if ( $warnlength > 100 ) then
    \cat WARNING >FAILED
  endif
endif
