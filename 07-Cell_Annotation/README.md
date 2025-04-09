# 07 - Cell Annotation

Annotating or labelling cell types is usually the key goal of any single-cell experiment. 

And like everything else in single-cell analysis labelling can be misleading if not approached carefully.

Generally, labelling can be either done manually - using known reference marker gene sets - or automatically with a number of different methods.

Most automated labelling methods use some kind of reference data set (single cell or bulk RNA) to match cells with similar gene expression profiles to reference labels. 

There are a growing number of deep learning and foundation model based approaches that have been developed in recent years, such as 
- (scGPT)[https://github.com/bowang-lab/scGPT]
- (scFoundation)[https://github.com/biomap-research/scFoundation]
- (SIMS)[https://github.com/jlehrer1/SIMS]

There are also several browser-based interfaces to upload your own data and annotate cells with curated references.
- (Aziumuth)[https://satijalab.org/azimuth/]