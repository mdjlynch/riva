#' filter by rare biosphere as defined by it's contribution to beta diversity 
#'
#' @param biom_object A biom-formatted OTU table
#' @param mapping A mapping file indicating metadata membership
#' @param metadata category defining the beta diversity
#' @return biom subset corresponding to the rare biosphere
#' @export
rare_by_beta <- function(biom_object, mapping = mapping_table, category) {
  print("implement <rare_by_beta> function")
}