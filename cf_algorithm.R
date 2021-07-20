
# from rating matrix we find the similarity between products.
# For this, there are different formulas: cosine similarity, Pearson’s correlation
# coefficient..Here I have used the cosine similarity.

source("CosineSimilarity.R")

item_recommendation <- function(book_id,rating_matrix = user_item,n_recommdation = 5){
  book_index <- which(colnames(rating_matrix) == book_id)
  similarity = apply(rating_matrix , 2, FUN = function(y)cos_similarity(rating_matrix[,book_index],y))
  
  recommendations = tibble(ISBN=names(similarity),similarity = similarity) %>%
    filter(ISBN != book_id) %>%
    top_n(n_recommdation,similarity) %>%
    arrange(desc(similarity))
  
  return(recommendations)   
  
}

