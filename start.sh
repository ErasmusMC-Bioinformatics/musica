#!/bin/sh
set -e

# install these big packages on first start
#echo 'BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")' | Rscript -
#echo 'BiocManager::install("BSgenome.Hsapiens.1000genomes.hs37d5")' | Rscript -

echo 'shiny::runApp(port=8000, host="0.0.0.0", launch.browser=FALSE)' | Rscript -