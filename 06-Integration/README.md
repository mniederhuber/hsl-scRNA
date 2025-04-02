# Integration

When analyzing single cell data we want to remove as much of the technical variation as possible, while leaving true biological variation alone.

We've already tried to remove the technical noise **between cells** by filtering low-quality droplets and normalizing.

But we still have **batch to batch** noise that needs to be accounted for. 

Batch effects are variations in measurement resulting from differences in...
- sample handling
- library preparation
- different chips / lanes
- phase of the moon

There are lots of reasons why these variations occur.

As an example, a small change in sample collection between days (or performed by different researchers) might mean greater cell stress in one prep versus another.

Stress can have a major impact of gene expression and the overall state of the cells may be just **a little different**. 

Because we are profiling expression in single cells, small differences add up to a significant batch effect. 

![https://inbre.ncgr.org/single-cell-workshop/Figures/integration.png](https://inbre.ncgr.org/single-cell-workshop/Figures/integration.png)
https://inbre.ncgr.org/single-cell-workshop/Figures/integration.png

# Resources

https://www.sc-best-practices.org/cellular_structure/integration.html
* specific to python but generally useful

https://jasonbiology.tokyo/2024/05/06/seurat-v5-sctransform-data-integration/

https://nbisweden.github.io/excelerate-scRNAseq/session-integration/Data_Integration.html

https://www.nature.com/articles/s41587-019-0113-3

https://www.nature.com/articles/s41592-021-01336-8#Sec2

https://inbre.ncgr.org/single-cell-workshop/integration.html