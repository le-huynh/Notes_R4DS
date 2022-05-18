---
title: "Import multiple .xlsx sheets_2"
output:
    html_document:
      keep_md: TRUE
---


```r
library(here)
library(tidyverse)
library(readxl)
```

Import multiple .xlsx sheets


```r
path <- here("data_import/data/river.xlsx")

path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path)
```

```
## $R1
## # A tibble: 3 x 3
##   r1.date r1.obs_TP.unit r1.sim_TP.unit
##   <chr>            <dbl>          <dbl>
## 1 a                    1             10
## 2 b                    2             20
## 3 c                    3             30
## 
## $R2
## # A tibble: 3 x 3
##   r2.date r2.obs_TP.unit r2.sim_TP.unit
##   <chr>            <dbl>          <dbl>
## 1 a                   10            101
## 2 b                   20            202
## 3 c                   30            303
```

```r
path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path) %>%
	# remove names of list elements
	set_names(NULL)
```

```
## [[1]]
## # A tibble: 3 x 3
##   r1.date r1.obs_TP.unit r1.sim_TP.unit
##   <chr>            <dbl>          <dbl>
## 1 a                    1             10
## 2 b                    2             20
## 3 c                    3             30
## 
## [[2]]
## # A tibble: 3 x 3
##   r2.date r2.obs_TP.unit r2.sim_TP.unit
##   <chr>            <dbl>          <dbl>
## 1 a                   10            101
## 2 b                   20            202
## 3 c                   30            303
```

```r
path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path) %>%
	set_names(NULL) %>%
	as.data.frame()
```

```
##   r1.date r1.obs_TP.unit r1.sim_TP.unit r2.date r2.obs_TP.unit r2.sim_TP.unit
## 1       a              1             10       a             10            101
## 2       b              2             20       b             20            202
## 3       c              3             30       c             30            303
```

```r
path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path) %>%
	set_names(NULL) %>%
	as.data.frame() %>%
	# there are 2 ".", replace first "." with "SPACE"
	rename_with(~ sub(".", "SPACE", .x, fixed = TRUE))
```

```
##   r1SPACEdate r1SPACEobs_TP.unit r1SPACEsim_TP.unit r2SPACEdate
## 1           a                  1                 10           a
## 2           b                  2                 20           b
## 3           c                  3                 30           c
##   r2SPACEobs_TP.unit r2SPACEsim_TP.unit
## 1                 10                101
## 2                 20                202
## 3                 30                303
```

```r
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
```

```
## # A tibble: 6 x 5
##   r1SPACEdate r2SPACEdate river obs_TP.unit sim_TP.unit
##   <chr>       <chr>       <chr>       <dbl>       <dbl>
## 1 a           a           r1              1          10
## 2 a           a           r2             10         101
## 3 b           b           r1              2          20
## 4 b           b           r2             20         202
## 5 c           c           r1              3          30
## 6 c           c           r2             30         303
```

```r
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
```

```
## # A tibble: 6 x 5
##   r1SPACEdate r2SPACEdate river obs_TP_conc sim_TP_conc
##   <chr>       <chr>       <chr>       <dbl>       <dbl>
## 1 a           a           r1              1          10
## 2 a           a           r2             10         101
## 3 b           b           r1              2          20
## 4 b           b           r2             20         202
## 5 c           c           r1              3          30
## 6 c           c           r2             30         303
```

```r
# remove duplicated columns ("date")
data[!duplicated(as.list(data))]
```

```
## # A tibble: 6 x 4
##   r1SPACEdate river obs_TP_conc sim_TP_conc
##   <chr>       <chr>       <dbl>       <dbl>
## 1 a           r1              1          10
## 2 a           r2             10         101
## 3 b           r1              2          20
## 4 b           r2             20         202
## 5 c           r1              3          30
## 6 c           r2             30         303
```

```r
data[!duplicated(as.list(data))] %>%
	rename(date = r1SPACEdate)
```

```
## # A tibble: 6 x 4
##   date  river obs_TP_conc sim_TP_conc
##   <chr> <chr>       <dbl>       <dbl>
## 1 a     r1              1          10
## 2 a     r2             10         101
## 3 b     r1              2          20
## 4 b     r2             20         202
## 5 c     r1              3          30
## 6 c     r2             30         303
```

```r
data[!duplicated(as.list(data))] %>%
	rename(date = r1SPACEdate) %>%
	mutate(river = replace(river,
			   river == paste0("r", 1:2),
			   paste0("River", 1:2)))
```

```
## # A tibble: 6 x 4
##   date  river  obs_TP_conc sim_TP_conc
##   <chr> <chr>        <dbl>       <dbl>
## 1 a     River1           1          10
## 2 a     River2          10         101
## 3 b     River1           2          20
## 4 b     River2          20         202
## 5 c     River1           3          30
## 6 c     River2          30         303
```



---
author: LY
date: '2022-05-18'

---
