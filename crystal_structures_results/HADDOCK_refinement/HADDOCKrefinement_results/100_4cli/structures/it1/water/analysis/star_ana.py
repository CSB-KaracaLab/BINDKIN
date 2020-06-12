#!/bin/python

import sys

def star_calc(file):
  o=open(file,'r')
  n=open(file+'_stars','w')
  three=0
  two=0
  one=0
  zero=0
  for l in o:
    l = l.strip()
    irmsd=float(l.split()[2])
    lrmsd=float(l.split()[3])
    fnat=float(l.split()[4])
    if (irmsd <= 1.0 or lrmsd <= 1.0) and fnat >= 0.5:
      line = l +' 3S\n'
      three=three+1
    elif ((irmsd <= 2.0 or lrmsd <= 5.0) and fnat >= 0.3) or ((lrmsd < 5.0 or irmsd < 2.0) and (fnat >= 0.3 and fnat <= 0.5)):
      line = l +' 2S\n'
      two=two+1
    elif ((irmsd <= 4.0 or lrmsd <= 10.0) and fnat >= 0.1) or ((lrmsd < 10.0 or irmsd < 4.0) and (fnat >= 0.1 and fnat <= 0.3)):
      line = l +' 1S\n'
      one=one+1
    else:
      line = l +' 0S\n'
      zero=zero+1    
    
    n.write(line)

  o.close()
  n.close()
  stars=open('no_of_stars','w')
  stars.write('3 Stars : '+str(three)+'\n')
  stars.write('2 Stars : '+str(two)+'\n')
  stars.write('1 Star : '+str(one)+'\n')
  stars.write('0 Star : '+str(zero)+'\n')

  stars.close()

if __name__ == "__main__":
  file=sys.argv[1]
  star_calc(file)
