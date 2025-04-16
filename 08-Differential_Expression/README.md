# Differential Expression Analysis

So far we have...
- QC and filtered data
- normlized and scaled with SCTransform
- performed PCA and initial UMAP
- integrated with Harmony
- clustered and found preliminary cell labels

Next we want to find the genes that define (are significantly different) across cell types / clusters/ conditions.

## Approaches to Differential Analysis 

- Single-cell differential analysis - comparing expression between groups of cells
- Pseudo-bulk - aggregating counts within groups to create "samples" for comparison

- **Finding marker genes with Seurat**:
  - `FindMarkers()` - pairwise comparison between identities
  - `FindAllMarkers()` - comparison of each cluster to all other clusters
  - Special handling for SCTransformed data using `PrepSCTFindMarkers()`

- **Visualizing differential expression**:
  - Heatmaps for top markers across clusters
  - Volcano plots for specific contrasts

- **Contrasting specific groups**:
  - Between clusters (e.g., CD8+ T cell subtypes)
  - Between conditions within cell types

- **Pseudo-bulk analysis**:
  - Aggregating counts with `AggregateExpression()`
  - Using DESeq2 for differential testing
  - Comparison with single-cell methods

## Practical Considerations

- Biological replicates are necessary for robust conclusions
- Single-cell analysis can inflate significance values compared to pseudo-bulk
- Parameters like `min.pct`, `logfc.threshold`, and `max.cells.per.ident` can help balance speed and statistical power

## Next Steps

After identifying differentially expressed genes:
- Gene set enrichment analysis (GSEA, GSVA)
- Gene ontology analysis 