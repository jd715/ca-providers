library(tidyverse)
library(rvest)

# Web Scrape

url = 'http://naccrrapps.naccrra.org/navy/directory/programs.php?program=omcc&state=CA&pagenum='

df_final = NULL
for (k in 1:48)
{
  content <- read_html(paste0(url, k))
  rows <-
    content %>% 
    html_nodes("td") %>% 
    html_text(trim = TRUE)
  
  print(paste0(url,k))
  df <- as.data.frame(matrix(rows[1:200], ncol = 8, byrow = TRUE))   #200 rows per page
  names(df) <- c("Provider Name", "Type of Care",
                 "Address", "City", "State", "Zip",
                 "Phone", "Email")
  df_final = rbind(df_final, df)
}

write_csv(df_final,'scraped_data.csv')