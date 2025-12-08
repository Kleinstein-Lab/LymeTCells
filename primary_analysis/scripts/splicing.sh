#!/bin/bash

cd ~/git/Papers/IDEIS

# user-specific
data_dir="/media/edelaron/Midas/lyme" # the top level directory where all of your data lives
out_dir="${data_dir}/splicing/ideis"

# dataset-specific (change this as needed)
# this is an example which shows how different datasets could have different raw data naming conventions
datasets=('dataset2' 'dataset3' 'dataset4')
patterns=('*GEX*' '*5P*' '*HHT*') # how to match the GEX data (especially if you have AIRR or other data in the same directories)

# analyze each sample within each dataset
for ((i = 0 ; i < ${#datasets[@]} ; i++)); do
    in_dir="${data_dir}/${datasets[i]}/default/"
    echo "Input directory: $in_dir."
    echo "Output (and current working) directory: $out_dir."
    echo

    pattern="${in_dir}/${patterns[i]}"
    sample_dirs=( $pattern )
    num_samples=${#sample_dirs[@]}
    echo "There are $num_samples GEX sample(s) of interest in the input directory."
    echo

    sample_count=0
    for sample in ${sample_dirs[@]}; do
        if [ -d "$sample" ]; then
            (( sample_count+=1 ))
            sample_name=$(basename "$sample")
            echo "Processing Sample $sample_count: $sample_name"
            echo

            # run IDEIS
            python IDEIS_main.py Ref_Human "${in_dir}/${sample_name}/outs/possorted_genome_bam.bam" "${out_dir}/${sample_name}" -g Homo-Sapiens --force-cells 4000
        fi
    done

    echo "Done!"
    echo
done
