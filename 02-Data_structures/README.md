# 02 - scRNA-seq methods and data structures

Goals
- Review important technical features of standard single-cell methods.
- Look at standard 10x cellranger outputs
- Introduction to `Seurat` and the structure of Seurat objects
- Learn how to load data with `Seurat`

# Single Cell Methods

- Droplet – 10x Genomics Chromium
- Split seq – Parse Biosciences
- Imaging/Spatial single cell 
- 10x Visium (sequencing) 
- 10x Xenium (imaging)
- Complete Genomics Stereo-seq

<img src="https://www.completegenomics.com/media/cell-stereo-seq-complete-genomics.webp" width = '25%'> 

## 10x Genomics - Chromium

Because it's the most common assay right now we'll be using data from the 10x Genomics Chromium platform as our example case. 
But the basic methods and concepts are generalizable across all single cell methods. 

Chromium is a droplet based single cell method. There are assays for 3' or 5' capture, and can be combined with multiomic approaches (ATAC-seq).

The basic idea is that cell suspension is combined with barcoded gel beads at a limiting dilution such that **most beads do not pair with a cell**. This means that most of the time if only a single cell will end up with a bead in a droplet.

The bead-cell mixture is then passed through a microfluidic chip, mixed with enzyme, and then a oil channel 
separates single cells in a oil bubble. 
These Gel beads in EMulsion (GEMs) are collected and inside each GEM, the cell is lysed, RNA is reverse transcribed, and the DNA is barcoded. 

<img src="https://cdn.10xgenomics.com/image/upload/f_auto,q_auto,dpr_2.0,w_1200/v1723751588/products/Chromium/chromium-partitioning-library-prep.png">


<img src="https://cdn.10xgenomics.com/image/upload/f_auto,q_auto,w_900,dpr_2.0/v1709753672/blog/GEM-X%20Launch%20blog/vertical_flipped_GEM96_H1975_high_4_S0001.gif">

https://cdn.10xgenomics.com/image/upload/f_auto,q_auto,w_900,dpr_2.0/v1709753672/blog/GEM-X%20Launch%20blog/vertical_flipped_GEM96_H1975_high_4_S0001.gif

---
The technical features of this technology have important impacts on how we analzye and interpret the data. 

#### 1. Empty droplets
There will be many empty droplets that do not capture a cell. But because there is often contaminating free RNA in the suspension these "empty" droplets will have RNA and need to be computationally filtered out.  

#### 2. Multiplets
Beads can end up in a droplet with more than one cell.
A single bead could have a Tcell and a Macrophage  and consequently be a "single cell" in the data. These "doublets" or "multiplets" have to be filtered out.

#### 3. Dead cells
Some cells will be dead/dying and undergoing apoptosis. These have to be filtered out.

#### 4. Low mRNA capture efficiency
There are a number of technical factors of current single cell methods that significantly limit the rate at which mRNA is captured from a cell. 
- small ammount of mRNA per cell
- shallow sequencing depth per cell (~50k)
- inefficient oligo-mRNA binding
- inefficiences in reverse transcriptase reaction
- overall small reaction volume per cell

The newest 10x chemistries (v3) only capture around **20-30%** of mRNA per cell.

A low rate of mRNA capture is the biggest limitation of single cell methods. It means that the output data is very sparse - many genes have 0 counts - and it is difficult to know if this is due to technical "dropout" or a gene is simply not expressed. 

#### 5. High cell to cell variability
In single cell experiments there is a large ammount of cell-to-cell variability in the number or reads and number of genes detected. How to correctly normalize and model variability in single cell data is an active area of study. 


# Notes on experimental design

Like all genomics assays, analysis depends on experimental design. Mistakes in design can significantly limit analysis, costing researchers time and money. So it is important to have an idea about the main experimental parameters for successful single cell experiments.

## Number of cells
The number of cells per sample can impact how easily cell types are annotated. Fewer cells will make it difficult to detect rare populations. More cells means fewer reads per cell. 
Finding the right balance depends on the specifics of an experiment, number of samples, sequencing platform, and if samples are multiplexed. 

The newest 10x GEM-x chip and v4 chemistry are advertised to capture up to 20k cells per lane. Previous versions were 10k cells per lane.  
https://www.10xgenomics.com/blog/the-next-generation-of-single-cell-rna-seq-an-introduction-to-gem-x-technology

## Sequencing depth

How deeply to sequence single cell libraries is a balance of cost and desired sensitivity. Too few reads means the sampling of transcripts in a cell will be very sparse and thus you're more likely to only detect the most abundant mRNA species. Too many reads might mean wasted money for little additional sensitivity. That said, when money is not a concern, more reads are rarely a problem.

10x Genomics recommends at least 20k reads per cell. But this is pretty shallow and would likely undersample the number of uniquely identified genes. In certain experiments, sequencing saturation isn't seen until close to ~50k paired reads per cell. With the newer chemistries it seems to be even higher (>60k paired reads per cell; see link above). 

