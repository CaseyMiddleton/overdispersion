library(dplyr)

raw_df <- read.csv("contact_data.csv")
raw_df$id <- seq(1,length(raw_df$t))

# calculate contact durations
unique_contacts <- unique(select(raw_df, i, j))
duration_df <- data.frame(i = unique_contacts$i, j = unique_contacts$j)
duration_df$duration <- 0

for (id in raw_df$id){
  time = raw_df[raw_df$id == id,]$t
  jj = raw_df[raw_df$id == id,]$j
  ii = raw_df[raw_df$id == id,]$i
  
  prev_contacts <- raw_df[raw_df$t == time-20,]$j
  if( isin(jj, prev_contacts) ){
    duration_df[duration_df$i == ii & duration_df$j == jj,]$duration <- 
      duration_df[duration_df$i == ii & duration_df$j == jj,]$duration + 20
  }
}

ten_min_df <- duration_df[duration_df$duration >= 600,]





isin <- function(a, lst){
  for (val in lst){
    if(val == a){ return(TRUE) }
  }
  return(FALSE)
}
