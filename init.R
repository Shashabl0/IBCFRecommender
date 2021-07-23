#
# install packages necessary for UI and server
#

_packages_req <- c("tidyverse","imager","grid","gridExtra")

installing_packages <- function(p){
    if( p %in% rowname(installed_packages())==FALSE)
        install.packages(p)
}

invisible(sapply(_packages_req,installing_packages))