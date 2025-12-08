# Lyme T Cells

This repository contains code and analysis pipelines for single-cell transcriptomic and immune profiling in Lyme disease. The code is primarily organized as R Markdown (RMD) notebooks, with supporting R, Python, and shell scripts. You can convert RMD notebooks to R scripts using `knitr::purl()`.

Please cite [Single cell immunophenotyping identifies CD8\+ GZMK\+ IFNG\+ T cells as a key immune population in cutaneous Lyme disease](https://www.biorxiv.org/content/10.1101/2025.06.09.658661v1?ct=). The graphical abstract is [available here](https://app.biorender.com/citation/68fbc783f68c818efe196e5c). Data is [publicly available on GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE297325).

For questions or comments, contact the Kleinstein Lab at Yale University. 

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/Kleinstein-Lab/LymeTCells.git
   cd LymeTCells
   ```
	- Note that some images were included with the repository, so be very careful if you clone it and make your own commits as git does not handle binary files well.
2. Review the README for environment setup and pipeline instructions.
	* A lot of details were included within the notebooks.
	* *primary_analysis/Lyme_Combined_Processing.Rmd* will generate a handy HTML file when knit (you will need to knit the other notebooks so that the links within work though).
	* *primary_analysis/style.css* is just included to make the HTML files prettier; it isn't necessary.
3. Most analyses require R (≥3.6). Some may involve Python (≥3.7).
	   * Python is needed for the two included downstream analyses (splicing and TRUST4).


## Details
### General

- Metadata and clinical information are in `metadata/`.
	- `meta_bockenstedt_lyme.csv` contains the standardized sample info with the following columns:
		- SampleDir: The name of the original /raw directory.
		- SampleDirCleaned: Same as SampleDir, except that the TCR samples have suffixes such as "VDJ\_VHT" and "\_VHT" removed.
		- SampleNameOriginal: The subsection of SampleDir that excludes the data type (e.g. GEX) and previously mentioned suffixes.
		- SampleName: The standardized sample name since some of the labels were wrong or messy (e.g. U19L202398_0SC instead of 202938_SC).
			- "0"'s are removed.
			- Underscores are added when needed.
		- Subject: The subject ID.
		- SampleType: The tissue that the sample came from e.g. blood, EM or control.
		- DataType: Gene expression (GEX) or immune profiling (TCR).
		- Dataset: The custom defined dataset e.g. 2, 3 or 4.
		- Year: The year the analysis was run.
		- Disease: Lyme.
  - `resources/`: Markers

- Datasets were processed with 10x Genomics' Cell Ranger 6.1.2 (GRCh38-2020-A, vdj_GRCh38_alts_ensembl-5.0.0).
- Note that the datasets within most of the code and the tables are labelled 2 to 4. In the paper these were renamed to 1 to 3 as we do not include "dataset 1" in this analysis.
- Change paths as needed to match your structure. They were defined at the top of each notebook, so you'll only have to change them in one location instead of searching through each file.
- Intermediate objects loaded in many of the notebooks were not made available on GEO, but you should be able to build them from the code provided and the raw fastq data.

### BCR filtering

Although the BCR data is not currently made available because we are working on another manuscript focusing on the B cells, BCRs (B cell receptors) and TCRs (T cell receptors) were analyzed together when we were working on this paper. As such, we filtered out cells that had both a BCR and a TCR as part of the quality control. To reproduce the exact objects that are available in this analysis, we have included a list of the exact cell_ids which were removed in *resources/removed_cell_ids.txt*.

It is possible that cells with both BCRs and TCRs are biologically relevant (e.g. interacting B and T cells), but they are such a teeny tiny fraction that we decided it was best to just remove them.

### Cell type annotation
- A table of marker genes for plotting is available in `resources/`; add to it as you see fit for your work.
	- Only human markers have been included.
    - Choose whichever markers you want for the `DotPlot`s.
    - Donna Farber, Ira Fleming, and Mary Tomayko are collaborators with our lab.
- Annotated cell types were saved to `primary_analysis/tables/` so that they can be easily shared with collaborators or used in other scripts.
- `FindMarkers` is a problematic method since it double dips, but can help with coming up with markers to plot.
- Cell type colors were picked to work well together and work for color blindness.
- It wasn't included here, but Azimuth was also run and annotated the gamma-delta T cell cluster in the blood just like we did manually.

### Plotting

- `FeaturePlot()`s are easier to see with a different color scale e.g. `scale_color_viridis(option = "G", direction = -1)`.
- The default `ggplot2` colors are hard to distinguish; we like using `hues::iwanthue`, which was also built into functions like `plot_umap()`.

## Operating System Package Versions

The code was developed in this OS:

```
R version: R version 4.4.2 (2024-10-31)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 20.04.6 LTS
```

The comments are the versions that the code was originally run under; several packages released updates as we worked on the project so we have also included the versions run when the manuscript figures were generated.

```
alakazam: 1.3.0
APackOfTheClones: 1.2.4
BiocParallel: 1.40.2
biomaRt: 2.62.0 # 2.58.2
CellChat: 2.1.0
celldex: 1.16.0 # 1.12.0
circlize: 0.4.16
clusterProfiler: 4.14.4
clustree: 0.5.1
ComplexHeatmap: 2.22.0 # 2.18.0
DESeq2: 1.46.0
DoubletFinder: 2.0.4 # 2.0.3
dowser: 2.3
DT: 0.33
edgeR: 4.4.1 # 4.0.16
enrichR: 3.0 # 3.2
future: 1.67.0
ggpubr: 0.6.0
ggrepel: 0.9.6
ggsignif: 0.6.4
ggtext: 0.1.2
ggtree: 3.14.0 # 3.10.1
ggVennDiagram: 1.5.2
here: 1.0.1
hues: 0.2.0
janitor: 2.2.1 # 2.2.0
jsonlite: 2.0.0 # 1.8.9
kableExtra: 1.4.0
knitr: 1.49 # 1.48
limma: 3.62.1 # 3.58.1
magrittr: 2.0.3
Matrix: 1.7.2
msigdbr: 7.5.1
Nebulosa: 1.16.0 # 1.12.1
pals: 1.9
patchwork: 1.3.0
peakRAM: 1.0.2
plyr: 1.8.9
purrr: 1.1.0
RColorBrewer: 1.1.3
reshape: 0.8.9
rjson: 0.2.23
rlang: 1.1.6 # 1.1.4
scales: 1.3.0
scCATCH: 3.2.2
scDblFinder: 1.20.0 # 1.16.0
scoper: 1.3.0
scRNAseq: 2.20.0 # 2.16.0
scuttle: 1.16.0 # 1.12.0
Seurat: 4.4.0
SeuratExtend: 1.2.5
SeuratObject: 4.1.4
shazam: 1.2.0
SingleCellExperiment: 1.28.1 # 1.24.0
SingleR: 2.8.0 # 2.4.1
tidyverse: 2.0.0
tximport: 1.34.0
xlsx: 0.6.5
```
