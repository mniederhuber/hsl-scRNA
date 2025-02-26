#!/bin/bash
#SBATCH --job-name=downloadData
#SBATCH --mem=8G
#SBATCH --time=0-00:30

mkdir -p data

donors=("1" "2" "3" "4")

for i in "${donors[@]}"; do \
    mkdir -p data/PBMC_${i} 
    wget https://cf.10xgenomics.com/samples/cell-exp/9.0.0/20k_Human_Donor1-4_PBMC_3p_gem-x_multiplex_5k_Human_Donor${i}_PBMC_3p_gem-x/20k_Human_Donor1-4_PBMC_3p_gem-x_multiplex_5k_Human_Donor${i}_PBMC_3p_gem-x_count_sample_filtered_feature_bc_matrix.tar.gz -P data/ && \
    tar -xvf data/20k_Human_Donor1-4_PBMC_3p_gem-x_multiplex_5k_Human_Donor${i}_PBMC_3p_gem-x_count_sample_filtered_feature_bc_matrix.tar.gz -C data/PBMC_${i} && \
    rm data/20k_Human_Donor1-4_PBMC_3p_gem-x_multiplex_5k_Human_Donor${i}_PBMC_3p_gem-x_count_sample_filtered_feature_bc_matrix.tar.gz 
done

