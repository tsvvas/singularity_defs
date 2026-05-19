options(
  repos = c(CRAN = "https://packagemanager.posit.co/cran/latest"),
  Ncpus = max(1L, parallel::detectCores(logical = TRUE) - 1L),
  timeout = 3600
)

Sys.setenv(
  R_REMOTES_NO_ERRORS_FROM_WARNINGS = "true"
)

if (!requireNamespace("pak", quietly = TRUE)) {
  install.packages("pak")
}


cran_packages <- c(
  "languageserver",
  "lintr",
  "styler",
  "httpgd",
  "jsonlite",
  "xml2",
  "roxygen2",
  "pkgload",
  "pkgbuild",
  "pkgdown",
  "testthat",
  "usethis",
  "withr",
  "renv",
  "here",
  "targets",
  "tarchetypes",
  "rmarkdown",
  "knitr",
  "quarto",
  "IRkernel",
  "argparse",
  "base64enc",
  "conflicted",
  "data.table",
  "dbscan",
  "digest",
  "DT",
  "evaluate",
  "filesstrings",
  "flashClust",
  "future",
  "future.apply",
  "ggalluvial",
  "ggplot2",
  "ggpubr",
  "glue",
  "gstat",
  "hdf5r",
  "hexbin",
  "highr",
  "htmltools",
  "janitor",
  "khroma",
  "magrittr",
  "Matrix",
  "openxlsx",
  "pals",
  "patchwork",
  "RANN",
  "reticulate",
  "rlang",
  "sp",
  "spatstat",
  "spdep",
  "sf",
  "stringi",
  "stringr",
  "terra",
  "tidyverse",
  "vctrs",
  "VennDiagram",
  "viridis",
  "xfun",
  "yaml"
)

bioc_packages <- c(
  "bioc::BiocNeighbors",
  "bioc::bluster",
  "bioc::DropletUtils",
  "bioc::ExperimentHub",
  "bioc::HDF5Array",
  "bioc::rhdf5",
  "bioc::scater",
  "bioc::scDblFinder",
  "bioc::scran",
  "bioc::scuttle",
  "bioc::SingleCellExperiment",
  "bioc::SummarizedExperiment",
  "bioc::UCell",
  "bioc::ComplexHeatmap",
  "bioc::DESeq2",
  "bioc::edgeR",
  "bioc::limma",
  "bioc::GSVA",
  "bioc::PCAtools",
  "bioc::SpatialExperiment",
  "bioc::SpatialFeatureExperiment",
  "bioc::Voyager",
  "bioc::ggspavis",
  "bioc::spatialLIBD",
  "bioc::Banksy",
  "bioc::BayesSpace",
  "bioc::nnSVG",
  "bioc::DESpace",
  "bioc::spicyR",
  "bioc::lisaClust",
  "bioc::spatialFDA",
  "bioc::FuseSOM",
  "bioc::scFeatures",
  "bioc::simpleSeg"
)

github_packages <- c(
  "satijalab/seurat",
  "satijalab/seurat-data",
  "satijalab/seurat-wrappers",
  "giotto-suite/Giotto",
  "giotto-suite/GiottoData",
  "immunogenomics/harmony",
  "carmonalab/STACAS",
  "carmonalab/ProjecTILs",
  "samuel-marsh/scCustomize",
  "saeyslab/nichenetr",
  "jinworks/CellChat",
  "jinworks/SpatialCellChat",
  "dmcable/spacexr",
  "xzhoulab/SPARK",
  "shangll123/SpatialPCA",
  "JEFworks-Lab/MERINGUE",
  "zdebruine/RcppML",
  "KlugerLab/ALRA", # Reuquired for cellchat
  "wjawaid/enrichR",
  "ManuelHentschel/vscDebugger"
)

all_packages <- unique(c(
  cran_packages,
  bioc_packages,
  github_packages
))

pak::pkg_install(
  all_packages,
  ask = FALSE,
  upgrade = FALSE,
  dependencies = c("Depends", "Imports", "LinkingTo")
)

IRkernel::installspec(user = FALSE)

required_packages <- c(
  "languageserver",
  "lintr",
  "styler",
  "httpgd",
  "testthat",
  "reticulate",
  "Seurat",
  "SeuratObject",
  "Giotto",
  "SingleCellExperiment",
  "SpatialExperiment",
  "Banksy",
  "BayesSpace",
  "CellChat",
  "nichenetr",
  "nnSVG",
  "DESpace",
  "SpatialFeatureExperiment",
  "Voyager",
  "ggspavis",
  "spatialLIBD",
  "spacexr"
)

failed_packages <- required_packages[
  !vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)
]

if (length(failed_packages)) {
  stop(
    "Packages failed to install/load: ",
    paste(failed_packages, collapse = ", ")
  )
}

reticulate::py_config()
