#!/usr/bin/env python

"""
Removes unnecessary log/job files from a completed/failed
HADDOCK run directory.

Keep representative files in case of a successful run (structure #1)
or all files for those structures that failed to allow post-mortem debugging.
"""

import glob
import os
import re
import sys

# This will be ran in a HADDOCK run directory
# Goals:
#   1. Check stage by stage for presence of file.nam
#   2. Get numbers to remove
#   3. Remove log/out files corresponding      
#   4. Rename random file to refine_1.out.gz to make server behave

def parse_run_cns(rundir='.'):
    """
    Check run.cns for the number of desired structures.
    Also extracts the root for file names.
    """
    
    n_it0_regex = re.compile('structures_0=([0-9]+);')
    n_it1_regex = re.compile('structures_1=([0-9]+);')
    n_itw_regex = re.compile('waterrefine=([0-9]+);')

    handle = open('run.cns', 'r')
    for line in handle:

        result_it0 = n_it0_regex.search(line)
        if result_it0:
             n_it0 = int(result_it0.group(1))
             continue
             
        result_it1 = n_it1_regex.search(line)
        if result_it1:
             n_it1 = int(result_it1.group(1))
             continue
             
        result_itw = n_itw_regex.search(line)
        if result_itw:
             n_itw = int(result_itw.group(1))
             continue

    return (n_it0, n_it1, n_itw)

def check_stages(n_structs, rundir='.'):
    """
    Iterates over the structures/ subfolder searching for file.nam.
    Returns an array with the numbers of the structures to keep log/out files for.
    """

    folders = ['structures/it0', 'structures/it1', 'structures/it1/water']
    for n_struct, afolder in zip(n_structs, folders):
        fnam_path = os.path.join(rundir, afolder, 'file.nam')
        search_string = os.path.join(rundir, afolder, '*[0-9].pdb')
        structures = glob.glob(search_string)

        if not os.path.exists(fnam_path):
            # Run failed at this stage
            # Collect all structure numbers
            expected = set(xrange(1, n_struct + 1))
            present = set( map(lambda x: int(x.split('_')[-1][:-4]), structures) )
            missing = expected - present
            yield missing
        else:
            yield set([])

def remove_files(lst_tuples):
    """
    Removes log/out files of structures with particular numbers.
    """
    
    def find_disposables(lst_files, lst_failed, regex):

        disposables = []
        set_failed = lst_failed
        lst_files = lst_files
        name_regex = regex
        
        stnum_regex = re.compile('_([0-9]{1,5})')
        
        stage_files = filter(lambda x: name_regex.search(x), lst_files)
        for fname in stage_files:
            num = int(stnum_regex.search(fname).group(1))
            if num not in set_failed:
                disposables.append(fname)
        return disposables

        
    stage_prefix = ('it0', 'it1', '')
    stage_suffix = ('', '', 'w')    

    # Iterate in the reverse order to have a decent view of the completion of the run
    for failed_structs, prefix_str, suffix_str in zip(lst_tuples, stage_prefix, stage_suffix)[::-1]:

        inp_files = glob.glob('*_*.inp')
        job_files = glob.glob('*_*.job')
        job_out_files = glob.glob('*_*.job.o*')
        job_err_files = glob.glob('*_*.job.e*')
        out_files = glob.glob('*_*.out*')

        stage_ok = False    
        # Stage successfully completed 
        if not failed_structs:
            failed_structs = set([1])
            stage_ok = True

        stage_regex = re.compile(prefix_str+'.*_.*'+suffix_str+'.(inp|out|job).*')

        # Identify disposables
        disposables_inp = find_disposables(inp_files, failed_structs, stage_regex)
        disposables_job = find_disposables(job_files, failed_structs, stage_regex)
        disposables_out = find_disposables(out_files, failed_structs, stage_regex)

        # print "Stage", suffix_str, prefix_str, stage_ok
        if stage_ok:
            # Remove all job.o and job.e files
            disposables_jobo = filter(lambda x: stage_regex.search(x), job_out_files)
            disposables_jobe = filter(lambda x: stage_regex.search(x), job_err_files)
        else:
            disposables_jobo = find_disposables(job_out_files, failed_structs, stage_regex)
            disposables_jobe = find_disposables(job_err_files, failed_structs, stage_regex)
        
        disposables = disposables_inp + disposables_job + disposables_jobo + disposables_jobe + disposables_out

        # remove disposables
        # print "Removing:", len(disposables)
        for fname in disposables:
            os.remove(fname)

        # Cleanup
        if stage_ok:
            # print "Resetting stage"
            failed_structs = set([])          
        else:
            # Make link to support server message
            remaining_out_files = filter(lambda x: stage_regex.search(x), glob.glob('*_*.out*'))
            if remaining_out_files:
                # print "Picking random file", len(remaining_out_files)
                random_file = remaining_out_files[0]
                # Make new name
                nname = re.sub('_refine_[0-9]{1,5}'+suffix_str+'.out', '_refine_1'+suffix_str+'.out', random_file)
                # print "Naming", random_file, "to", nname

                if not os.path.exists(nname):
                    print "  Run failed. Linking", random_file, "to", nname, "for user inspection."
                    os.symlink(random_file, nname)    

if __name__ == '__main__':
    print " Cleaning up HADDOCK run directory "
    n_structs = parse_run_cns()
    results = list(check_stages(n_structs))
    remove_files(results)
