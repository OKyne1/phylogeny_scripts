#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=39
#SBATCH --cluster=all
#SBATCH --partition=long
#SBATCH --time=30-48:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=trop0670@ox.ac.uk

module purge
module load Anaconda3
module load RAxML/8.2.12-gompi-2021b-hybrid-avx2

raxmlHPC -T 39 -f a -N 5 -x 12345 -p 12345 -m GTRGAMMA -# 100 -s core_gene_alignment_filtered.aln -n chicken_vs_wb

