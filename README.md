# Lyme T Cells

This repository contains code and analysis pipelines for bulk and single-cell immune profiling in Lyme disease. The code is primarily organized as R Markdown (RMD) notebooks, with supporting R, Python, and shell scripts. You can convert RMD notebooks to R scripts using `knitr::purl()`.

For questions, contact the Kleinstein Lab. Please cite [Single cell immunophenotyping identifies CD8\+ GZMK\+ IFNG\+ T cells as a key immune population in cutaneous Lyme disease](https://www.biorxiv.org/content/10.1101/2025.06.09.658661v1?ct=).

## Repository Structure

- **bulk/**: Bulk TCR data processing pipelines and scripts. See [`bulk/README.md`](bulk/README.md) for details.
- **single_cell/**: Single-cell RNA-seq and immune profiling analysis. See [`single_cell/README.md`](single_cell/README.md) for details.

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/Kleinstein-Lab/LymeTCells.git
   cd LymeTCells
   ```
2. Review the READMEs for environment setup and pipeline instructions.
3. Most analyses require R (≥3.6). Some may involve Python (≥3.7).

## Data

- Bulk and single-cell datasets are referenced in the respective submodule READMEs. Some data may require access to Kleinstein Lab servers or Yale HPC.
- Metadata and sample information are in `single_cell/lyme_processing/metadata/`.
