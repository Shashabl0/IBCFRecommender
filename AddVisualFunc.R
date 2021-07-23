library(jpeg)
library(imager)

download <- function(name,img){
  #downloading file
  download.file(as.character(img),destfile = name,mode = "wb",quiet = TRUE)
  }


Visualise_recom <- function(recomendatiton,recommended_book,image,n_book = 3){
  if(n_book > nrow(recomendatiton)){
    n_book <- nrow(recomendatiton)
  }
  
  if(n_book>4){
    div = n_book%%3
    num = as.integer(n_book/3)
  }
  else{
    div = 1
    num = n_book
  }
  par(mfrow=c(div,num*3))
  
  dir = "IBCF_images"
  
  if(!file.exists(dir))
    dir.create(dir)
  
  for(i in 1:n_book){
    img = pull(recomendatiton[i,which(colnames(recomendatiton) == image)])
    name = paste0(dir,"/",i,".jpg")
    download(name,img)
    
    plot(load.image(name),axes= FALSE)
    }
}

downloadimg <- function(recomendatiton,recommended_book,image,n_book){
  dir = "IBCF_images"
  if(file.exists(dir))
      unlink(dir,recursive = TRUE)
  dir.create(dir)
  
  for(i in 1:n_book){
    img = pull(recomendatiton[i,which(colnames(recomendatiton) == image)])
    name = paste0(dir,"/",i,".jpg")
    download(name,img)
  }
}