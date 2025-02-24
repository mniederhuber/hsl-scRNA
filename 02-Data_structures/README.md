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

The basic idea is that cell suspension is combined with barcoded gel beads at a limiting dilution such that **most beads do not bind a cell**. This means that most of the time if a bead binds a cell it will only bind a *single* cell.

The bead-cell mixture is then passed through a microfluidic chip, mixed with enzyme, and then a oil channel 
separates single cells in a oil bubble. 
These Gel beads in EMulsion (GEMs) are collected and inside each GEM, the cell is lysed, RNA is reverse transcribed, and the DNA is barcoded. 

<img src="https://cdn.10xgenomics.com/image/upload/f_auto,q_auto,dpr_2.0,w_1200/v1723751588/products/Chromium/chromium-partitioning-library-prep.png">

<img src="https://cores.research.asu.edu/sites/default/files/inline-images/10X-reaction%20vesicle.png" width="60%">

---
The technical features of this technology have important impacts on how we analzye and interpret the data. 

#### 1. Empty droplets
There will be many empty droplets that do not capture a cell. But because there is often contaminating free RNA in the suspension these "empty" droplets will have RNA and need to be computationally filtered out.  

#### 2. Multiplets
Beads can bind more than one cell.
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


# Sequencing depth

10x Genomics recommends at least 20k reads per cell. But this is pretty shallow and likely would limit the number of uniquely identified genes. In certain experiments, sequencing saturation isn't seen until close to ~50k paired reads per cell. 

<img src="/hsl-scRNA/images/Screenshot 2025-02-23 at 10.13.13 PM.png">

Examples of sensitivity metrics as a function of read depth for a dataset of ~4,000 PBMCs (3 replicates).
Somew

# Single Cell Data



# notes

- how many cells do you need per experiments
- read depth