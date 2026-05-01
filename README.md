# 🗺️ ¿Cómo hacer un mapa del Perú en RStudio?

## 1. Conseguir los datos

Primero necesitas una base de datos en formato `.csv`. En mi caso usé resultados de elecciones por departamento (candidato ganador, votos y porcentaje).

---

## 2. Crear un proyecto en RStudio

Abrí RStudio y creé un nuevo proyecto para tener todo ordenado. Dentro del proyecto hice una carpeta llamada `datos` y ahí guardé mi archivo `.csv`.

---

## 3. Instalar los paquetes necesarios

Para que todo funcione, hay que instalar algunos paquetes:

```r
install.packages(c("sf", "ggplot2", "dplyr", "readr", "geodata", "stringi"))
```

---

## 4. Cargar las librerías

Luego cargué las librerías que voy a usar:

```r
library(sf)
library(ggplot2)
library(dplyr)
library(readr)
library(geodata)
library(stringi)
```

---

## 5. Importar los datos

Cargué mi archivo `.csv` desde la carpeta `datos`:

```r
datos_onpe <- read_csv("datos/datos_onpe_2026.csv")
```

---

## 6. Limpiar los datos

Aquí tuve que ordenar un poco los datos. Primero cambié los nombres de las columnas para que sean más fáciles de usar:

```r
datos_onpe <- datos_onpe %>%
  rename(
    candidato_ganador = `CANDIDATO GANADOR`,
    departamento = DEPARTAMENTO,
    votos = VOTOS,
    porcentaje = PORCENTAJE
  )
```

También eliminé las tildes y puse todo en mayúsculas para evitar errores al unir los datos:

```r
datos_onpe$departamento <- stri_trans_general(datos_onpe$departamento, "Latin-ASCII")
datos_onpe$departamento <- toupper(datos_onpe$departamento)
```

---

## 7. Obtener el mapa del Perú

Usé el paquete `geodata` para descargar automáticamente el mapa por departamentos:

```r
peru <- geodata::gadm(country = "PER", level = 1, path = ".")
peru <- st_as_sf(peru)
```

---

## 8. Preparar los nombres del mapa

Hice lo mismo con los nombres del mapa para que coincidan con mis datos:

```r
peru$NAME_1 <- stri_trans_general(peru$NAME_1, "Latin-ASCII")
peru$NAME_1 <- toupper(peru$NAME_1)
```

---

## 9. Unir los datos con el mapa

Luego uní mi base de datos con el mapa usando el nombre del departamento:

```r
mapa <- left_join(peru, datos_onpe, by = c("NAME_1" = "departamento"))
```

---

## 10. Crear el mapa

Finalmente, generé el mapa usando `ggplot2`:

```r
ggplot(mapa) +
  geom_sf(aes(fill = candidato_ganador)) +
  labs(title = "Resultados de las Elecciones Perú 2026",
       fill = "Candidato") +
  theme_minimal()
```

---

## 11. Guardar el mapa

Para terminar, guardé el mapa como imagen:

```r
ggsave("mapa_peru.png", width = 8, height = 6)
```

---

## 12. Conclusión

Con este proceso pude representar los resultados por departamento en un mapa. Me ayudó a visualizar mejor cómo se distribuyen los votos en el país de una forma más clara.

