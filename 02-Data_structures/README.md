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

Because it's the most common technology right now we'll use 10x Chromium data as our example case for this course, but the basic methods and concepts are generalizable across all single cell methods. 

## 10x Chromium

Chromium is a droplet based single cell method from 10x Genomics. 
There are assays for 3' or 5' capture, and can be combined with multiomic approaches (ATAC-seq).

The basic idea is a suspension of cells is combined with barcoded gel beads.
The cells are mixed with beads at a dilution such that **most beads do not bind a cell**.

<img src="https://cores.research.asu.edu/sites/default/files/inline-images/10X-reaction%20vesicle.png">

The bead-cell mixture is then passed through a microfluidic chip, mixed with enzyme, and then a oil channel 
separates single cells in a oil bubble. 
These Gel beads in EMulsion (GEMs) are collected and inside each GEM, the cell is lysed, RNA is reverse transcribed, and the DNA is barcoded. 

<img src="https://cdn.10xgenomics.com/image/upload/f_auto,q_auto,dpr_2.0,w_1200/v1723751588/products/Chromium/chromium-partitioning-library-prep.png">

The technical features of this protocol has important impacts on how we analzye and interpret single cell RNA data. 

1. The RNA from a single cell will have a unique barcode (UMI) that identifies that cell.

2. There will be many empty droplets that may have UMIs from the gel bead but no cell. 

3. Some/many cells will be dead or already lysed in the initial pool. 

4. The sensitivity of this technology is low -- we can only detect the top ~20% of RNA in a cell. 
