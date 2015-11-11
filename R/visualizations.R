# Horizontal dotplot of indicator species (Cleveland plot)
#' Taxa present in low abundance within a subset of metadata conditions (ingroup) and abundant or absent
#' across remaining conditions (outgroup) 
#'
#' @param biom_object A biom-formatted OTU table
#' @param indval Cutoff value for indicator species value
#' @param abundance Either median or mean abundance value across metadata
#' @return ggplot2 object of a horizontal dotplot showing indicator species abundance changges among metadata categories
#' @export
indicator_plot <- function(indicator_table, indval = 0.7, abundance = "median"){
  filter_table <- indicator_table[ which(indicator_table$Indicator.Value < indval), ]
  # description:
  # have a horizontally facetted plot, one plot for each metadata category
  # for each indicator in the subet, plot median or mean for each metadata category
  # put indicator category as a header for each facetted plot
  metadata_cats <- unique(filter_table$Cluster)
  for (meta_cat in 1:length(metadata_cats)){
    # make a faceted plot
  }
  # save plot to file
  # return plot
  return(p)
}

# Time series visualiztion