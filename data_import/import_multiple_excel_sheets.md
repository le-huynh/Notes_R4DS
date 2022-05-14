---
title: "Import multiple .xlsx sheets"
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
path <- here("data_import/data/lord_of_the_ring.xlsx")

data <- path %>%
	excel_sheets() %>%
	set_names() %>%
	map(read_excel, path = path, skip = 1)
data
```

```
## $Sheet1
## # A tibble: 3 x 3
##   Race   Female  Male
##   <chr>   <dbl> <dbl>
## 1 Elf      1229   971
## 2 Hobbit     14  3644
## 3 Man         0  1995
## 
## $Sheet2
## # A tibble: 3 x 3
##   Race   Female  Male
##   <chr>   <dbl> <dbl>
## 1 Elf       331   513
## 2 Hobbit      0  2463
## 3 Man       401  3589
## 
## $Sheet3
## # A tibble: 3 x 3
##   Race   Female  Male
##   <chr>   <dbl> <dbl>
## 1 Elf       183   510
## 2 Hobbit      2  2673
## 3 Man       268  2459
```

Add 1 column for each sheet


```r
film <- c("The Fellowship Of The Ring",
	"The Two Towers",
	"The Return Of The King")

for (i in seq_along(data)) {
	data[[i]] <- data[[i]] %>%
		add_column(Film = film[[i]])
}
data
```

```
## $Sheet1
## # A tibble: 3 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf      1229   971 The Fellowship Of The Ring
## 2 Hobbit     14  3644 The Fellowship Of The Ring
## 3 Man         0  1995 The Fellowship Of The Ring
## 
## $Sheet2
## # A tibble: 3 x 4
##   Race   Female  Male Film          
##   <chr>   <dbl> <dbl> <chr>         
## 1 Elf       331   513 The Two Towers
## 2 Hobbit      0  2463 The Two Towers
## 3 Man       401  3589 The Two Towers
## 
## $Sheet3
## # A tibble: 3 x 4
##   Race   Female  Male Film                  
##   <chr>   <dbl> <dbl> <chr>                 
## 1 Elf       183   510 The Return Of The King
## 2 Hobbit      2  2673 The Return Of The King
## 3 Man       268  2459 The Return Of The King
```

Write each sheet to a dataframe


```r
data %>%
	# add name for each list component
	setNames(c("fship", "ttow", "rking"))
```

```
## $fship
## # A tibble: 3 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf      1229   971 The Fellowship Of The Ring
## 2 Hobbit     14  3644 The Fellowship Of The Ring
## 3 Man         0  1995 The Fellowship Of The Ring
## 
## $ttow
## # A tibble: 3 x 4
##   Race   Female  Male Film          
##   <chr>   <dbl> <dbl> <chr>         
## 1 Elf       331   513 The Two Towers
## 2 Hobbit      0  2463 The Two Towers
## 3 Man       401  3589 The Two Towers
## 
## $rking
## # A tibble: 3 x 4
##   Race   Female  Male Film                  
##   <chr>   <dbl> <dbl> <chr>                 
## 1 Elf       183   510 The Return Of The King
## 2 Hobbit      2  2673 The Return Of The King
## 3 Man       268  2459 The Return Of The King
```

```r
data %>%
	setNames(c("fship", "ttow", "rking")) %>%
	# assign each list component into .GlobalEnv
	list2env(data, envir = .GlobalEnv)
```

```
## <environment: R_GlobalEnv>
```

```r
fship
```

```
## # A tibble: 3 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf      1229   971 The Fellowship Of The Ring
## 2 Hobbit     14  3644 The Fellowship Of The Ring
## 3 Man         0  1995 The Fellowship Of The Ring
```

```r
ttow
```

```
## # A tibble: 3 x 4
##   Race   Female  Male Film          
##   <chr>   <dbl> <dbl> <chr>         
## 1 Elf       331   513 The Two Towers
## 2 Hobbit      0  2463 The Two Towers
## 3 Man       401  3589 The Two Towers
```

```r
rking
```

```
## # A tibble: 3 x 4
##   Race   Female  Male Film                  
##   <chr>   <dbl> <dbl> <chr>                 
## 1 Elf       183   510 The Return Of The King
## 2 Hobbit      2  2673 The Return Of The King
## 3 Man       268  2459 The Return Of The King
```

Combine all sheets into 1 dataframe


```r
bind_rows(fship, ttow, rking)
```

```
## # A tibble: 9 x 4
##   Race   Female  Male Film                      
##   <chr>   <dbl> <dbl> <chr>                     
## 1 Elf      1229   971 The Fellowship Of The Ring
## 2 Hobbit     14  3644 The Fellowship Of The Ring
## 3 Man         0  1995 The Fellowship Of The Ring
## 4 Elf       331   513 The Two Towers            
## 5 Hobbit      0  2463 The Two Towers            
## 6 Man       401  3589 The Two Towers            
## 7 Elf       183   510 The Return Of The King    
## 8 Hobbit      2  2673 The Return Of The King    
## 9 Man       268  2459 The Return Of The King
```



---
author: LY
date: '2022-05-14'

---
