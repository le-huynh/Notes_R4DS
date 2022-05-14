#'---
#' title: "Import multiple .xlsx sheets"
#' output:
#'     html_document:
#'       keep_md: TRUE
#'---

#+ message=FALSE
library(here)
library(tidyverse)
library(readxl)

#' Import multiple .xlsx sheets
path <- here("data_import/data/lord_of_the_ring.xlsx")

data <- path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path, skip = 1)
data

#' Add 1 column for each sheet
film <- c("The Fellowship Of The Ring",
	"The Two Towers",
	"The Return Of The King")

for (i in seq_along(data)) {
	data[[i]] <- data[[i]] %>%
		add_column(Film = film[[i]])
}
data

#' Write each sheet to a dataframe
data %>%
	# add name for each list component
	setNames(c("fship", "ttow", "rking"))
	
data %>%
	setNames(c("fship", "ttow", "rking")) %>%
	# assign each list component into .GlobalEnv
	list2env(data, envir = .GlobalEnv)

fship

ttow

rking

#' Combine all sheets into 1 dataframe
bind_rows(fship, ttow, rking)


