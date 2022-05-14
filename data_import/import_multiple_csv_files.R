#'---
#' title: Import multiple .csv files
#' output:
#'     html_document:
#'       keep_md: TRUE
#'---

#+ message=FALSE
library(here)
library(tidyverse)

file_path = here("data_import", "data")
file_path

file_list = list.files(path = file_path,
		   recursive = TRUE,
		   pattern = "\\.csv$",
		   full.names = TRUE)
file_list

#' store all files in a list
df = vector("list", length = length(file_list))
df

# `for` loop
for (i in seq_along(file_list)) {
	df[[i]] <- read_csv(file_list[[i]])
}

df

df2 <- lapply(file_list, read_csv)
df2

#' Combine all file to get 1 dataframe  
#' Option 1
file_list %>%
	str_remove(paste0(file_path, "/"))

file_name <- file_list %>% 
	str_remove(paste0(file_path, "/")) %>%
	str_remove(".csv")
file_name

lapply(file_list, read_csv) %>%
	setNames(file_name) %>%
	list2env(envir = .GlobalEnv)

# fellowship_of_the_ring

# return_of_the_king

# two_towers

#' Option 2
# use read_csv
read_csv(file_list)

read_csv(file_list, id = "file_name")


