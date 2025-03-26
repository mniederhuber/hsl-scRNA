# Dimensionality Reduction

After QC filtering and normalization the next step is normally to perform **dimensionality reduction** using `PCA` and `UMAP` most commonly. 

**WHY?** What does it mean to "reduced the dimensions" of our data and why is it important?

There are 2 reasons we do dimensionality reduction:
1. identify the sources of variance in the data - which we can then use for clustering
2. visualization - useful for data exploration

## High-dimensional data

Why do we say that single cell data is "high-dimensional"? 

Because for each cell in our sample/dataset there are counts for **thousands of genes**. 

In contrast, a "low-dimensional" dataset could be many cells with only 2 or 3 genes profiled in each cell.  

## Methods

### Principle Component Analysis (PCA)

A "linear" method that applies a linear transformation of the high-dimensionality data to identify the main sources of variation in the data (the Principle Components).

### Uniform Manifold Approximation and Projection (UMAP)

A "non-lineary" method to **project** high-dimensional data into 2 or 3 dimensions.

The goal of UMAP is to preserve both the local (nearby neigbors) and global (group to group) relationships when projecting the data into lower dimensions.

UMAP can be very useful for visualy exploring data but it is important not to draw strong conclusions from the spread of points as these projection methods can distort distances between cells and groups, making it look like there are similarities or differences that aren't really there in reality.

# Resources

- [Seurat v5 Dimensionality Reduction Vignette](https://satijalab.org/seurat/articles/dim_reduction_vignette)

- [StatQuest PCA](https://www.youtube.com/watch?v=HMOI_lkzW08&ab_channel=StatQuestwithJoshStarmer)

- [StatQuest UMAP](https://www.youtube.com/watch?v=eN0wFzBA4Sc&t=67s&ab_channel=StatQuestwithJoshStarmer)

- [HBC Training PCA](https://hbctraining.github.io/scRNA-seq/lessons/05_normalization_and_PCA.html)