For example, from 10x Genomics has the following analysis using 4,000 peripheral blood mononuclear cells (PMBCs)...
![~4,000 PBMCs (3 replicates)](/images/seqDepth.png)
https://cdn.10xgenomics.com/image/upload/v1660261285/support-documents/CG000148_10x_Technical_Note_Resolving_Cell_Types_as_Function_of_Read_Depth_Cell_Number_RevA.pdf

You get close to saturation with 20k reads but there are still meaningful gains at higher depts. 

## Replicates

We need replicates for single cell! There is a lot of single replicate single cell data out there, but the absence of replicates signicantly impairs the power of single cell experiments. 
There is a great deal of variability in single cell data, both technical and biological, and like I mentioned above we can only sample a small portion of all mRNA in a cell. Replicates are critical to get a better handle on these sources of variability. 

As an axample, consider an experiment profiling immune cells within tumor samples +/- a new cancer treatment. 
With a single replicate we can get estimates of different immune cells are found within the tumor samples. 
We **cannot**:
- reliably measure proporitions of cell types between conditions (eg. are there fewer exhausted Tcells in one condition vs the other) 
- quantify changes in gene expression within cell types between conditions

Adding replicates is expensive, sometimes prohibitively so for new projects or when preparing grants. In these cases small single replicate pilots can be useful to get a sense of what types of cells are detectable and what type of sequencing depth is needed. But for robust analysis, we always want at least 2 but ideally 3+ replicates.

# Single Cell Data

The typical output that you'll receive after sequencing will be demultiplexed fastq files (assumming you have used a service/core that has demultiplexed for you). 

These will include fastqs for Read_1, Read_2, and a library index read (for demultiplexing a pooled library). 

<img src="https://davetang.org/muse/2018/06/06/10x-single-cell-bam-files/10x_library_fragment/" width="50%">

https://davetang.org/muse/2018/06/06/10x-single-cell-bam-files/  


You can see in this diagram that Read_1 is only used to capture the 10x barcode (unique cell identity) and the UMI (unique molecular identifier, specific to that mRNA). 

## Alignment and processing

We don't have time to work through how to process and align single cells fastq files. 

10x Genomics has their own set of tools for alignment (and demultiplexing, and making reference genomes) called `cellRanger`. \
https://www.10xgenomics.com/support/software/cell-ranger/latest

There is also the open source `alevin-fry` which is based on the popular `salmon` alogrithm for assigning RNA counts to transcripts rather than whole-genes. 
https://alevin-fry.readthedocs.io/en/latest/overview.html

`cellRanger` is very commonly used, but has the downside of not offering total control over processing. \
`alevin-fry` is open-source and thus offers a great deal of control over how reads and aligned and droplets are filtered. 

## `Cellranger` output

`cellRanger` aligns reads to a reference genome, counts reads in genes, and filters out likely empty droplets.

![](/images/cellrangerOut.jpg)

<img src="https://github.com/mniederhuber/hsl-scRNA/blob/main/images/cellrangerOut.jpg" width="50%">

The standard filtered output can be found in `outs/filtered_feature_bc_matrix`.
The directory contains files that together comprise a sparse matrix (only non-zero values recorded) in a MEX format of the counts data.

- barcodes.tsv -- all cell barcodes in matrix.mtx 
- genes.tsv -- all annotated genes, 2 columns (gene_id, gene_name)
- matrix.mtx -- 3 column file with header (gene_id, cell_id, umi_counts) 

https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/output/matrices

The unfiltered (all cells kept) data can be found under `raw_feature_bc_matrix` if you'd like to handle droplet filtering on your own.

`cellRanger` also generates the feature-barcode matrix in a Hierarchical Data Format (HDF5 or H5), which can be directly read by certain packages in R. 

# Seurat

>[!NOTE]
>This is all relative to Seurat v5

`Seurat` is a R package for loading, organizing, processing, and analyzing single cell data. 
It was developed (and is actively maintained) by the Satija lab at NYU. 
https://satijalab.org/seurat/

`Seurat` provides a data "container" to store many data structures in different "slots" and "layers" related to an analysis within a single R object. 

A seurat object contains multiple slots...

### @metadata 
A dataframe with row for each feature (gene), with related metadata like cell barcode, sample id, and anything else you want to add
### @assays 
A list of containers for each "assay". For most experiments there is only 1 "RNA" assay. Complex multi-modal experiments will have multiple "assay" slots, and some data transformations are stored in separate assay slots. Each assay has the following layers:
- raw counts `layers='counts'`
- normalized counts `layer='data'`
- variance stabilized data `layer='scale.data'`
- meta.features -- feature level metadata
- var.features -- vector of features identified as variable

By default, the raw data slot is filled when you first create a seurat object.

<img src="https://rnabio.org/assets/module_8/seurat_object.initial.png" width="50%">

credit: Griffith Lab https://rnabio.org/module-08-scrna/0008/02/01/QA_clustering/

### @reductions
A list of dimensionality reductions. 

# Scanpy

`Scanpy` is a library of tools for single cell analysis in Python. 
https://scanpy.readthedocs.io/en/stable/

We won't cover `Scanpy` but if you are more comfortable working in Python than R this might be a great option for you. It is also probably a better choice for working with spatial single cell assays where image visualization/analysis is a priority.
