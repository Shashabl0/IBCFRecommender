

# implemented Cosine Similarity
cos_similarity <- function(A,B){
  NSum = sum(A*B,na.rm = TRUE)
  DSum = sqrt(sum(A^2,na.rm = TRUE)) * sqrt(sum(A^2,na.rm = TRUE))
  
  R = NSum/DSum
  return(R)
}