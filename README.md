# Guide to making a phylogenetic tree using Bakta, Panaroo and RAxML


## Bakta Annotation
### Requirements:
1. Directory containing genomes to be annotated
2. A list of genome files to annotate (a txt file containing a different genome file name on each line)
3. A conda environment containing `bakta`

### Things to modify in the script (from top):
1. The array size, this should be the 1-x where x is the number of genomes being run
2. `--mail-user=xxx` to your email address
3. The paths to the .out and .err files
4. Conda environment path, this needs to be one in your system
5. GENOME_PATH, this should be the file path to your genome directory (use pwd)
6. GENOME_LIST, this is the .txt file

## Panaroo 
Used for the identification of the core and accessory genomes. For this it needs the gff3 files from bakta (all in a single directory) and also a txt file containing a list of the gff3 files present in this directory. I have been running panaroo from this directory, it may work if you specify the path to the file as well, but I haven't checked.

### Requirements
1. Bakta gff3 outputs
2. txt file containing gff3 output names
3. Conda environment containing bakta

### Things to modify in the script (from the top)
1. Resource allocation (number of tasks and time). I ran this with ~3000 genomes and used 24 threads. I'd reduce the number of threads and time requirement considerably with fewer genomes (panaroo scales ~quadratically), but you'd have to play with this a bit. Maybe try something like 6 or 8 threads and 6 hours (though it is less important to change the time section). It is important to change the -t in the panaroo script so it is the same as the --ntasks-per-node.
2. --mail-user
3. The path for the `source activate path/to/env` section
4. Name of the txt file containing a list of gff3 files 
5. Number of threads (-t) mentioned in 1


## RAxML Phylogenetic Tree Generation
For RAxML tree generation use the output of panaroo called core_gene_alignment_filtered.aln

### Things to modify in the script (from the top)
1. --ntasks with fewer genomes 39 threads is likely to be less efficient and result in a longer queue time, but you will have to play with this. Maybe go with about 24?
2. --partition, you will save a lot of time if you can get this working in the short partition (<12h) so I would recommend submitting it to this if it can run in this time. 1.5k-2k genomes takes ~2 days.
3. --time, adjust based on the partition you are submitting to.
4. -n the name of the output
5. For RAxML scripts will run faster on the arc cluster than htc, due to the number of CPUs being requested.
