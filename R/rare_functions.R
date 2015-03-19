# rare_functions.R
# Calculates taxa that are permenantly rare across all or a subset of metadata categories

#' taxa/OTUs present in low abundance across a large proportion of samples 
#'
#' @param biom_object A biom-formatted OTU table
#' @param mapping A mapping file indicating metadata membership
#' @param proportion The cutoff proportion for defining an OTU as rare
#' @param coverage Proportion of samples within a metadata category where an OTU must be present
#' @return data frame with OTU \t coverage \t list of metadata categories wehre OTU is rare
#' @export
permanent_rare <- function(biom_object, mapping = mapping_table, proportion = 0.0001, coverage = 0.8) {
  print("Calculating permenantly rare taxa")
  
  # grab Matrix from biom_object
  biom_matrix <- biom_data(biom_object)
  
  # theshold defining what is meant by "rare"
  thresh_by_col <- colSums(biom_matrix) * proportion
  
  # remove OTUs that have coverage lower than the parameter (i.e., zeros values)
  otu_keep_mask <- rowSums(biom_matrix == 0) <= length(biom_matrix[1,]) * (1 - coverage)
  coverage_matrix <- biom_matrix[otu_keep_mask, ]
  
  # find all OTUs that are permenantly rare (testing commands for now)
  # all less than thresh_by_col
  is_rare_mask <- apply(coverage_matrix, 1, function(x) all(x < thresh_by_col))
  rare_matrix <- coverage_matrix[is_rare_mask,]
  
  # return data frame of OTU | mean proportion | median proportion | coverage
  #otus <- rownames(rare_matrix)
  otus <- rownames(coverage_matrix)[is_rare_mask]
  if(length(otus) == 0){
    # i.e., there were no permanently rare OTUs
    return("no permanently rare OTUs") # possibly return an empty table
  } else if(length(otus) == 1){
    mean_prop <- mean(rare_matrix)
    med_prop <- median(rare_matrix)
    prop_zeros <- sum(rare_matrix == 0) / length(rare_matrix)
  } else{
    proportions <- apply(rare_matrix, 1, function(x) x /colSums(biom_matrix))
    mean_prop <- apply(proportions, 2, mean)
    med_prop <- apply(proportions, 2, median)
    prop_zeros <- rowSums(rare_matrix == 0) / length(rare_matrix[1,])
  }
  rtable <- data.frame(otus, mean_prop, med_prop, prop_zeros)
  colnames(rtable) <- c("OTU", "MEAN_PROPORTION", "MEDIAN_PROPORTION", "COVERAGE")
  return(rtable)
}

#' Taxa present in low abundance within a subset of metadata conditions (ingroup) and abundant or absent
#' across remaining conditions (outgroup) 
#'
#' @param biom_object A biom-formatted OTU table
#' @param mapping A mapping file indicating metadata membership
#' @param proportion The cutoff proportion for defining an OTU as rare
#' @param ingroup_coverage Proportion of samples within a metadata category where an OTU must be present
#' @param outgroup_coverage Proportion of samples in other metadata categories where an OTU must be present
#' @return data frame with OTU \t Coverage \t median fold change \t list of ingroup metadata categories \t list of outgroup metadata categories
#' @export
transient_rare <- function(biom_object, mapping = mapping_table, proportion = 0.0001, 
                ingroup_coverage = 0.8, outgroup_coverage = 0.8){
  print("implement <trt>")
}

#' Identification of taxa/OTUs that are generally rare biosphere members but occasionally become abundant (after Shade et al. 2014) 
#'
#' @param biom_object A biom-formatted OTU table
#' @param mapping A mapping file indicating metadata membership
#' @param metadata The metadata category over which the potential condition occurs (e.g., time series)
#' @return data frame with OTU \t Coefficient of bimodality
#' @export
conditional_rare <- function(biom_object, mapping = mapping_table, metadata = "all"){
  print("implement <crt>")
}