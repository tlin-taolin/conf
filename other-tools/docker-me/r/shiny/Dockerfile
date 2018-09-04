## Based on rocker/hadleyverse maintained by Carl Boettiger and Dirk Eddelbuettel
FROM rocker/shiny

RUN apt-get -y update && apt-get -y install libxml2-dev 
RUN apt-get -y install libssl-dev



Run Rscript -e 'install.packages(pkgs= "shinyjs", dependencies = TRUE)'
RUN Rscript -e 'install.packages(pkgs = "devtools", dependencies = TRUE)'
RUN Rscript -e 'install.packages(pkgs = "qtl", dependencies = TRUE)'
RUN Rscript -e 'install.packages(pkgs = "qtlcharts", dependencies = TRUE)'
RUN Rscript -e 'install.packages(pkgs = "ggplot2", dependencies = TRUE)'
RUN Rscript -e 'install.packages(pkgs = "data.table", dependencies = TRUE)'
RUN Rscript -e 'devtools::install_github("simecek/intermediate")'
RUN Rscript -e 'source("https://bioconductor.org/biocLite.R"); biocLite("biomaRt")'
Run Rscript -e 'devtools::install_github("AnalytixWare/ShinySky")'
