#!/bin/sh
#SBATCH --job-name=campy_panaroo
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --cluster=htc
#SBATCH --partition=short
#SBATCH --time=12:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=trop0670@ox.ac.uk
module purge
module load Anaconda3
source activate /data/biol-micro-genomics/trop0670/env/panaroo
panaroo -i chicken_and_wb_bakta_list.txt -o chicken_vs_wb_panaroo -a core -t 24 --clean-mode strict --remove-invalid-genes
