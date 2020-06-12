#!/usr/bin/env python2.5

#############################################
#   Authors:TRELLET Mikael                  #
#           RODRIGUES Joao                  #
#           MELQUIOND Adrien                #
#                                           #
#   Created:        February    2011        #
#   Last Updated:   May         2011        #
#############################################

"""Calculates a matrix of fraction of common contacts between two or more structures."""

# Contact Parsing routines
def parse_contact_file(f_list, ignore_chain):
    """Parses a list of contact files."""
    
    if ignore_chain:
        # contacts = [ set([ int(l[0:5]+l[6:11]) for l in open(f)]) for f in f_list]
        contacts = [ [ int(l[0:5]+l[6:11]) for l in open(f)] for f in f_list]
    else:
        contacts = [ set([ int(l) for l in open(f)]) for f in f_list]

    return contacts

# FCC Calculation Routine
def calculate_fcc(listA, listB):
    """
    Calculates the fraction of common elements between two lists
    taking into account chain IDs
    """
    
    cc = len(listA.intersection(listB))
    cc_v = len(listB.intersection(listA))
    
    return (cc, cc_v)
    
def calculate_fcc_nc(listA, listB):
    """
    Calculates the fraction of common elements between two lists
    not taking into account chain IDs. Much Slower.
    """
    
    largest,smallest = sorted([listA, listB], key=len)
    ncommon = len([ele for ele in largest if ele in smallest])
    return (ncommon, ncommon)

# Matrix Calculation

def calculate_pairwise_matrix(contacts, ignore_chain):
    """ Calculates a matrix of pairwise fraction of common contacts (FCC).
        Outputs numeric indexes.

        contacts: list_of_unique_pairs_of_residues [set/list]
        
        Returns pairwise matrix as an iterator, each entry in the form:
        FCC(cplx_1/cplx_2) FCC(cplx_2/cplx_1)
    """

    contact_lengths = [1/float(len(i)) for i in contacts if len(i)!=0]
    if ignore_chain:
        calc_fcc = calculate_fcc_nc
    else:
        calc_fcc = calculate_fcc
    
    for k in xrange(1, len(contacts)):
        cc, cc_v = calc_fcc(contacts[0], contacts[k])
        fcc = cc*contact_lengths[0]
        yield (1, k+1, fcc)
        # yield (i+1, k+1, len(contacts[i].intersection(contacts[k]))*contact_lengths[i], len(contacts[k].intersection(contacts[i]))*contact_lengths[k])

def _output_fcc(output, values, f_buffer):

    c = 0
    buf = []
    for i in values:
        buf.append(i)
        if len(buf) == f_buffer:
            output( ''.join(["%s %s %1.3f\n" %(i[0],i[1],i[2]) for i in buf]) )
            buf = []
    output( ''.join(["%s %s %1.3f\n" %(i[0],i[1],i[2]) for i in buf]) )
    
if __name__ == '__main__':
    
    import optparse
    import sys
    from time import time, ctime
    import os
    
    USAGE = "%s <contacts file 1> <contacts file 2> ... [options]\n" %os.path.basename(sys.argv[0])
    
    parser = optparse.OptionParser(usage=USAGE)
    parser.add_option('-o', '--output', dest="output_file", action='store', type='string',
                        default=sys.stdout,
                        help='Output File [default: STDOUT]')
    parser.add_option('-f', '--file', dest="input_file", action='store', type='string',
                        help='Input file (one contact file name per line)')
    parser.add_option('-b', '--buffer_size', dest="buffer_size", action='store', type='string',
                        default=50000, 
                        help='Buffer size for writing output. Number of lines to cache before writing to file [default: 50000]')
    parser.add_option('-i', '--ignore_chain', dest="ignore_chain_char", action='store_true',
                        help='Ignore chain character in residue code. Use for homomeric complexes.')
 
    (options, args) = parser.parse_args()
    
    if options.input_file:
        args = [name.strip() for name in open(options.input_file)]

    if len(args) < 2:
        sys.stderr.write("- Provide (at least) two structures to calculate a matrix. You provided %s.\n" %len(args))
        sys.stderr.write(USAGE)
        sys.exit(1)

    sys.stderr.write("+ BEGIN: %s\n" %ctime())
    if options.ignore_chain_char:
        sys.stderr.write("+ Ignoring chains. Expect a considerable slowdown!!\n")
        exclude_chains = True
    else:
        exclude_chains = False
        
    t_init = time()
    sys.stderr.write("+ Parsing %i contact files\n" %len(args))

    c = parse_contact_file(args, exclude_chains)
    m = calculate_pairwise_matrix(c, exclude_chains)
    
    if isinstance(options.output_file, str):
        f = open(options.output_file, 'w')
    else:
        f = options.output_file

    sys.stderr.write("+ Calculating Matrix\n") # Matrix is calculated when writing. Generator property.
    sys.stderr.write("+ Writing matrix to %s\n" %f.name)
    _output_fcc(f.write, m, options.buffer_size)
    
    if isinstance(options.output_file, str):
        f.close()
    t_elapsed = time()-t_init
    sys.stderr.write("+ END: %s [%6.2f seconds elapsed]\n" %(ctime(), t_elapsed))
