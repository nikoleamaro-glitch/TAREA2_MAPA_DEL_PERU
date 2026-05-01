list.files("datos")
[1] "datos_onpe_2026 - Hoja 1.csv"
> library(readr)
> 
  > datos_onpe <- read_csv("datos/datos_onpe_2026 - Hoja 1.csv")
  Rows: 25 Columns: 4                                                                                 
  ── Column specification ──────────────────────────────────────────────────────────────────────────────
  Delimiter: ","
  chr (2): CANDIDATO GANADOR, DEPARTAMENTO
  dbl (2): VOTOS, PORCENTAJE
  
  ℹ Use `spec()` to retrieve the full column specification for this data.
  ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
  > head(datos_onpe)
  # A tibble: 6 × 4
  `CANDIDATO GANADOR`              DEPARTAMENTO  VOTOS PORCENTAJE
  <chr>                            <chr>         <dbl>      <dbl>
    1 ROBERTO HELBERT SANCHEZ PALOMINO AMAZONAS      58213       36.3
  2 KEIKO SOFIA FUJIMORI HIGUCHI     ANCASH        95672       18.0
  3 ROBERTO HELBERT SANCHEZ PALOMINO APURIMAC      81091       41.0
  4 JORGE NIETO MONTESINOS           AREQUIPA     163273       18.7
  5 ROBERTO HELBERT SANCHEZ PALOMINO AYACUCHO      88382       31.3
  6 ROBERTO HELBERT SANCHEZ PALOMINO CAJAMARCA    264881       41.7
  > library(dplyr)
  
  Adjuntando el paquete: ‘dplyr’
  
  The following objects are masked from ‘package:stats’:
    
    filter, lag
  
  The following objects are masked from ‘package:base’:
    
    intersect, setdiff, setequal, union
  > 
    > datos_onpe <- datos_onpe %>%
    +     rename(
      +         candidato_ganador = `CANDIDATO GANADOR`,
      +         departamento = DEPARTAMENTO,
      +         votos = VOTOS,
      +         porcentaje = PORCENTAJE
      +     )
  > 
    > peru <- ne_states(country = "Peru", returnclass = "sf")
  Error en ne_states(country = "Peru", returnclass = "sf"): 
    no se pudo encontrar la función "ne_states"
  
  > install.packages("rnaturalearth")
  WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:
    
    https://cran.rstudio.com/bin/windows/Rtools/
    Installing package into ‘C:/Users/Nikol/AppData/Local/R/win-library/4.5’
  (as ‘lib’ is unspecified)
  probando la URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/rnaturalearth_1.2.0.zip'
  Content type 'application/zip' length 2121551 bytes (2.0 MB)
  downloaded 2.0 MB
  
  package ‘rnaturalearth’ successfully unpacked and MD5 sums checked
  
  The downloaded binary packages are in
  C:\Users\Nikol\AppData\Local\Temp\Rtmpghmof6\downloaded_packages
  > install.packages("rnaturalearthdata")
  WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:
    
    https://cran.rstudio.com/bin/windows/Rtools/
    Installing package into ‘C:/Users/Nikol/AppData/Local/R/win-library/4.5’
  (as ‘lib’ is unspecified)
  probando la URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/rnaturalearthdata_1.0.0.zip'
  Content type 'application/zip' length 3324888 bytes (3.2 MB)
  downloaded 3.2 MB
  
  package ‘rnaturalearthdata’ successfully unpacked and MD5 sums checked
  
  The downloaded binary packages are in
  C:\Users\Nikol\AppData\Local\Temp\Rtmpghmof6\downloaded_packages
  > library(rnaturalearth)
  > library(rnaturalearthdata)
  
  Adjuntando el paquete: ‘rnaturalearthdata’
  
  The following object is masked from ‘package:rnaturalearth’:
    
    countries110
  > peru <- ne_states(country = "Peru", returnclass = "sf")
  The rnaturalearthhires package needs to be installed.
  Install the rnaturalearthhires package? 
    
    1: Yes
  2: No
  
  Selection: 1
  Installing the rnaturalearthhires package.
  no hay paquete llamado ‘pak’
  Error en loadNamespace(x): no hay paquete llamado ‘rnaturalearthhires’
  
  > install.packages("geodata")
  WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:
    
    https://cran.rstudio.com/bin/windows/Rtools/
    Installing package into ‘C:/Users/Nikol/AppData/Local/R/win-library/4.5’
  (as ‘lib’ is unspecified)
  probando la URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/geodata_0.6-9.zip'
  Content type 'application/zip' length 272835 bytes (266 KB)
  downloaded 266 KB
  
  package ‘geodata’ successfully unpacked and MD5 sums checked
  
  The downloaded binary packages are in
  C:\Users\Nikol\AppData\Local\Temp\Rtmpghmof6\downloaded_packages
  > library(geodata)
  Cargando paquete requerido: terra
  terra 1.9.11
  > library(sf)
  Linking to GEOS 3.14.1, GDAL 3.12.1, PROJ 9.7.1; sf_use_s2() is TRUE
  > peru <- geodata::gadm(country = "PER", level = 1, path = ".")
  probando la URL 'https://geodata.ucdavis.edu/gadm/gadm4.1/pck/gadm41_PER_1_pk.rds'
  Content type 'unknown' length 1932917 bytes (1.8 MB)
  downloaded 1.8 MB
  
  Cached as: ./gadm/gadm41_PER_1_pk.rds
  > plot(peru)
  > datos_onpe$departamento <- toupper(datos_onpe$departamento)
  > peru$NAME_1 <- toupper(peru$NAME_1)
  > library(dplyr)
  > 
    > mapa <- left_join(peru, datos_onpe, by = c("NAME_1" = "departamento"))
  Error en UseMethod("left_join"): 
    no applicable method for 'left_join' applied to an object of class "SpatVector"
  
  > peru <- st_as_sf(peru)
  > mapa <- left_join(peru, datos_onpe, by = c("NAME_1" = "departamento"))
  > ggplot(mapa) +
    +     geom_sf(aes(fill = candidato_ganador)) +
    +     labs(title = "Resultados Elecciones Perú 2026") +
    +     theme_minimal()
  Error en ggplot(mapa): no se pudo encontrar la función "ggplot"
  
  > install.packages("ggplot2")
  WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:
    
    https://cran.rstudio.com/bin/windows/Rtools/
    Installing package into ‘C:/Users/Nikol/AppData/Local/R/win-library/4.5’
  (as ‘lib’ is unspecified)
  probando la URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/ggplot2_4.0.3.zip'
  Content type 'application/zip' length 8467695 bytes (8.1 MB)
  downloaded 8.1 MB
  
  package ‘ggplot2’ successfully unpacked and MD5 sums checked
  
  The downloaded binary packages are in
  C:\Users\Nikol\AppData\Local\Temp\Rtmpghmof6\downloaded_packages
  > library(ggplot2)
  > ggplot(mapa) +
    +     geom_sf(aes(fill = candidato_ganador)) +
    +     labs(title = "Resultados Elecciones Perú 2026") +
    +     theme_minimal()
  > 
    > ggplot(mapa) +
    +     geom_sf(aes(fill = candidato_ganador)) +
    +     labs(title = "Resultados Elecciones Perú 2026") +
    +     theme_minimal()
  > library(stringi)
  Error en library(stringi): no hay paquete llamado ‘stringi’
  
  > install.packages("stringi")
  WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:
    
    https://cran.rstudio.com/bin/windows/Rtools/
    Installing package into ‘C:/Users/Nikol/AppData/Local/R/win-library/4.5’
  (as ‘lib’ is unspecified)
  probando la URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/stringi_1.8.7.zip'
  Content type 'application/zip' length 15009790 bytes (14.3 MB)
  downloaded 14.3 MB
  
  package ‘stringi’ successfully unpacked and MD5 sums checked
  
  The downloaded binary packages are in
  C:\Users\Nikol\AppData\Local\Temp\Rtmpghmof6\downloaded_packages
  > library(stringi)
  > datos_onpe$departamento <- stri_trans_general(datos_onpe$departamento, "Latin-ASCII")
  > peru$NAME_1 <- stri_trans_general(peru$NAME_1, "Latin-ASCII")
  > 
    > datos_onpe$departamento <- toupper(datos_onpe$departamento)
  > peru$NAME_1 <- toupper(peru$NAME_1)
  > library(dplyr)
  > 
    > mapa <- left_join(peru, datos_onpe, by = c("NAME_1" = "departamento"))
  > library(ggplot2)
  > 
    > ggplot(mapa) +
    +     geom_sf(aes(fill = candidato_ganador)) +
    +     labs(title = "Resultados Elecciones Perú 2026") +
    +     theme_minimal()
  
  >