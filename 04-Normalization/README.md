# Normalization

## What's the point of normalization?

We want to remove as many of the technical sources of noise but keep biological sources of variability.

From Satija lab:

"[after effective normalization the] expression level of a gene should not be correlated with total sequencing depth of a cell."

"The variance of a normalized gene (across cells) should primarily reflect biological heterogeneity..."

ie. highly variable genes should reflect differences in cell type

## Why is it hard to normalize single cell data?

- variation in sequencing depth between cells - can be orders of magnitude different
- variation in counts due to differences in...
    - cell lysis
    - RT efficiency
    - molecular sampling
- many genes with 0 counts 

In other words, while library size (or per cell sequencing depth) is the main thing we want to control, there are a number of other technical factors that increase the variability of gene counts that make simple library normalization less robust. 

## What are the main approaches?

### Size-factor normalization

The basic approach is to calculate a "size-factor" for each cell that reflects cell-specific sequencing depth. 

This usually involves dividing gene counts by total counts in each cell (x some additional scaling factor). This method therefore accounts for differences in sequences depth, and allows us to call differential genes regardless of library size.

<img src="https://github.com/mniederhuber/hsl-scRNA/blob/04-Normalization/images/scalingFactor.jpg" width = "50%">

Here's a rough example:
> Imagine the same gene in 3 cells that have different read depths. 2 cells are the same type (green), and the other is a different type (magenta).\
> The raw counts of this gene are quite different between the three cells. It looks like this gene doesn't reflect the different cell types, but is pretty different in the same cell type. \
> We can calculate a scaling factor that captures the effect of the different read depths in each cell and then divide the counts by the scaling factor to get normalized counts. \
> The normalized counts now show that the gene is similar in the same cells and very different in the other cell type. 

But this depends on the assumption that all cells have roughly the same amount of RNA, because differences in total counts (UMIs) between cells should only reflect technical differences from library prep, sequencing depth, etc. 

This assumption falls apart when there's globally an increase or decrease in transcription, differences in total UMI counts are no longer a technicality but reflective of some underlying biology. This is rare, but in this case something like ERCC spike-ins would be needed instead.

### Size-factor from pools

Bulk RNA-seq normalization methods like RLE (relative log expression) and TMM (trimmed mean of M values) are two common strategies for normalizing bulk RNA-seq data. 

They try to overcome the assumption that (in this case samples) don't have large global changes in gene expression, by finding the most stable genes in the data and using those to calculate scaling-factors.

But these methods don't work well with single cell data because there are so many genes with 0 counts. 

The `scran` package attempts to overcome this for single cell by first pooling cells and then finding stable genes for normalization.

### Probabalistic modeling of counts

An alternative to size-factor normalization is to model the gene counts using a probability distribution. This gives us a per gene measure of average expression and variance, and thus avoids making assumptions across all cells / samples. 

# scTransform

While size-factor normalization does a decent job of controlling for differences in library size between cells, [Hafemeister and Satija, 2019](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1874-1) showed that highly expressed genes are not effectively normalized and exhibit distinct patterns.  

An alternative to size-factor normalization is to model the gene counts using a probability distribution. 

This gives us a per gene measure of average expression and variance, and thus avoids making assumptions across all cells / samples. 

The `sctransform` package from the Satija lab uses a **Regularized Negative Binomial Distribution** to model gene-wise counts across all cells. 

This approach may provide...
- better control of library size differences by modeling the relation of gene counts to total counts *per cell*
- improved handling of highly expressed and highly variable genes
- improved downstream dimensionality reduction and clustering 

>[!QUOTE]
>We propose that the Pearson residuals from “regularized negative binomial regression,” where cellular sequencing depth is utilized as a covariate in a generalized linear model, successfully remove the influence of technical characteristics from downstream analyses while preserving biological heterogeneity. 
>https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1874-1