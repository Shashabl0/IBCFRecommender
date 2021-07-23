library(dplyr)

summary(books) #looking into the datasets we have
summary(ratings)
summary(users)

set.seed(1234)
category = c("action","adventure","fantasy","fiction","documentary","horror")
books$category = sample(category,nrow(books),replace = TRUE,prob = c(0.4,0.35,0.6,0.3,0.1,0.15))
books$category = as.factor(books$category)

# Optional : removing category var
summary(books)


