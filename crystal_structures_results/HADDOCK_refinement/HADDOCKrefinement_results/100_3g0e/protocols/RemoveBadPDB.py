import sys,os, time
pdbfile = sys.argv[1]
pdbfile0 = pdbfile + "0"

time.sleep(5)
err = 0; pdblines = None
while err < 10:
  try:
    pdblines = open(pdbfile0).read()
    break
  except:
    err += 1
    time.sleep(5)

ok = True
if pdblines:    
  for l in pdblines.splitlines():
    if not l.startswith("ATOM"): continue
    try:
      x,y,z = float(l[30:38]), float(l[38:46]), float(l[46:54])
    except ValueError:
      ok = False
      break
else:
  ok = False

if ok:
  os.rename(pdbfile0, pdbfile)
else:
  os.remove(pdbfile0)  
