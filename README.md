# Plink map to chromosome.data
1. Order SNPs by positions
2. Winthin-chromosome index (starting from 1) and overall index
3. Chips
4. Keep only autosomes (optional)

# pedigree.file
1. Convert letter IDs to number IDs
2. Convert 0, 1, and 2 to F, M, and F, respectively
3. Order by birthdate

# genotypes.txt
1. Animal number IDs corresponding to those in pedigree.file
2. Chip number (always 1)
3. Number of SNPs
4. Since SNPs have been reordered in chromosome.data, SNP genotypes must be recordered accordingly.
