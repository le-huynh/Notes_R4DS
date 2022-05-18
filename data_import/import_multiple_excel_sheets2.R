#'---
#' title: "Import multiple .xlsx sheets_2"
#' output:
#'     html_document:
#'       keep_md: TRUE
#'---

#+ message=FALSE
library(here)
library(tidyverse)
library(readxl)

#' Import multiple .xlsx sheets
path <- here("data_import/data/river.xlsx")

path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path)

path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path) %>%
	# remove names of list elements
	set_names(NULL)

path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path) %>%
	set_names(NULL) %>%
	as.data.frame()

path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path) %>%
	set_names(NULL) %>%
	as.data.frame() %>%
	# there are 2 ".", replace first "." with "SPACE"
	rename_with(~ sub(".", "SPACE", .x, fixed = TRUE))

path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path) %>%
	set_names(NULL) %>%
	as.data.frame() %>%
	rename_with(~ sub(".", "SPACE", .x, fixed = TRUE)) %>%
	pivot_longer(cols = !ends_with("Date"),
		   names_to = c("river", ".value"),
		   names_pattern = "(.*)SPACE(.*)")

data <- path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path) %>%
	set_names(NULL) %>%
	as.data.frame() %>%
	rename_with(~ sub(".", "SPACE", .x, fixed = TRUE)) %>%
	pivot_longer(cols = !ends_with("Date"),
		   names_to = c("river", ".value"),
		   names_pattern = "(.*)SPACE(.*)") %>%
	rename_at(vars(ends_with(".unit")),
		list(~str_replace(., ".unit", "_conc")))

data

# remove duplicated columns ("date")
data[!duplicated(as.list(data))]

data[!duplicated(as.list(data))] %>%
	rename(date = r1SPACEdate)

data[!duplicated(as.list(data))] %>%
	rename(date = r1SPACEdate) %>%
	mutate(river = replace(river,
			   river == paste0("r", 1:2),
			   paste0("River", 1:2)))













