#!/usr/bin/env python3
import argparse
import os
from pathlib import Path
import multiprocessing
import subprocess

def create_filesin(j):
    with open('files.in', 'w') as f:
        f.write('input/big.in\n')
        f.write(f'input/small{j}.in\n')     
        f.write('input/param.in\n')       
        f.write('output/xv.out\n')        
        f.write('output/ce.out\n')        
        f.write('output/info.out\n')      
        f.write('output/big.dmp\n')       
        f.write('output/small.dmp\n')     
        f.write('output/param.dmp\n')     
        f.write('output/restart.dmp\n')

def run_mercury(batchnum):
    os.chdir(str(batchnum))
    # Run mercury in folder batchnum 
    #proc = subprocess.Popen('./mercury6', stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, universal_newlines=True)
    result = subprocess.run(['./mercury6'], capture_output=True, text=True)
    # Run differential corrections
    os.chdir('..') 
    return result.stdout

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Run mercury in batches on multiple cores")

    # Add optional flags
    parser.add_argument("-n", "--ncores", type=int, required=True, help="Number of cores")
    args = parser.parse_args()
    ncores = args.ncores

    # Determine number of batches
    input_dir = Path("input")
    files = list(input_dir.glob("small*.in"))
    nbatch = len(files)

    # Create every environment
    for j in range(1, nbatch+1):
        if os.path.isdir(str(j)):
            os.system('rm -rf ' + str(j))
            os.mkdir(str(j))
        else:
            os.mkdir(str(j))
        os.chdir(str(j))

        os.mkdir('input')
        os.mkdir('output')

        # Get input for batch j
        os.chdir('input')
        os.symlink('../../input/big.in', 'big.in')
        os.symlink(f'../../input/small{j}.in', f'small{j}.in')
        os.symlink('../../input/param.in', 'param.in')
        os.chdir('..')

        # Link to the executables
        os.symlink('../../../bin/mercury6', 'mercury6')
        os.symlink('../../../bin/mercury6_yorp', 'mercury6_yorp')
        os.symlink('../../../bin/elemet6', 'element6')
        os.symlink('../../../bin/close6', 'close6')
        
        # Create files.in and message.in
        os.symlink('../../../dat/default/message.in', 'message.in')
        create_filesin(j)

        os.chdir('..')


    # Run mercury6 in parallel
    # List of first inputs
    runlist = range(1, nbatch + 1)
    # Create a pool of worker processes
    with multiprocessing.Pool(processes=ncores) as pool:
        # Map the partial function over the list of first inputs in parallel
        results = pool.map(run_mercury, runlist)
