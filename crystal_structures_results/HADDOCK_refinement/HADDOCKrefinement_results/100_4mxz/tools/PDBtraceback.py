#!/usr/bin/env python

USAGE = """
==========================================================================================

Author:			Marc van Dijk, Department of NMR spectroscopy, Bijvoet Center
			for Biomolecular Research, Utrecht university, The Netherlands
Copyright (C):		2006 (DART project)
DART version:		1.0  (01-01-2007)
DART plugin: 		PDBtraceback.py
Input:			Nothing, PDB files or file-lists and any of the allowed options 
			any order and combined 
Output:			A file called traceback.list or terminal output
Plugin excecution:	Either command line driven (use -h/--help for the option) or as 
			part of a DART batch sequence. Excecute anywhere inside the run 
			directory of choise.
Plugin function:	This script allows you to "traceback" any structure anywhere 
			within a run directory all the way back to the structures of the
			individual components used in the docking of that particular 
			structure.  
Examples:		PDBtraceback.py 
			PDBtraceback.py -f test.pdb
Plugin dependencies:	None

for further information, please contact:
			- DART website (http://www.nmr.chem.uu.nl/DART)
			- email: abonvin@chem.uu.nl

If you are using this software for academic purposes please quoting the following 
reference:

==========================================================================================
"""

"""import modules"""
import os, sys, copy
from time import ctime

def PluginCore(paramdict, inputlist):

	print "--> Starting PDB traceback process"
	
	if inputlist == None:
		traceback = StructureTraceback()
		traceback.GetBasedir()
		traceback.GetStartStruc()
		traceback.GetWatStructures()
		traceback.GetIt1Structures()
		traceback.GetIt0Structures()
		traceback.WriteFile(verbose=paramdict['verbose'],longout=paramdict['longout'])
	
	else:
		pdb = []
		for n in inputlist:
			base, extension = os.path.splitext(os.path.basename(n))
			if extension == ".pdb":
				pdb.append(base)
			else:
				try:
					files = file(n, 'r')
					lines = files.readlines()
					for line in lines:
						if line == '\n':
							pass
						else:
							pdb.append(line)
					print "    * Supply traceback information for file", os.path.basename(n) 
				except:
					print "    * ERROR: Could not parse file"
					sys.exit(0) 		
		
		traceback = StructureTraceback()
		traceback.IDStructures(filelist=pdb)	
		traceback.GetBasedir()
		traceback.GetStartStruc()
		traceback.GetWatStructures()
		traceback.GetIt1Structures()
		traceback.GetIt0Structures()
		traceback.ReportQuery(verbose=paramdict['verbose'])

#================================================================================================================================#
# 					PLUGIN SPECIFIC DEFINITIONS BELOW THIS LINE						 #
#================================================================================================================================#

class CommandlineOptionParser:
	
	"""Parses command line arguments using optparse"""
	
	def __init__(self):
		
		self.option_dict = {}
		self.option_dict = self.CommandlineOptionParser()
	
	def CommandlineOptionParser(self):
	
		"""Parsing command line arguments"""
	
		usage = "usage: %prog" + USAGE
		parser = OptionParser(usage)

		parser.add_option( "-f", "--file", action="callback", callback=self.varargs, dest="inputfile", type="string", help="Supply pdb or file.nam inputfile(s). Standard UNIX selection syntax accepted")
		parser.add_option( "-l", "--longout", action="store_true", dest="longout", default=False, help="Long output also includes all structures rejected in it0 and it1, default=False")
		parser.add_option( "-v", "--verbose", action="store_true", dest="verbose", default=False, help="All output to standard output")
		
		(options, args) = parser.parse_args()
		
		self.option_dict['input'] = options.inputfile
		self.option_dict['longout'] = options.longout
		self.option_dict['verbose'] = options.verbose
			
		if not self.option_dict['input'] == None:
			parser.remove_option('-f')
			arg = self.GetFirstArgument(parser, shorta='-f', longa='--file')
			self.option_dict['input'].append(arg)
			fullpath = self.GetFullPath(self.option_dict['input'])
			self.option_dict['input'] = fullpath
			
		if parser.has_option('-f'):
			pass
		else:
			parser.add_option( "-f", "--file", action="store", dest="dummy2", type="string") #only needs to be here to complete the argument list, not used!
	
		return self.option_dict
	
	def GetFullPath(self, inputfiles):
		
		currdir = os.getcwd()
		filelist = []
		
		for files in inputfiles:
			path = os.path.join(currdir, files)
			filelist.append(path)
			
		return filelist
	
	def GetFirstArgument(self, parser, shorta, longa):

		"""HACK, optparse has difficulties in variable argument lists. The varargs definition solves this but never reports the first 
		   argument of the list. This definition hacks this issue"""

		parser.add_option( shorta, longa, action="store", dest="temp", type="string", help="Execute custom workflow assembled on the command line. You can execute a single plugin by typing '-p pluginname' or a sequence of plugins by typing '-p plugin1,plugin2...'")

		(options, args) = parser.parse_args()
		first_arg = options.temp
		parser.remove_option(shorta)
		
		return first_arg
			
	def varargs(self, option, opt_str, value, parser):

		"""Deals with variable list of command line arguments"""

		value = []
		rargs = parser.rargs
		while rargs:
		    arg = rargs[0]

		    if ((arg[:2] == "--" and len(arg) > 2) or
        		(arg[:1] == "-" and len(arg) > 1 and arg[1] != "-")):
        		break
		    else:
        		value.append(arg)
        		del rargs[0]

		setattr(parser.values, option.dest, value)

