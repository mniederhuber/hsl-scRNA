# Introduction to Single Cell RNA (scRNA) Technologies and Analysis Methods

Instructor - Matt Niederhuber Postdoc at the UNC [Bioinformatics and Analytics Research Collaborative](https://www.med.unc.edu/barc/) (BARC) \
TA - Tyler Interrante, Project Manager at BARC

This course is intended to introduce students to a basic workflow for analyzing scRNA data, as well as some of the concepts behind key analysis steps like normalization, integration, and dimensionality reduction.

There are 8 sections in this course and each has it's own R notebook that can either be run interactively or viewed as a static HTML. 

## Outline

01 - [Intro to OnDemand and R](01-Intro/README.md)
- We will cover how to connect to UNC OnDemand and start RStudio, as well as an introduction to programming in R and installing packages.
 
02 - [scRNA-seq methods and data structures](02-Data_structures/README.md)
- A brief review of scRNA-seq technologies (10x Genomics Chromium, Parse Biosciences, Complete Genomics Stereo-seq), and their data outputs. We will go over what some of these data look like and how they are organized. 
  
03 - [Quality control and cell filtering](03-Quality_control/README.md)
- We will go through best practices for assessing the quality of a scRNA dataset and methods for filtering potentially low-quality cells. 

04 - [Normalization and sample integration](04-Normalization/README.md)
- A description of different normalization methods and how to perform them with Seurat. We will also introduce the idea of sample integration (aka batch correction) and how to perform some of more common integration methods.

05 - Dimensionality reduction
- We will cover what dimensionality reduction is, types of reductions (PCA, TSNE, UMAP), how to perform them in Seurat, and some ways to assess reductions.  

06 - Clustering
- We will cover how to cluster data, different clustering methods, and some strategies for determining optimal parameters for clustering. 

07 - Annotating cell types
- We will cover how to identify cluster markers, annotate cell types with reference atlases, and annotate with other published sc datasets. 

08 - Differential Analysis 
- In this final class we will go through how to perform a pseudo-bulk differential gene expression analysis between different clusters/cell types identified in a sc dataset.

# How to follow along in this class

Each section will have an R notebook and a corresponding rendered html file. 

In each section we'll use the R notebook as an interactive guide. 

You are encouraged to start your own R notebook that you keep and add to during the course, hopefully by the end of the course you'll have a complete example analysis that you can reference. 
