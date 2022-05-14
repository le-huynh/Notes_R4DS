---
title: Import multiple .csv files
output:
    html_document:
      keep_md: TRUE
---


```r
library(here)
library(tidyverse)

file_path = here("data_import", "data")
file_path
```

```
## [1] "C:/Users/LY/Google Drive/Git/note_R4DS/data_import/data"
```

```r
file_list = list.files(path = file_path,
		   recursive = TRUE,
		   pattern = "\\.csv$",
		   full.names = TRUE)
file_list
```

```
## [1] "C:/Users/LY/Google Drive/Git/note_R4DS/data_import/data/fellowship_of_the_ring.csv"
## [2] "C:/Users/LY/Google Drive/Git/note_R4DS/data_import/data/return_of_the_king.csv"    
## [3] "C:/Users/LY/Google Drive/Git/note_R4DS/data_import/data/two_towers.csv"
```

store all files in a list


```r
df = vector("list", length = length(file_list))
df
```

```
## [[1]]
## NULL
## 
## [[2]]
## NULL
## 
## [[3]]
## NULL
```

```r
# `for` loop
for (i in seq_along(file_list)) {
	df[[i]] <- read_csv(file_list[[i]])
}
```

```
## Rows: 3 Columns: 4
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (2): Race, Film
## dbl (2): Female, Male
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
## Rows: 3 Columns: 4
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (2): Race, Film
## dbl (2): Female, Male
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
## Rows: 3 Columns: 4
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (2): Race, Film
## dbl (2): Female, Male
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
df
```

```
## [[1]]
## # A tibble: 3 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf      1229   971 The Fellowship Of The Ring
## 2 Hobbit     14  3644 The Fellowship Of The Ring
## 3 Man         0  1995 The Fellowship Of The Ring
## 
## [[2]]
## # A tibble: 3 x 4
##   Race   Female  Male Film                  
##   <chr>   <dbl> <dbl> <chr>                 
## 1 Elf       183   510 The Return Of The King
## 2 Hobbit      2  2673 The Return Of The King
## 3 Man       268  2459 The Return Of The King
## 
## [[3]]
## # A tibble: 3 x 4
##   Race   Female  Male Film          
##   <chr>   <dbl> <dbl> <chr>         
## 1 Elf       331   513 The Two Towers
## 2 Hobbit      0  2463 The Two Towers
## 3 Man       401  3589 The Two Towers
```

```r
df2 <- lapply(file_list, read_csv)
```

```
## Rows: 3 Columns: 4
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (2): Race, Film
## dbl (2): Female, Male
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
## Rows: 3 Columns: 4
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (2): Race, Film
## dbl (2): Female, Male
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
## Rows: 3 Columns: 4
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (2): Race, Film
## dbl (2): Female, Male
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
df2
```

```
## [[1]]
## # A tibble: 3 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf      1229   971 The Fellowship Of The Ring
## 2 Hobbit     14  3644 The Fellowship Of The Ring
## 3 Man         0  1995 The Fellowship Of The Ring
## 
## [[2]]
## # A tibble: 3 x 4
##   Race   Female  Male Film                  
##   <chr>   <dbl> <dbl> <chr>                 
## 1 Elf       183   510 The Return Of The King
## 2 Hobbit      2  2673 The Return Of The King
## 3 Man       268  2459 The Return Of The King
## 
## [[3]]
## # A tibble: 3 x 4
##   Race   Female  Male Film          
##   <chr>   <dbl> <dbl> <chr>         
## 1 Elf       331   513 The Two Towers
## 2 Hobbit      0  2463 The Two Towers
## 3 Man       401  3589 The Two Towers
```

Combine all file to get 1 dataframe  
Option 1


```r
file_list %>%
	str_remove(paste0(file_path, "/"))
```

```
## [1] "fellowship_of_the_ring.csv" "return_of_the_king.csv"    
## [3] "two_towers.csv"
```

```r
file_name <- file_list %>% 
	str_remove(paste0(file_path, "/")) %>%
	str_remove(".csv")
file_name
```

```
## [1] "fellowship_of_the_ring" "return_of_the_king"     "two_towers"
```

```r
lapply(file_list, read_csv) %>%
	setNames(file_name) %>%
	list2env(envir = .GlobalEnv)
```

```
## Rows: 3 Columns: 4
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (2): Race, Film
## dbl (2): Female, Male
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
## Rows: 3 Columns: 4
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (2): Race, Film
## dbl (2): Female, Male
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
## Rows: 3 Columns: 4
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (2): Race, Film
## dbl (2): Female, Male
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```
## <environment: R_GlobalEnv>
```

```r
# fellowship_of_the_ring

# return_of_the_king

# two_towers
```

Option 2


```r
# use read_csv
read_csv(file_list)
```

```
## Rows: 9 Columns: 4
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (2): Race, Film
## dbl (2): Female, Male
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```
## # A tibble: 9 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf      1229   971 The Fellowship Of The Ring
## 2 Hobbit     14  3644 The Fellowship Of The Ring
## 3 Man         0  1995 The Fellowship Of The Ring
## 4 Elf       183   510 The Return Of The King    
## 5 Hobbit      2  2673 The Return Of The King    
## 6 Man       268  2459 The Return Of The King    
## 7 Elf       331   513 The Two Towers            
## 8 Hobbit      0  2463 The Two Towers            
## 9 Man       401  3589 The Two Towers
```

```r
read_csv(file_list, id = "file_name")
```

```
## Rows: 9 Columns: 5
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr (2): Race, Film
## dbl (2): Female, Male
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```
## # A tibble: 9 x 5
##   file_name                                             Race  Female  Male Film 
##   <chr>                                                 <chr>  <dbl> <dbl> <chr>
## 1 C:/Users/LY/Google Drive/Git/note_R4DS/data_import/d~ Elf     1229   971 The ~
## 2 C:/Users/LY/Google Drive/Git/note_R4DS/data_import/d~ Hobb~     14  3644 The ~
## 3 C:/Users/LY/Google Drive/Git/note_R4DS/data_import/d~ Man        0  1995 The ~
## 4 C:/Users/LY/Google Drive/Git/note_R4DS/data_import/d~ Elf      183   510 The ~
## 5 C:/Users/LY/Google Drive/Git/note_R4DS/data_import/d~ Hobb~      2  2673 The ~
## 6 C:/Users/LY/Google Drive/Git/note_R4DS/data_import/d~ Man      268  2459 The ~
## 7 C:/Users/LY/Google Drive/Git/note_R4DS/data_import/d~ Elf      331   513 The ~
## 8 C:/Users/LY/Google Drive/Git/note_R4DS/data_import/d~ Hobb~      0  2463 The ~
## 9 C:/Users/LY/Google Drive/Git/note_R4DS/data_import/d~ Man      401  3589 The ~
```



---
author: LY
date: '2022-05-14'

---
