The genome was assembled with the hybrid assembly method, using Verrko.

The input files were:
ND90Pr_Novo_Nanopore.fastq.gz - Nanopore sequencing
m64024_210630_044114.ccs.fastq.gz - Pacbio HiFi ccs

1. Ran canu to correct Nanopore reads.
The initial input had 200x depth. The corrected reads have 39.39x.
This is importance as first of all, we do not need 200x depth and only uses up too much memory when generating assembly paths.
Eventually it would lead to out of memory error.

Used canu corrected "ND90Pr.correctedReads.fasta.gz" file as input for Verkko.

2. Subsampled ccs sequence.
The depth of the ccs sequencing was calculated by first counting the number of base pairs with the following command:
zcat m64024_210630_044114.ccs.fastq.gz | awk 'NR % 4 == 2 {bases += length($0)} END {print bases}'

This led to total bps of 30897752541.

The ND90Pr genome is approximately 35Mbp. The depth is 30897752541/35000000 = 882.8.
As mentioned above, this is too extensive depth and will also lead to out of memory error when using any assembly software.
Subsampled the ccs sequence using seqkit
zcat m64024_210630_044114.ccs.fastq.gz | seqkit sample -p 0.22 -o sampled0.22_m64024_210630_044114.ccs.fastq.gz

used 0.22 for proportion, which leds to approximately 200x depth which was recommended to use in several papers for accuracy.

These two new files were used as input to Verkko for hybrid assembly.
Verkko took approximately 19hrs to finish the assembly.

Wanted to check whether the Vhv1 region is intact in the new assembly. Used minimap2 to align the Vhv1 region to the genome and visualised it by manually plotting synteny plot.
The Vhv1 region from illumina sequencing assembly is mapped to scaffold-0000044. However it is split into two regions and some are mapped multiple times.
It is positive that the region only maps to a single scaffold, but the mapping is not that clean.

The intactness of the genome was validated by using the tool quarTeT, by finding the repeated telomere regions in each end of the chromosomes.
The contigs that are longer than 120kbp all have telomeres (auto detected ACTCTCT sequence) on both ends.

The genome was aligned to itself with minimap2, to see if there were any duplicated regions.
All the contigs mapped to itself with the mapping quality of 60 and there weren't any cross-mapping amongst the contigs.

The overall genome quality was validated with quast. And the numbers look decent. 

However Shaobin says that there is a problem with the Vhv1 region.