class StructureTraceback:
	
	"""Traceback any structure within a run directory all the way back to the individual components that
	   were used in the docking"""
	
	def __init__(self):
		
		self.fileA_list = []
		self.fileB_list = []
		self.fileC_list = []
		self.fileD_list = []
		self.fileE_list = []
		self.fileF_list = []
		self.complex_list = []
		
		self.fileit0_list = []
		self.fileit1_list = []
		self.filew_list = []
		self.query = {}
		
	def _FormatLine(self, line):
	
		base = os.path.splitext(line.strip('""'))
		base2 = (base[0].split(':'))[1]
		base3 = base2.split('_')[-1]
		
		try:
			return float(base3)
		except:
			return float((base3.split('w'))[0])
	
	def _SortList(self, inlist=None,sortid=None):
	
		keydir = {}
		for n in inlist:
			keydir[n[sortid]] = n
		
		nameKeys = keydir.keys()
		nameKeys.sort()
		
		new = []
		for n in nameKeys:
			new.append(keydir[n])
		
		return new
	
	def _SortonIndex(self, inlist=None, indexlist=None, index=False):
	
		indexnr = []
		for n in indexlist:
			indexnr.append(n[0])
		
		tmp1 = []
		tmplist = copy.deepcopy(inlist)
		
		if index == False:
			for n in indexnr:
				for k in tmplist:
					if n == k[0]:
						tmp1.append(k)
						tmplist.remove(k)
		
		if index == True:
			for n in indexnr:	
				tmp1.append(inlist[int(n)-1])
			for n in tmplist:
				if n in tmp1:
					tmplist.remove(n)
				else:
					pass	
									
		return tmp1+tmplist
	
	def _FillList(self):
	
		lenit0 = len(self.fileit0_list)
		lenit1 = len(self.fileit1_list)
		lenw = len(self.filew_list)
		
		tmpit1 = []
		while lenit1 < lenit0:
			tmpit1.append([0.0,0.0])
			lenit1 = lenit1+1
		
		tmpw = []
		while lenw < lenit0:
			tmpw.append([0.0,0.0])
			lenw = lenw+1
			
		self.fileit1_list = self.fileit1_list+tmpit1
		self.filew_list = self.filew_list+tmpw	
	
	def IDStructures(self, filelist=None):
		
		currdir = os.getcwd()
		base,ext = os.path.split(currdir)
		
		if ext == 'it0':
			lib = 'it0'
		elif ext == 'it1':
			lib = 'it1'
		elif ext == 'water':
			lib = 'water'
		else:
			print "    * ERROR: Structure not present in either it0, it1 or water directory"
			sys.exit(0) 
		
		tmp = []
		for n in filelist:
			try:
				base = n.split('_')[1]
				tmp.append(float(base)[0])
			except:
				base = n.split('_')[1]
				tmp.append(float(base.split('w')[0]))
				
		self.query[lib] = tmp
		
	def GetBasedir(self):
		
		rundir = ''
		currdir = os.getcwd()
		nrdirs = len(currdir.split('/'))-1

		count = 0
		while count < nrdirs:
			base,ext = os.path.split(currdir)
			currdirname = list(ext)
			searchstring = currdirname[0]+currdirname[1]+currdirname[2]
			if searchstring == 'run':
				rundir = currdir 
				break
			else:
				currdir = base
			count = count+1

		if len(rundir) == 0:
			print "    * ERROR: No run directory found in current path, quit program"
			sys.exit(0)
		else:	
			self.rundir = rundir
		
	def GetStartStruc(self):

		"""Getting all starting structures from the file_X.list files in the begin directory"""

		begindir = self.rundir+'/begin'
		os.chdir(begindir)
		
		files = ['file_A.list','file_B.list','file_C.list','file_D.list','file_E.list','file_F.list']
		files2 = ['fileA_list','fileB_list','fileC_list','fileD_list','fileE_list','fileF_list']
		
		for file_list in files:
			if os.path.isfile(file_list):
				fileX = file(file_list, 'r')
				lines = fileX.readlines()
	
				for line in lines:
					tmp = (line.split('/'))[-1].strip('"\n')
					exec "self."+files2[files.index(file_list)]+".append(tmp)"
			else:
				pass
	
		""""Make combinations equal to generate_complex.inp and store in complex_list"""
		
		if len(self.fileA_list) > 0:
			for structureA in self.fileA_list:
				if len(self.fileB_list) > 0:
					for structureB in self.fileB_list:
						if len(self.fileC_list) > 0:
							for structureC in self.fileC_list:
								if len(self.fileD_list) > 0:
									for structureD in self.fileD_list:
										if len(self.fileE_list) > 0:
											for structureE in self.fileE_list:
												if len(self.fileF_list) > 0:
													for structureF in self.fileF_list:
														self.complex_list.append(structureA+"/"+structureB+"/"+structureC+"/"+structureD+"/"+structureE+"/"+structureF)
												else:
													self.complex_list.append(structureA+"/"+structureB+"/"+structureC+"/"+structureD+"/"+structureE)
										else:
											self.complex_list.append(structureA+"/"+structureB+"/"+structureC+"/"+structureD)
								else:
									self.complex_list.append(structureA+"/"+structureB+"/"+structureC)
						else:
							self.complex_list.append(structureA+"/"+structureB)
				else:
					self.complex_list.append(structureA)							
		else:
			print "    * ERROR No starting structures found in the begin directory"
			sys.exit(0)
		
	def GetIt0Structures(self):

		begindir = self.rundir+'/structures/it0'
		os.chdir(begindir)

		if os.path.isfile('file.list'):
			fileit0 = file('file.list', 'r')
			lines = fileit0.readlines()
		
			for line in lines:
				if line == '\n':
					pass
				else:
					tmp = []
					tmp.append(self._FormatLine(line.split()[0]))
					tmp.append(float(line.split()[2]))
					self.fileit0_list.append(tmp)
		else:
			print "    * ERROR: No file.list found in it0 directory. Nothing to trace means stop"
			sys.exit(0)
		
		self.nrstrucit0 = len(self.fileit0_list)
		nrstrucbg = len(self.complex_list)
		
		self.complex_list = self.complex_list * int((round(self.nrstrucit0/nrstrucbg))+1)
		self.complex_list = self.complex_list[0:self.nrstrucit0]

		self.fileit0_list = self._SortList(inlist=self.fileit0_list,sortid=0) #first sort on structure number low->high
		
		for n in xrange(len(self.complex_list)):			      #Match complex_list to it0 structures	
			self.fileit0_list[n].append(self.complex_list[n])
		
		self.fileit0_list = self._SortList(inlist=self.fileit0_list,sortid=1) #than sort on HADDOCK score low->high
		self.fileit0_list = self._SortonIndex(inlist=self.fileit0_list,indexlist=self.fileit1_list,index=True) #Sort according to index it1
		
	def GetIt1Structures(self):
		
		begindir = self.rundir+'/structures/it1'
		os.chdir(begindir)
		
		if os.path.isfile('file.list'):
			fileit1 = file('file.list', 'r')
			lines = fileit1.readlines()
		
			for line in lines:
				if line == '\n':
					pass
				else:
					tmp = []
					tmp.append(self._FormatLine(line.split()[0]))
					tmp.append(float(line.split()[2]))
					self.fileit1_list.append(tmp)
		else:
			print "    * ERROR: No file.list found in it1 directory. Nothing to trace means stop"
			sys.exit(0)
	
		self.nrstrucit1 = len(self.fileit1_list)
		self.fileit1_list = self._SortonIndex(inlist=self.fileit1_list,indexlist=self.filew_list,index=False) #Sort according to index W. This matches it1 to W
		
	def GetWatStructures(self):
		
		begindir = self.rundir+'/structures/it1/water'
		os.chdir(begindir)
		
		if os.path.isfile('file.list_all'):
			filew = file('file.list_all', 'r')
			lines = filew.readlines()
		else:
			filew = file('file.list', 'r')
			lines = filew.readlines()
		
		for line in lines:
			if line == '\n':
				pass
			else:
				tmp = []
				tmp.append(self._FormatLine(line.split()[0]))
				tmp.append(float(line.split()[2]))
				self.filew_list.append(tmp)
		
		self.nrstrucw = len(self.filew_list)
		
		if self.nrstrucw > 0:
			self.filew_list = self._SortList(inlist=self.filew_list,sortid=1) #Sort on HADDOCK score low->high. 
		else:
			print "    No file.list of file.list_all found in water refinement directory. Only traceback from it1 to it0"
				
	def WriteFile(self, verbose=False, longout=False):
		
		os.chdir(self.rundir)
		
		if verbose == True:
			outfile = sys.stdout
		else:
			outfile = file('traceback.list', 'w')
			print "    * Traceback information written to file 'traceback.list' in directory", self.rundir
		
		outfile.write('*****************************************************************************************************************\n')
		outfile.write('Structure traceback information for run %s\n' % self.rundir)
		outfile.write('Date/time: %s\n' % ctime())
		outfile.write('Number of structures: %i in it0, %i in it1 and %i in water refinement\n' % (self.nrstrucit0,self.nrstrucit1,self.nrstrucw))
		outfile.write('Sorting order: water(struct. nr.) matches it1 (struct. nr.) matches it0 (struct. nr.) matches input structures.\n')
		outfile.write('*****************************************************************************************************************\n')
		outfile.write('      complex                             it0      hscoreit0       it1      hscoreit1      water      hscorew\n')
		if longout == True:
			self._FillList()
			for n in range(len(self.fileit0_list)):
				outfile.write('%35s%10.0f%15.4f%10.0f%15.4f%10.0f%15.4f\n' % (self.fileit0_list[n][2],self.fileit0_list[n][0],self.fileit0_list[n][1],
					       self.fileit1_list[n][0],self.fileit1_list[n][1],self.filew_list[n][0],self.filew_list[n][1]))
		else:
			for n in range(len(self.filew_list)):
				outfile.write('%35s%10.0f%15.4f%10.0f%15.4f%10.0f%15.4f\n' % (self.fileit0_list[n][2],self.fileit0_list[n][0],self.fileit0_list[n][1],
					       self.fileit1_list[n][0],self.fileit1_list[n][1],self.filew_list[n][0],self.filew_list[n][1]))
		
		if verbose == False:
			outfile.close()
		else:
			pass	

	def ReportQuery(self, verbose=False):
		
		os.chdir(self.rundir)
		
		if verbose == True:
			outfile = sys.stdout
		else:
			outfile = file('traceback.list', 'w')
			print "    * Traceback information written to file 'traceback.list' in directory", self.rundir
		
		outfile.write('*****************************************************************************************************************\n')
		outfile.write('Structure traceback information for run %s\n' % self.rundir)
		outfile.write('Date/time: %s\n' % ctime())
		outfile.write('Number of structures: %i in it0, %i in it1 and %i in water refinement\n' % (self.nrstrucit0,self.nrstrucit1,self.nrstrucw))
		outfile.write('Sorting order: water(struct. nr.) matches it1 (struct. nr.) matches it0 (struct. nr.) matches input structures.\n')
		outfile.write('*****************************************************************************************************************\n')
		outfile.write('      complex                              it0      hscoreit0       it1      hscoreit1      water      hscorew\n')
		
		if self.query.keys() == ['water']:
			for n in self.query['water']:
				for k in self.filew_list:
					if n == k[0]:
						outfile.write("%35s%10.0f%15.4f%10.0f%15.4f%10.0f%15.4f\n" % (self.fileit0_list[self.filew_list.index(k)][2],self.fileit0_list[self.filew_list.index(k)][0],
							       self.fileit0_list[self.filew_list.index(k)][1],self.fileit1_list[self.filew_list.index(k)][0],self.fileit1_list[self.filew_list.index(k)][1],n,k[1]))
		elif self.query.keys() == ['it1']:
			for n in self.query['it1']:
				for k in self.fileit1_list:
					if n == k[0]:
						outfile.write("%35s%10.0f%15.4f%10.0f%15.4f%10.0f%15.4f\n" % (self.fileit0_list[self.fileit1_list.index(k)][2],self.fileit0_list[self.fileit1_list.index(k)][0],
							       self.fileit0_list[self.fileit1_list.index(k)][1],n,k[1],self.filew_list[self.fileit1_list.index(k)][0],self.filew_list[self.fileit1_list.index(k)][1]))
		elif self.query.keys() == ['it0']:
			self._FillList()
			for n in self.query['it0']:
				for k in self.fileit0_list:
					if n == k[0]:
						outfilewrite("%35s%10.0f%15.4f%10.0f%15.4f%10.0f%15.4f\n" % (k[2],n,k[1],self.fileit1_list[self.fileit0_list.index(k)][0],self.fileit1_list[self.fileit0_list.index(k)][1],
							       self.filew_list[self.fileit0_list.index(k)][0],self.filew_list[self.fileit0_list.index(k)][1]))	
		
		if verbose == False:
			outfile.close()
		else:
			pass	
		
if __name__ == '__main__':

	"""Running from the command line"""
	from optparse import *
	
	"""Parse command line arguments"""
	option_dict = CommandlineOptionParser().option_dict

	"""Envoce main functions"""
	PluginCore(option_dict, inputlist=option_dict['input'])
	
	"""Say goodbye"""
	print "--> Thanks for using PDBtraceback, bye"
	sys.exit(0)
	
	
