#!/bin/sh
#SBATCH --job-name=bakta
#SBATCH --array=1-3
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --partition=short
#SBATCH --time=02:59:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=trop0670@ox.ac.uk
#SBATCH --output=/data/biol-micro-genomics/trop0670/241015_campy_gwas/gwas/bakta/outputs/bakta_%A_%a.out
#SBATCH --error=/data/biol-micro-genomics/trop0670/241015_campy_gwas/gwas/bakta/outputs/bakta_%A_%a.err

module purge
module load Anaconda3/2024.02-1
source activate /data/biol-micro-genomics/trop0670/env/bakta

# Define the path to the genome directory
GENOME_PATH="/data/biol-micro-genomics/trop0670/241015_campy_gwas/campy_genomes_zipped/unzipped_genomes/"

# Read the list of genome files (only filenames, no paths)
GENOME_LIST=/data/biol-micro-genomics/trop0670/241015_campy_gwas/gwas/bakta/bakta_genome_list3.txt
GENOME=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $GENOME_LIST)

# Construct the full path to the genome file
GENOME_FILE="${GENOME_PATH}${GENOME}"

# Check if the genome file exists
if [ -f "$GENOME_FILE" ]; then
    # Run bakta with the full path to the genome
    bakta --db /data/biol-micro-genomics/trop0670/db/bakta/db --keep-contig-headers -t 4 --skip-crispr --prefix ${GENOME/.f*/} --force "$GENOME_FILE" --output /data/biol-micro-genomics/trop0670/241015_campy_gwas/gwas/bakta/rerun/${GENOME/.f*/}_bakta_out
else
    # Print an error message and skip this file
    echo "Error: Genome file $GENOME_FILE not found. Skipping..."
fi
