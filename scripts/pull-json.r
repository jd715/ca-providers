library(jsonlite)

# JSON
df <- fromJSON('https://bw-interviews.herokuapp.com/data/providers') %>% as.data.frame

write_csv(df,'outputs/data/api-data.csv')