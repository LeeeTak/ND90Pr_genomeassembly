#!/bin/bash
#SBATCH -p normal
#SBATCH --cpus-per-task=10
#SBATCH --mem=50G
#SBATCH --error=stderr_canu.txt
#SBATCH --job-name=canu_nano
canu -d canu_nano -p ND90Pr genomeSize=35m -nanopore-raw ND90Pr_Novo_Nanopore.fastq.gz
