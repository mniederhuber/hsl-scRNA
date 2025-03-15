# Normalization

## What's the point of normalization?

We want to remove as many of the technical sources of noise but keep biological sources of variability.

From Satija lab:

"[after effective normalization the] expression level of a gene should not be correlated with total sequencing depth of a cell."

"The variance of a normalized gene (across cells) should primarily reflect biological heterogeneity..."
ie. highly variable genes should reflect differences in cell type

## Why is it hard to normalize single cell data?

- variation in sequencing depth between cells - can be orders of magnitude different
- variation due to differences in...
    - cell lysis
    - RT efficiency
    - molecular sampling

## What are the main approaches?

### Scaling normalization

Divide the counts for each gene in each cell by a cell-specific scaling factor aka "size factor".
In other words, a single value (size factor) can represent the technical "bias" in a cell. Thus dividing the counts for each gene by this bias should remove it. 

<img src="https://github.com/mniederhuber/hsl-scRNA/images/scalingFactor.jpg">


# scTransform

>[!QUOTE]
>We propose that the Pearson residuals from “regularized negative binomial regression,” where cellular sequencing depth is utilized as a covariate in a generalized linear model, successfully remove the influence of technical characteristics from downstream analyses while preserving biological heterogeneity. 
>https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1874-1

negative binomial regression

pearson risiduals


