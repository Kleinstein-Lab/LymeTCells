#!/bin/bash

# author: Edel Aron
# last updated: 2022-02-28
# description: this code runs the 10x Genomics 'cellranger aggr' with user-specified settings to help deal with the significant differences in read depth as determined during QC

# assumes that you have already run "generate_aggr_csv.R" to create aggr.csv
# uses the default "mapped" option for normalization (subsamples reads)
# the `nosecondary` flag stops additional analysis (such as clustering) from being done

# can output to a txt file with ./cellranger_aggr.sh > cellranger_aggr.txt

echo "Cell Ranger version: $(cellranger -V)"
echo "Data Type: Single Cell Gene Expression"
echo

# user-specific
id="aggr"
csv_dir="/home/edelaron/git/Research/LymeTCells/single_cell/primary_analysis/cellranger"
out_dir="/media/edelaron/Midas/lyme"

cd $out_dir
cellranger aggr --id=$id --csv=$csv_dir/aggr.csv --localcores=12
#  > $sample_name.out 2>&1
