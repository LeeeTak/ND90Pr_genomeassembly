#!/bin/bash
#SBATCH -p normal
#SBATCH --cpus-per-task=16
#SBATCH --mem=50G
#SBATCH --error=stderr_verkko.txt
#SBATCH --job-name=verkko
verkko -d verrko_sampled --hifi sampled0.22_m64024_210630_044114.ccs.fastq.gz --nano canu_nano/ND90Pr.correctedReads.fasta.gz
