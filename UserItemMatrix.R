library(ggplot2)
library(tidyverse)

# books rating Distributions

ratings %>%
  group_by(Book.Rating) %>%
  summarize(cases = n()) %>%
  ggplot(aes(Book.Rating, cases)) + geom_col() +
  theme_minimal() + scale_x_continuous(breaks = 0:10) 

# but this will include we have mostly books with no rating, since it will of no use to us
# hence we will remove those

ratings = ratings[ratings$Book.Rating != 0,] #now ratings will contains only non zero rating data
# ploting

ratings %>%
  group_by(Book.Rating) %>%
  summarize(cases = n()) %>%
  ggplot(aes(Book.Rating, cases)) + geom_col() +
  theme_minimal() + scale_x_continuous(breaks = 0:10) 


# ratings per person

ratings_sum = ratings %>%
  group_by(ratings$User.ID) %>% 
  count()

summary(ratings_sum)

# we see that 75% of people rated only 3 books 
# hence removing all who rated only 3 books or below

user_index = ratings_sum$`ratings$User.ID`[ratings_sum$n>4]
users = users[users$User.ID %in% user_index, ]
ratings = ratings[ratings$User.ID %in% user_index,]
books = books[books$ISBN %in% ratings$ISBN,]

library(tidyr)

user_item = ratings %>%
  top_n(10000) %>%
  pivot_wider(names_from = ISBN,values_from = Book.Rating) %>%
  as.data.frame()

row.names(user_item) = user_item$User.ID
user_item$User.ID = NULL
user_item = as.matrix(user_item)

#print(user_item[1:5,1:5])
#print("having many NAs is called sparsity")
#calculate sparsity

sum(is.na(user_item)) / (ncol(user_item)*nrow(user_item))
