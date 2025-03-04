# 03-Quality Control

We learned in our last section how single-cell methods have many inherent sources of noise - and thus a lot of our cells are noise.

A key step in analyzing single cell data is evualiting the "quality" of our data and deciding which cells to keep for analysis. 

Quality controlling single cell data is not an exact science. Many cells will not clearly fall into a "noise" or "signal" category, but fall somewhere in along the spectrum in between.

Determining which cells to keep and which to exclude is in part arbitrary.
But we can use some key QC metrics as guides in combination with our understanding of the specific sample and the goals of our experiment to rationally filter. 

## Single cell QC metrics

There are three main types of cell noise we want to mitigate:
- empty droplets
- dead cells 
- multiplets

### Empty Droplets 

For our purposes we'll stick with the empty droplet filtering done by `cellRanger`. 

<img src="https://cdn.10xgenomics.com/image/upload/v1682627718/software-support/3p-Single-Cell-GEX/barcode-rank-plot/BRP-1.png">

This plot shows barcodes (unique cells) on the x axis ranked from highest number of UMIs (unique RNA molecules) to lowest. UMI count is log scaled on the y axis.

`cellRanger` uses the `EmptyDrops` algorith (cited below) to classify background and true cells. 

A simple explanation of `EmptyDrops`:
- droplets with low UMI counts are assumed to mostly capture background RNA (ie are empty)
- counts in low UMI droplets are aggregated and used to model background RNA levels
- estimated background RNA is then used as a null hypothesis to test all droplets, droplets with significantly different gene expression from background are called as true cells

https://www.10xgenomics.com/support/software/cell-ranger/latest/algorithms-overview/cr-gex-algorithm#:~:text=cells%20is%201%2C137%3A-,Step,-2%3A%20Low%20RNA 

https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1662-y

A good quality sample will often have a "cliff" and "knee" pattern.
<img src="https://cdn.10xgenomics.com/image/upload/v1682627716/software-support/3p-Single-Cell-GEX/barcode-rank-plot/BRP-6.png" width='75%'>

This indicates clear separation of background droplets and droplets with intact cells. Plots that deviate from this pattern can potentially be a sign of problems so it's a good idea to review. 

### Dying cells

Apoptotic cells with disrupted membranes will lose cytoplasmic transcripts, but the mitochondria will often remain intact. 

This means that droplets with dying cells will have low UMI counts, low Feature counts, **and** a higher percentage of mitochondrial genes relative to the rest of the genome. 

While percentage of mitochondrial genes is a good metric to identify apoptotic cells, there are biological reasons for some cells to have high mitochondrial gene expression. 

Cells with high metabolic activity will have high levels of mitocondrial gene expression.

### Multiplets

Droplets with more than a single cell can make it seem like there are intermediate cell populations that aren't real. 

For the v3 chemistry 10x genomics estimates approximately 1% of cells are multiplets. 
https://kb.10xgenomics.com/hc/en-us/articles/360054599512-What-is-the-cell-multiplet-rate-when-using-the-3-CellPlex-Kit-for-Cell-Multiplexing. 

There are a number of strategies to identify and remove likely doublet/multiplet droplets.

A common approach is to assume that droplets with high numbers of genes detected are more likely to be doublets and only keep cells below an arbitrary cutoff. (eg. 2,500)
Or set a cutoff that is several standard deviations above the mean. 

Alternatively there are several computational tools. 
Two common computational approaches are...
- cluster analysis -- find doublet populations comprised of 2 "parental" clusters
- simulated data -- find cells that are "near" *in silico* generated pseudo-doublets 

## Final thoughts

There is no right way to filter single cell data.  

The decision of how to filter must be informed by your own review of the data, the clusters and cell anotations, in combiation with your understanding of the underlying biology. 

# Other resources

https://pmc.ncbi.nlm.nih.gov/articles/PMC9793662/
Analysis of common qc metrics across a variety of cell types.