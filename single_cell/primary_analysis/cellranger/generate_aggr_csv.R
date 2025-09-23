# -------------------------------------
# Author: Edel Aron
# Date Created: 2021-07-26
# Last Updated: 2022-02-28
#
# R version 4.0.5 (2021-03-31)
# Platform: x86_64-pc-linux-gnu (64-bit)
# Running under: Ubuntu 20.04.4 LTS
#
# Title: aggr.csv generation for running cellranger aggr
# Description:
#   This code generates the csv file needed to aggregate GEX data through the 10x Genomics Cell Ranger's processing pipeline
#
# Notes:
#   * "sample_id" and "molecule_h5" are required to be included
#   * Use the "cellranger_aggr.sh" script to actually do the aggregation
#   * This code was run for datasets 2, 3 and 4
# -------------------------------------
# make sure the environment is clear
rm(list = ls())

# set the working directory
path_base <- file.path("~", "git", "Research", "lyme", "single_cell") # Linux
# setwd(path_base)

# set the data directory
path_data_root <- file.path("/media", "edelaron", "Midas", "lyme") # Linux

# set other useful directories
path_out <- file.path(path_base, "primary_analysis", "cellranger")

# install packages if needed
packages <- c("tidyverse")
new.pkg <- packages[!(packages %in% installed.packages())]
if (length(new.pkg)) {install.packages(new.pkg)}

# load packages
for (n in 1:length(packages)) {
    library(packages[n], character.only = TRUE)
}

# remove unnecessary variables
rm(n, new.pkg, packages)
# -------------------------------------
# read in the metadata for the dataset(s) of interest
meta <- read_csv(file.path(path_base, "metadata", "meta_bockenstedt_lyme.csv"),
                 col_types = cols(.default = "c"))

# choose the columns to be included
cols_req <- c("SampleName", "SampleDir") # columns to represent the two required ones
cols_meta <- c("Subject", "SampleType", "Dataset", "Year", "Disease") # has to be columns in the metadata

# create the aggr table
aggr <- meta %>% filter(DataType == "GEX") %>% select(c(all_of(cols_req), all_of(cols_meta)))
aggr <- aggr %>% rename(sample_id = SampleName, molecule_h5 = SampleDir)
aggr$molecule_h5 <- file.path(path_data_root, paste0("dataset", aggr$Dataset), "default",
                              aggr$molecule_h5, "outs", "molecule_info.h5")

# generate the csv file
write.csv(aggr, file = file.path(path_out, "aggr.csv"), row.names = FALSE, quote = FALSE)